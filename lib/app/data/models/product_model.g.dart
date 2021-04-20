// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOverViewModel _$ProductOverViewModelFromJson(Map<String, dynamic> json) {
  return ProductOverViewModel(
    productNo: json['productNo'] as int,
    amount: json['amount'] as int,
    discount: json['discount'] as int,
    name: json['name'] as String,
    price: json['price'] as int,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$ProductOverViewModelToJson(
        ProductOverViewModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'name': instance.name,
      'price': instance.price,
      'amount': instance.amount,
      'discount': instance.discount,
      'imageUrl': instance.imageUrl,
    };

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) {
  return ProductDetailModel(
    discount: json['discount'] as int,
    amount: json['amount'] as int,
    shopImage: json['shopImage'],
    oldPrice: json['oldPrice'] as int,
    rating: (json['rating'] as num)?.toDouble(),
    productNo: json['productNo'] as int,
    name: json['name'] as String,
    price: json['price'] as int,
    imageUrls: (json['imageUrls'] as List)?.map((e) => e as String)?.toList(),
    shippingCost: json['shippingCost'] as int,
    shopLocation: json['shopLocation'] as String,
    shopName: json['shopName'],
    productProperties: (json['productProperties'] as List)
        ?.map((e) => e == null
            ? null
            : ProductPropertyModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productReviews: (json['productReviews'] as List)
        ?.map((e) => e == null
            ? null
            : ProductReviewModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'name': instance.name,
      'price': instance.price,
      'oldPrice': instance.oldPrice,
      'amount': instance.amount,
      'rating': instance.rating,
      'imageUrls': instance.imageUrls,
      'shippingCost': instance.shippingCost,
      'discount': instance.discount,
      'shopName': instance.shopName,
      'shopImage': instance.shopImage,
      'shopLocation': instance.shopLocation,
      'productProperties': instance.productProperties,
      'productReviews': instance.productReviews,
    };

ProductPropertyModel _$ProductPropertyModelFromJson(Map<String, dynamic> json) {
  return ProductPropertyModel(
    productNo: json['productNo'] as int,
    property: json['property'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$ProductPropertyModelToJson(
        ProductPropertyModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'property': instance.property,
      'content': instance.content,
    };

ProductReviewModel _$ProductReviewModelFromJson(Map<String, dynamic> json) {
  return ProductReviewModel(
    productNo: json['productNo'] as int,
    reviewNo: json['reviewNo'] as int,
    username: json['username'] as String,
    rating: json['rating'] as int,
    comment: json['comment'] as String,
    imageUrls: (json['imageUrls'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ProductReviewModelToJson(ProductReviewModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'reviewNo': instance.reviewNo,
      'username': instance.username,
      'rating': instance.rating,
      'comment': instance.comment,
      'imageUrls': instance.imageUrls,
    };

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) {
  return ProductModel(
    discount: json['discount'] as int,
    amount: json['amount'] as int,
    desc: json['desc'] as String,
    imageUrl: json['imageUrl'] as String,
    shopImage: json['shopImage'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    productNo: json['productNo'] as int,
    name: json['name'] as String,
    price: json['price'] as int,
    imageUrls: json['imageUrls'],
    shippingCost: json['shippingCost'] as int,
    shopLocation: json['shopLocation'] as String,
    shopName: json['shopName'] as String,
    productProperties: (json['productProperties'] as List)
        ?.map((e) => e == null
            ? null
            : ProductPropertyModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    productReviews: (json['productReviews'] as List)
        ?.map((e) => e == null
            ? null
            : ProductReviewModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'name': instance.name,
      'desc': instance.desc,
      'price': instance.price,
      'amount': instance.amount,
      'rating': instance.rating,
      'imageUrl': instance.imageUrl,
      'imageUrls': instance.imageUrls,
      'shippingCost': instance.shippingCost,
      'discount': instance.discount,
      'shopName': instance.shopName,
      'shopImage': instance.shopImage,
      'shopLocation': instance.shopLocation,
      'productProperties': instance.productProperties,
      'productReviews': instance.productReviews,
    };

FavoriteModel _$FavoriteModelFromJson(Map<String, dynamic> json) {
  return FavoriteModel(
    userNo: json['userNo'] as String,
    productNo: json['productNo'] as int,
  );
}

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'userNo': instance.userNo,
    };
