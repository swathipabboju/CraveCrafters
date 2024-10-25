class FoodItemsDetails {
  Restaurant? restaurant;

  FoodItemsDetails({this.restaurant});

  FoodItemsDetails.fromJson(Map<String, dynamic> json) {
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    return data;
  }
}

class Restaurant {
  String? name;
  List<Categories>? categories;

  Restaurant({this.name, this.categories});

  Restaurant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? categoryName;
  int? categoryId;
  List<Items>? items;

  Categories({this.categoryName, this.categoryId, this.items});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? imageUrl;
  double? price;
  String? description;
  List<NutritionalInfo>? nutritionalInfo;

  Items(
      {this.id,
      this.name,
      this.imageUrl,
      this.price,
      this.description,
      this.nutritionalInfo});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image_url'];
    price = json['price'];
    description = json['description'];
    if (json['nutritional_info'] != null) {
      nutritionalInfo = <NutritionalInfo>[];
      json['nutritional_info'].forEach((v) {
        nutritionalInfo!.add(new NutritionalInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    data['description'] = this.description;
    if (this.nutritionalInfo != null) {
      data['nutritional_info'] =
          this.nutritionalInfo!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nutrition_name'] = this.nutritionName;
    data['value'] = this.value;
    return data;
  }
}
