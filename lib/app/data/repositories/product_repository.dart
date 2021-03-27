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
}
