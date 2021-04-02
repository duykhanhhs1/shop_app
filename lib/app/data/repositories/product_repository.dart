import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/providers/product_provider.dart';

class ProductRepository {
  final ProductProvider apiClient;

  ProductRepository({@required this.apiClient}) : assert(apiClient != null);

  Future<List<ProductOverViewModel>> getProducts() {
    return apiClient.getProducts();
  }

  Future<ProductDetailModel> getProductDetail(productNo) {
    return apiClient.getProductDetail(productNo);
  }


  ///Firebase
  Future<List<ProductOverViewModel>> getAllProductFB() {

  }

  Future<List<OrderModel>> getAllOrderFB() async {
    return await apiClient.getAllOrderFB();
  }

  Future<ProductOverViewModel> getProductOverViewFB(int productNo) {
    return apiClient.getProductOverViewFB(productNo);
  }

  Future<ProductDetailModel> getProductDetailFB(int productNo) {
    return apiClient.getProductDetailFB(productNo);
  }

  Future<void> addOrder(OrderModel order) {
    return apiClient.addOrder(order);
  }


}
