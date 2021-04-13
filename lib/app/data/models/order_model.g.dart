// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    orderNo: json['orderNo'] as int,
    productNo: json['productNo'] as int,
    status: json['status'] as String,
    createAt: json['createAt'] == null
        ? null
        : DateTime.parse(json['createAt'] as String),
    userNo: json['userNo'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'productNo': instance.productNo,
      'userNo': instance.userNo,
      'status': instance.status,
      'createAt': instance.createAt?.toIso8601String(),
      'quantity': instance.quantity,
    };
