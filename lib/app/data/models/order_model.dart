import 'package:json_annotation/json_annotation.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderCreateModel {
  int id;
  String full_name;
  String address;
  String pay_method_name;
  String phone_number;
  List<int> voucher_ids;
  List<ProductCartModel> products;

  OrderCreateModel({
    this.id,
    this.address,
    this.pay_method_name,
    this.phone_number,
    this.full_name,
    this.products,
    this.voucher_ids,
  });

  factory OrderCreateModel.fromJson(Map<String, dynamic> json) =>
      _$OrderCreateModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderCreateModelToJson(this);
}

@JsonSerializable()
class ProductCartModel {
  int id;
  int count;

  ProductCartModel({
    this.id,
    this.count,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) =>
      _$ProductCartModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCartModelToJson(this);
}

@JsonSerializable()
class OrderModel {
  int id;
  int quantity;
  int total_price;
  @JsonKey(defaultValue: [])
  List<ProductOverViewModel> products;

  OrderModel({
    this.id,
    this.quantity,
    this.total_price,
    products,
  }) : products = products ?? [];

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
