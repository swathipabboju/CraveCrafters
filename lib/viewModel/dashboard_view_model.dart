import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_app/model/food_category_details.dart';
import 'package:sample_app/model/food_items_details.dart';

class DashboardViewModel with ChangeNotifier {
  FoodItemsDetails? foodItemsDeatils;
  FoodCategoryDeatils? foodCategoryDeatils;
  List<Menu>? menuDeatilsList;
  List<FoodCategories>? categoryList;
  List<NutritionalInfo>? nutritionalInfoList;
  List<Menu> cartItemsList =[];

  int? totalAmout;

  int count = 1;
  onAddItem() {
    count++;
    notifyListeners();
  }

  onRemoveItem() {
    if (count > 0) {
      count--;
    } else {
      count = 0;
    }
    notifyListeners();
  }

  getNutritionsInfo(Menu menu) {
    nutritionalInfoList = menu.nutritionalInfo;
    notifyListeners(); // Return an empty list if the index is out of range or menuDeatilsList is null
  }

  Future<void> loadRestaurantData() async {
    String jsonString =
        await rootBundle.loadString('assets/food_items_json.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    foodItemsDeatils = FoodItemsDetails.fromJson(jsonData);
    menuDeatilsList = foodItemsDeatils?.restaurant?.menu;
    notifyListeners();
  }

  Future<void> loadFoodCategoryData() async {
    String jsonString =
        await rootBundle.loadString('assets/food_category.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    foodCategoryDeatils = FoodCategoryDeatils.fromJson(jsonData);
    categoryList = foodCategoryDeatils?.foodCategories;
    notifyListeners();
  }

  onAddToCart(Menu addedItem) {
    
  cartItemsList.add(addedItem);
  debugPrint("added item ${cartItemsList.length}, item ${addedItem.toJson()}");
    notifyListeners();
  }
}
