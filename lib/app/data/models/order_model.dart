import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:json_annotation/json_annotation.dart';

import 'package:scrum_app/app/data/models/product_model.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  int orderNo;
  int productNo;
  String userNo;
  String status;
  DateTime createAt;
  int quantity;

  @JsonKey(ignore: true)
  ProductOverViewModel product;
  @JsonKey(ignore: true)
  String customerName;
  @JsonKey(ignore: true)
  bool isChecked;
  @JsonKey(ignore: true)
  TextEditingController quantityController = TextEditingController();

  int get getPriceOrder => this.quantity * this.product.price;

  String get getCreateAt => DateFormat('HH:mm dd-MM-yyyy').format(createAt);

  String get getShortDate => DateFormat('HH:mm dd-MM').format(createAt);

  OrderModel(
      {this.orderNo,
        this.productNo,
        this.status,
        this.createAt,
        this.userNo,
        this.product,
        this.quantity,
        this.isChecked = false});

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}