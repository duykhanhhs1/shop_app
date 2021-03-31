import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductOverViewModel {
  int productNo;
  String name;
  int price;
  String imageUrl;

  ProductOverViewModel({this.productNo, this.name, this.price, this.imageUrl});

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
class CartItemModel {
  final int cartItemNo;
  final ProductDetailModel product;
  int quantity;
  bool isChecked;

  CartItemModel(
      {this.cartItemNo, this.product, this.quantity, this.isChecked = false});

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  int productNo;
  String name;
  int price;
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

  ProductModel(
      {this.discount,
        this.amount,
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
