class FoodItemsDetails {
  Restaurant? restaurant;

  FoodItemsDetails({this.restaurant});

  FoodItemsDetails.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'] != null
        ? Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (restaurant != null) {
      data['restaurant'] = restaurant!.toJson();
    }
    return data;
  }
}

class Restaurant {
  String? name;
  List<Menu>? menu;

  Restaurant({this.name, this.menu});

  Restaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    if (menu != null) {
      data['menu'] = menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  String? description;
  List<NutritionalInfo>? nutritionalInfo;

  Menu({
    this.id,
    this.name,
    this.imageUrl,
    this.price,
    this.description,
    this.nutritionalInfo,
  });

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    price = json['price'];
    description = json['description'];
    if (json['nutritional_info'] != null) {
      nutritionalInfo = <NutritionalInfo>[];
      json['nutritional_info'].forEach((v) {
        nutritionalInfo!.add(NutritionalInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['price'] = price;
    data['description'] = description;
    if (nutritionalInfo != null) {
      data['nutritional_info'] = nutritionalInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NutritionalInfo {
  String? nutritionName;
  int? value;

  NutritionalInfo({this.nutritionName, this.value});

  NutritionalInfo.fromJson(Map<String, dynamic> json) {
    nutritionName = json['nutrition_name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['nutrition_name'] = nutritionName;
    data['value'] = value;
    return data;
  }
}
