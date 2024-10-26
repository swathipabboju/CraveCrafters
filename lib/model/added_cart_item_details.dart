import 'package:sample_app/model/food_items_details.dart';

class AddedCartItemDetails {
  int? count;
  int? calculatedprice;
  Items? cartItem;
  AddedCartItemDetails({this.count, this.cartItem});
  AddedCartItemDetails.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    calculatedprice = json["calculatedprice"];
    cartItem =
        json['cartItem'] != null ? new Items.fromJson(json['cartItem']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['calculatedprice'] = this.calculatedprice;
    if (this.cartItem != null) {
      data['cartItem'] = this.cartItem!.toJson();
    }
    return data;
  }
}
