// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderCreateModel _$OrderCreateModelFromJson(Map<String, dynamic> json) {
  return OrderCreateModel(
    id: json['id'] as int,
    address: json['address'] as String,
    pay_method_name: json['pay_method_name'] as String,
    phone_number: json['phone_number'] as String,
    full_name: json['full_name'] as String,
    product_ids: (json['product_ids'] as List)
        ?.map((e) => e == null
            ? null
            : ProductCartModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    voucher_ids: (json['voucher_ids'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$OrderCreateModelToJson(OrderCreateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.full_name,
      'address': instance.address,
      'pay_method_name': instance.pay_method_name,
      'phone_number': instance.phone_number,
      'voucher_ids': instance.voucher_ids,
      'product_ids': instance.product_ids,
    };

ProductCartModel _$ProductCartModelFromJson(Map<String, dynamic> json) {
  return ProductCartModel(
    id: json['id'] as int,
    count_product_cart: json['count_product_cart'] as int,
  );
}

Map<String, dynamic> _$ProductCartModelToJson(ProductCartModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'count_product_cart': instance.count_product_cart,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    id: json['id'] as int,
    quantity: json['quantity'] as int,
    total_price: json['total_price'] as int,
    order_status: json['order_status'] as String,
    products: (json['products'] as List)
        ?.map((e) =>
    e == null
        ? null
        : ProductOverViewModel.fromJson(e as Map<String, dynamic>))
        ?.toList() ??
        [],
    created_at: json['created_at'] as String,
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
      'created_at': instance.created_at,
      'order_status': instance.order_status,
      'total_price': instance.total_price,
      'products': instance.products,
    };
