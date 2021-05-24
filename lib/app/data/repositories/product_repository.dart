import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/category_model.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/providers/product_provider.dart';

class ProductRepository {
  final ProductProvider apiClient;

  ProductRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List<CategoryModel>> getCategories() {
    return apiClient.getCategories();
  }

  Future<List<ProductReviewModel>> getReviews(int productId) {
    return apiClient.getReviews(productId);
  }

  Future<void> addReview(ProductReviewModel review) {
    return apiClient.addReview(review);
  }

  Future<void> addProductToCart(int productId, int count) async {
    return apiClient.addProductToCart(productId, count);
  }

  Future<void> updateProductToCart(int productId, int count) async {
    return apiClient.updateProductToCart(productId, count);
  }

  Future<void> removeProductsCart(List<int> productIds) async {
    return apiClient.removeProductsCart(productIds);
  }

  ///Firebase

  Future<void> updateProduct(ProductModel product) {
    return apiClient.updateProduct(product);
  }

  Future<void> removeProduct(int productNo) {
    return apiClient.removeProduct(productNo);
  }

  Future<List<ProductOverViewModel>> getProducts(int pageIndex) {
    return apiClient.getProducts(pageIndex);
  }

  Future<List<ProductOverViewModel>> getFavoriteProducts(String userNo) {
    return apiClient.getFavoriteProducts(userNo);
  }

  Future<List<ProductOverViewModel>> getProductsCart() async {
    return apiClient.getProductsCart();
  }

  Future<ProductOverViewModel> getProductOverViewFB(int productNo) {
    return apiClient.getProductOverViewFB(productNo);
  }

  Future<ProductDetailModel> getProductDetailFB(int productNo) {
    return apiClient.getProductDetailFB(productNo);
  }

  Future<void> addOrder(OrderCreateModel order) {
    return apiClient.addOrder(order);
  }

  Future<void> updateOrder(OrderCreateModel order) {
    return apiClient.updateOrder(order);
  }

  Future<OrderCreateModel> getOrder(int orderNo, int productNo) {
    return apiClient.getOrder(orderNo, productNo);
  }

  Future<void> removeOrder(int orderNo) {
    return apiClient.removeOrder(orderNo);
  }

  Future<void> addProduct(ProductModel product) {
    return apiClient.addProduct(product);
  }

  Future<void> addFavoriteProduct(FavoriteModel favorite) {
    return apiClient.addFavoriteProduct(favorite);
  }

  Future<void> removeFavoriteProduct(FavoriteModel favorite) {
    return apiClient.removeFavoriteProduct(favorite);
  }

  Future<FavoriteModel> getFavorite(String userNo, int productNo) {
    return apiClient.getFavorite(userNo, productNo);
  }
}
