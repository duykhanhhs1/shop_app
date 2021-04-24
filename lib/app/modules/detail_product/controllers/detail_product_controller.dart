import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

class DetailProductController extends GetxController {
  //TODO: Implement DetailProductController
  final ProductRepository repository;
  DetailProductController({@required this.repository}) : assert(repository != null);

  static DetailProductController get to => Get.find<DetailProductController>();


  Rx<ProductDetailModel> productDetail = Rx<ProductDetailModel>(ProductDetailModel());
  RxBool isLoadingProduct = RxBool(false);

  TextEditingController quantityController = TextEditingController();
  RxInt quantity = RxInt(0);

  @override
  void onInit() {
    final int productNo = Get.arguments;
    getProductDetailFB(productNo);
    super.onInit();
  }


  // void getProductDetail(int productNo) async {
  //   isLoadingProduct.value = true;
  //   final ProductDetailModel data = await repository.getProductDetail(productNo);
  //   productDetail = data.obs;
  //   isLoadingProduct.value = false;
  //   update();
  // }
  //
  void getProductDetailFB(int productNo) async {
    isLoadingProduct.value = true;
    final ProductDetailModel data =
        await repository.getProductDetailFB(productNo);
    productDetail = data.obs;
    isLoadingProduct.value = false;
    update();
  }

  int getPrice() {
    return productDetail.value.price * productDetail.value.quantity;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
