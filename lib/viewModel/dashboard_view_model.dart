import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_app/model/food_category_details.dart';
import 'package:sample_app/model/food_items_details.dart';

class DashboardViewModel with ChangeNotifier {
  FoodItemsDeatils? foodItemsDeatils;
  FoodCategoryDeatils? foodCategoryDeatils;
  List<Menu>? menuDeatilsList;
  List<FoodCategories>? categoryList;
  int count = 0;
  onAddItem() {
    count++;

    notifyListeners();
  }

  onRemoveItem() {
    if (count > 0) {
      count--;
    }else{
      count =0;
    }
    notifyListeners();
  }

  Future<void> loadRestaurantData() async {
    String jsonString =
        await rootBundle.loadString('assets/food_items_json.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    foodItemsDeatils = FoodItemsDeatils.fromJson(jsonData);
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
}
