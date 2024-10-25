import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/model/food_category_details.dart';

import 'package:sample_app/model/food_items_details.dart';
import 'package:sample_app/res/reusable_widgets/custom_toast.dart';

class DashboardViewModel with ChangeNotifier {
  FoodItemsDetails? foodItemsDeatils;
  // List<Items>? menuDeatilsList;
  List<Categories>? totalCategoryList;
  List<NutritionalInfo>? nutritionalInfoList;
  List<AddedCartItemDetails>? cartItemsList = [];
  List<Items>? categoryWiseList;
  int? totalAmout;
  late TabController tabController;
  int selectedCategoryIndex = 0; // Track selected tab index
  double? individulaPrice;

  int count = 1;
  onAddItem(double? price) {
    count++;
    individulaPrice = (price ?? 0) * count;
    notifyListeners();
  }

  int cartItemCount = 1;

  void onIncrementOfCartItem(Items? menuItem) {
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

      individulaPrice = ((menuItem.price ?? 0) * (existingCartItem.count ?? 0));

      debugPrint("categorywise list  ${categoryWiseList?[0].price}");
      debugPrint("Incremented item count: ${existingCartItem.count}");
    } else {
      debugPrint("Item not found in cart");
    }
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
      individulaPrice = ((menuItem.price ?? 0) * (existingCartItem.count ?? 0));
      debugPrint("decremented item count: ${existingCartItem.count}");
      if (existingCartItem.count == 0) {
        cartItemsList?.removeAt(index);
      }
    } else {
      debugPrint("Item not found in cart");
    }
    notifyListeners();
  }

  resetCount() {
    count = 1;
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
        }

        notifyListeners();
      }
      Navigator.pop(context);
      CustomToast.show(
          context, 'Cart', '24 min. \$${dashboardProvider.individulaPrice}');
    } else {
      CustomToast.show(context, 'Add atleast one item to go to cart', '');
    }
    notifyListeners();
  }

  onRemoveItem(double? price) {
    if (count > 0) {
      count--;
    } else {
      count = 0;
    }
    individulaPrice = (price ?? 0) * count;
    notifyListeners();
  }

  void onRemoveFromCart(int index) {
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
}
