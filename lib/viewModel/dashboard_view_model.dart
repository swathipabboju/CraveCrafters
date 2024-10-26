import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/added_cart_item_details.dart';

import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/model/payment_platform_model.dart';
import 'package:sample_app/res/custom_alerts/order_confirmed_screen.dart';
import 'package:sample_app/res/reusable_widgets/custom_toast.dart';
import 'package:sample_app/res/routes/app_routes.dart';

class DashboardViewModel with ChangeNotifier {
  bool isLoaderVisible = false;
  bool get getLoaderVisibilityStatus => isLoaderVisible;
  setLoaderVisibleStatus(bool status) {
    isLoaderVisible = status;
    notifyListeners();
  }

  FoodItemsDetails? foodItemsDeatils;
  // List<Items>? menuDeatilsList;
  List<Categories>? totalCategoryList;
  List<NutritionalInfo>? nutritionalInfoList;
  List<AddedCartItemDetails>? cartItemsList = [];
  List<Items>? categoryWiseList;
  int totalAmout = 0;
  late TabController tabController;
  int selectedCategoryIndex = 0; // Track selected tab index
  int? individulaPrice;

  int count = 1;
  onPay(BuildContext context) {
    if ((cartItemsList?.isNotEmpty ?? false) && (totalAmout != 0)) {
      Navigator.pushNamed(context, AppRoutes.orderConfirmed);
      cartItemsList?.clear();
    } else {
      debugPrint("elseee8r983473");
    }
    notifyListeners();
  }

  onAddItem(int? price) {
    count++;
    individulaPrice = (price ?? 0) * count;
    debugPrint("individulaPrice ${individulaPrice}");
    notifyListeners();
  }

  onRemoveItem(int? price) {
    if (count > 0) {
      count--;
    } else {
      count = 0;
    }
    individulaPrice = (price ?? 0) * count;
    notifyListeners();
  }

  void calculateTotalAmount() {
    if ((cartItemsList?.isNotEmpty ?? false) && cartItemsList != null) {
      totalAmout = cartItemsList!.fold(0, (sum, item) {
        // Using ?? operator to provide a default value if count or price is null
        final itemCount = item.count ?? 0;
        final itemPrice = item.cartItem?.price ?? 0.0;
        return sum + (itemCount * itemPrice).toInt();
      });
      debugPrint("totalamt in if ${totalAmout}");
    } else {
      totalAmout = 0;
      debugPrint("totalamt in if ${totalAmout}");
    }
    notifyListeners();
  }

  void onIncrementOfCartItem(Items? menuItem, int itemIndex) {
    if (menuItem == null) {
      debugPrint("Received null menuItem");
      return;
    }
    var existingCartItem = cartItemsList?.firstWhere(
      (element) => element.cartItem?.id == menuItem.id,
      orElse: () => AddedCartItemDetails(),
    );

    if (existingCartItem != null) {
      existingCartItem.count = (existingCartItem.count ?? 0) + 1;
    } else {
      debugPrint("Item not found in cart");
    }
    calculateTotalAmount();
    notifyListeners();
  }

  void onDecrementOfCartItem(Items? menuItem, int index) {
    if (menuItem == null) {
      debugPrint("Received null menuItem");
      return;
    }
    var existingCartItem = cartItemsList?.firstWhere(
      (element) => element.cartItem?.id == menuItem.id,
      orElse: () => AddedCartItemDetails(),
    );

    if (existingCartItem != null && (existingCartItem.count ?? 0) >= 1) {
      existingCartItem.count = (existingCartItem.count ?? 0) - 1;

      if (existingCartItem.count == 0) {
        cartItemsList?.removeAt(index);
      }
    } else {
      debugPrint("Item not found in cart");
    }
    calculateTotalAmount();
    notifyListeners();
  }

  resetCount(Items? selectedItem) {
    count = 1;
    individulaPrice = selectedItem?.price;
    notifyListeners();
  }

  void onAddToCart(Items? menuItem, BuildContext context) {
    final dashboardProvider =
        Provider.of<DashboardViewModel>(context, listen: false);
    if (menuItem == null) {
      debugPrint("Received null menuItem");
      return;
    }

    // Check if the item already exists in the cart
    var existingCartItem = cartItemsList?.firstWhere(
      (item) => item.cartItem?.id == menuItem.id,
      orElse: () => AddedCartItemDetails(),
    );
    if (count > 0) {
      if ((existingCartItem != null) &&
          (existingCartItem.cartItem != null &&
              ((existingCartItem.count ?? 0) > 0))) {
        existingCartItem.count = (existingCartItem.count ?? 0) + count;
        notifyListeners();
      } else {
        if (count > 0) {
          cartItemsList
              ?.add(AddedCartItemDetails(count: count, cartItem: menuItem));
          notifyListeners();
        }

        notifyListeners();
      }
      Navigator.pop(context);
      CustomToast.show(
          context, 'Cart', '24 min. \$${dashboardProvider.individulaPrice}');
    } else {
      CustomToast.show(context, 'Add atleast one item to go to cart', '');
    }
    calculateTotalAmount();
    notifyListeners();
  }

  /* void onRemoveFromCart(int index) {
    if (index < 0 || index >= (cartItemsList?.length ?? 0)) {
      debugPrint("Invalid index: $index");
      return;
    }

    if (cartItemsList?[index] != null) {
      if ((cartItemsList?[index].count ?? 0) >= 1) {
        cartItemsList?[index].count = (cartItemsList?[index].count ?? 0) - 1;
        notifyListeners();
      } else {
        // If the count is 1, remove the item from the list

        notifyListeners();
      }
    }

    notifyListeners(); // Notify listeners about the change
  }
 */
  getNutritionsInfo(Items menu) {
    nutritionalInfoList = menu.nutritionalInfo;
    notifyListeners(); // Return an empty list if the index is out of range or menuDeatilsList is null
  }

  void onCategoryTabChanged(int index, TabController tabController) {
    selectedCategoryIndex = index; // Update selected index
    tabController.animateTo(index); // Animate to selected tab
    categoryWiseList = totalCategoryList?[index].items;
    notifyListeners();
  }

  intializeCategorywiseList() {
    categoryWiseList = totalCategoryList?[selectedCategoryIndex].items;
    notifyListeners();
  }

  Future<void> loadRestaurantData() async {
    String jsonString =
        await rootBundle.loadString('assets/food_items_json.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    foodItemsDeatils = FoodItemsDetails.fromJson(jsonData);
    totalCategoryList = foodItemsDeatils?.restaurant?.categories;
    /*  menuDeatilsList = (totalCategoryList
                ?.expand((category) => category.items ?? [])
                .toList() ??
            [])
        .cast<Items>(); */
    notifyListeners();
  }

  List<PaymentPlatform>? paymentPlatforms;
  PaymentPlatform? selectedPlatform;
  onSelectedPlatform(PaymentPlatform? newValue) {
    selectedPlatform = newValue;
    notifyListeners();
  }

  Future<void> loadPaymentPlatformData() async {
    final String response =
        await rootBundle.loadString('assets/payment_platform_json.json');
    final List<dynamic> data = json.decode(response);

    paymentPlatforms =
        data.map((json) => PaymentPlatform.fromJson(json)).toList();
    selectedPlatform = (paymentPlatforms ?? []).isNotEmpty
        ? paymentPlatforms?.first
        : null; // Set default
    notifyListeners();
  }
}
