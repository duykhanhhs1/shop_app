import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductOverViewModel {
  final int productNo;
  final String name;
  final int price;
  final String imageUrl;

  ProductOverViewModel({this.productNo, this.name, this.price, this.imageUrl});

  factory ProductOverViewModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOverViewModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOverViewModelToJson(this);
}

@JsonSerializable()
class ProductDetailModel {
  final int productNo;
  final String name;
  final int price;
  final int oldPrice;
  final double rating;
  final List<String> imageUrls;
  final int shippingCost;
  final int discount;
  final String shopName;
  final String shopImage;
  final String shopLocation;
  final List<ProductPropertyModel> productProperties;
  final List<ProductReviewModel> productReviews;

  ProductDetailModel(
      {this.discount,
      this.shopImage,
      this.oldPrice,
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

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}

@JsonSerializable()
class ProductPropertyModel {
  final int productNo;
  final String property;
  final String content;

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
  final int productNo;
  final int reviewNo;
  final String username;
  final int rating;
  final String comment;
  final List<String> imageUrls;

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
