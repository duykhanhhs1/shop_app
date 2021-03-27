import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

class DetailProductController extends GetxController {
  //TODO: Implement DetailProductController
  final ProductRepository repository;
  DetailProductController({@required this.repository}) : assert(repository != null);

  static DetailProductController get to => Get.find<DetailProductController>();


  Rx<ProductDetailModel> productDetail = Rx<ProductDetailModel>();
  RxBool isLoadingProduct = RxBool(false);

  TextEditingController quantityController = TextEditingController();
  RxInt quantity = RxInt();

  @override
  void onInit() {
    int productNo = Get.arguments;
    getProductDetail(productNo);
    super.onInit();
  }

  void getProductDetail(int productNo) async {
    isLoadingProduct.value = true;
    final ProductDetailModel data = await repository.getProductDetail(productNo);
    productDetail = data.obs;
    isLoadingProduct.value = false;
    update();
  }

  void clearInputQuantity(){
    quantityController.clear();
    update();
  }

  void increaseQuantity(){
    if(quantity.value < 999){
      quantity.value ++;
      quantityController.text = quantity.value.toString();
      update();
    }
  }
  void decreaseQuantity(){
    if(quantity.value > 0){
      quantity.value --;
      quantityController.text = quantity.value.toString();
      update();
    }
  }

  void setQuantityFromInput(){
    quantity.value = int.tryParse(quantityController.text);
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
