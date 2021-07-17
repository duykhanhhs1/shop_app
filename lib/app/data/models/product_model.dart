import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductOverViewModel {
  int id;
  String name;
  int price;
  int count;
  int count_purchased;
  double rating;
  int discount;
  dynamic link_image;

  @JsonKey(ignore: true)
  bool isFavorite;
  @JsonKey(ignore: true)
  bool isChecked;
  @JsonKey(ignore: true)
  TextEditingController quantityController = TextEditingController();

  int get getPriceCart => this.count * this.price;

  ProductOverViewModel(
      {this.id,
      this.count,
      this.count_purchased,
      this.rating,
      this.discount,
      this.name,
      this.price,
      this.isFavorite = false,
      this.isChecked = false,
      this.link_image});

  factory ProductOverViewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOverViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOverViewModelToJson(this);
}

@JsonSerializable()
class ProductDetailModel {
  int id;
  String name;
  String description;
  String link_image;
  int price;
  int count;
  int count_purchased;
  double rating;

  int oldPrice;
  List<String> imageUrls;
  int shippingCost;
  int discount;
  String name_shop;
  String shop_link_image;
  String shopLocation;
  List<ProductPropertyModel> productProperties;
  List<ProductReviewModel> productReviews;

  @JsonKey(ignore: true)
  int quantity;

  ProductDetailModel(
      {this.discount,
      this.count,
      shop_link_image,
      this.oldPrice,
      this.rating,
      this.quantity = 1,
      this.id,
      this.name,
      this.description,
      this.link_image,
      this.price,
      this.imageUrls,
      this.shippingCost,
      this.shopLocation,
      name_shop,
      this.productProperties,
      this.productReviews})
      : name_shop = name_shop ?? 'thegioibanve',
        shop_link_image = shop_link_image ??
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
  int id;
  int product_id;
  String reviewer_name;
  double rating;
  String comment;
  @JsonKey(defaultValue: [])
  List<dynamic> photo_urls;

  ProductReviewModel(
      {this.id,
      this.product_id,
      this.reviewer_name,
      this.rating,
      this.comment,
      photo_urls})
      : photo_urls = photo_urls ?? [];

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

  @JsonKey(ignore: true)
  bool isChecked;

  ProductModel({this.discount,
    this.isChecked = false,
    this.amount,
    this.desc,
    this.imageUrl,
    this.shopImage,
    this.rating,
    this.productNo,
    this.name,
    this.price,
    this.imageUrls,
    this.shippingCost,
    this.shopLocation,
    this.shopName,
    this.productProperties,
    this.productReviews});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class FavoriteModel {
  int favoriteNo;
  int productNo;
  String userNo;

  FavoriteModel({this.userNo, this.favoriteNo, this.productNo});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavoriteModelFromJson(json);

  Map<String, dynamic> toJson() => _$FavoriteModelToJson(this);
}
