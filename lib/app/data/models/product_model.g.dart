// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOverViewModel _$ProductOverViewModelFromJson(Map<String, dynamic> json) {
  return ProductOverViewModel(
    id: json['id'] as int,
    count: json['count'] as int,
    count_purchased: json['count_purchased'] as int,
    rating: (json['rating'] as num)?.toDouble(),
    discount: json['discount'] as int,
    name: json['name'] as String,
    price: json['price'] as int,
    link_image: json['link_image'] as String,
  );
}

Map<String, dynamic> _$ProductOverViewModelToJson(
        ProductOverViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'count': instance.count,
      'count_purchased': instance.count_purchased,
      'rating': instance.rating,
      'discount': instance.discount,
      'link_image': instance.link_image,
    };

ProductDetailModel _$ProductDetailModelFromJson(Map<String, dynamic> json) {
  return ProductDetailModel(
    discount: json['discount'] as int,
    count: json['count'] as int,
    shopImage: json['shopImage'],
    oldPrice: json['oldPrice'] as int,
    rating: (json['rating'] as num)?.toDouble(),
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    link_image: json['link_image'] as String,
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
  )..count_purchased = json['count_purchased'] as int;
}

Map<String, dynamic> _$ProductDetailModelToJson(ProductDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'link_image': instance.link_image,
      'price': instance.price,
      'count': instance.count,
      'count_purchased': instance.count_purchased,
      'rating': instance.rating,
      'oldPrice': instance.oldPrice,
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
    id: json['id'] as int,
    product_id: json['product_id'] as int,
    reviewer: json['reviewer'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    comment: json['comment'] as String,
    photo_urls: json['photo_urls'] ?? [],
  );
}

Map<String, dynamic> _$ProductReviewModelToJson(ProductReviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.product_id,
      'reviewer': instance.reviewer,
      'rating': instance.rating,
      'comment': instance.comment,
      'photo_urls': instance.photo_urls,
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
    imageUrls:
        (json['imageUrls'] as List)?.map((e) => e as String)?.toList() ?? [],
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
    favoriteNo: json['favoriteNo'] as int,
    productNo: json['productNo'] as int,
  );
}

Map<String, dynamic> _$FavoriteModelToJson(FavoriteModel instance) =>
    <String, dynamic>{
      'favoriteNo': instance.favoriteNo,
      'productNo': instance.productNo,
      'userNo': instance.userNo,
    };
