class FoodCategoryDeatils {
  List<FoodCategories>? foodCategories;

  FoodCategoryDeatils({this.foodCategories});

  FoodCategoryDeatils.fromJson(Map<String, dynamic> json) {
    if (json['foodCategories'] != null) {
      foodCategories = <FoodCategories>[];
      json['foodCategories'].forEach((v) {
        foodCategories!.add(new FoodCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodCategories != null) {
      data['foodCategories'] =
          this.foodCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodCategories {
  String? id;
  String? name;

  FoodCategories({this.id, this.name});

  FoodCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
