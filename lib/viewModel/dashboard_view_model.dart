import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_app/model/food_items_details.dart';

class DashboardViewModel with ChangeNotifier {
  FoodItemsDeatils? foodItemsDeatils;
  List<Menu>? menuDeatilsList;
  Future<void> loadRestaurantData() async {
    String jsonString =
        await rootBundle.loadString('assets/food_items_json.json');
    Map<String, dynamic> jsonData = json.decode(jsonString);
    foodItemsDeatils = FoodItemsDeatils.fromJson(jsonData);
    menuDeatilsList = foodItemsDeatils?.restaurant?.menu;
    notifyListeners();
  }
}
