import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductOverViewModel {
  int productNo;
  String name;
  int price;
  int amount;
  int discount;
  String imageUrl;

  ProductOverViewModel(
      {this.productNo,
      this.amount,
      this.discount,
      this.name,
      this.price,
      this.imageUrl});

  factory ProductOverViewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOverViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOverViewModelToJson(this);
}

@JsonSerializable()
class ProductDetailModel {
  int productNo;
  String name;
  int price;
  int oldPrice;
  int amount;
  double rating;
  List<String> imageUrls;
  int shippingCost;
  int discount;
  String shopName;
  String shopImage;
  String shopLocation;
  List<ProductPropertyModel> productProperties;
  List<ProductReviewModel> productReviews;

  ProductDetailModel(
      {this.discount,
      this.amount,
      shopImage,
      this.oldPrice,
      this.rating,
      this.productNo,
      this.name,
      this.price,
      this.imageUrls,
      this.shippingCost,
      this.shopLocation,
      shopName,
      this.productProperties,
      this.productReviews})
      : shopName = shopName ?? 'thegioibanve',
        shopImage = shopImage ??
            'https://firebasestorage.googleapis.com/v0/b/shoponline-69684.appspot.com/o/images%2Fae86abf7-1e7f-43fc-bc99-4f6077c6422d3398657205301469443.jp?alt=media&token=d3089516-9931-4c85-8602-9ebd0b3844e7';

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}

@JsonSerializable()
class ProductPropertyModel {
  int productNo;
  String property;
  String content;

  ProductPropertyModel({
    this.productNo,
    this.property,
    this.content,
  });

  factory ProductPropertyModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPropertyModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPropertyModelToJson(this);
}

@JsonSerializable()
class ProductReviewModel {
  int productNo;
  int reviewNo;
  String username;
  int rating;
  String comment;
  List<String> imageUrls;

  ProductReviewModel(
      {this.productNo,
      this.reviewNo,
      this.username,
      this.rating,
      this.comment,
      this.imageUrls});

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  int productNo;
  String name;
  String desc;
  int price;
  int amount;
  double rating;
  String imageUrl;
  @JsonKey(defaultValue: [])
  List<String> imageUrls;
  int shippingCost;
  int discount;
  String shopName;
  String shopImage;
  String shopLocation;
  List<ProductPropertyModel> productProperties;
  List<ProductReviewModel> productReviews;

  ProductModel(
      {this.discount,
      this.amount,
      this.desc,
      this.imageUrl,
      this.shopImage,
      this.rating,
      this.productNo,
      this.name,
      this.price,
      imageUrls,
      this.shippingCost,
      this.shopLocation,
      this.shopName,
      this.productProperties,
      this.productReviews})
      : imageUrls = imageUrls ?? [];

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
