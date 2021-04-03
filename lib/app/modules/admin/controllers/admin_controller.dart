import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

class AdminController extends GetxController {
  //TODO: Implement AdminController
  final ProductRepository repository;
  AdminController({@required this.repository}) : assert(repository != null);

  static AdminController get to => Get.find<AdminController>();

  RxList<ProductModel> products = RxList<ProductModel>();

  RxBool isCheck = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    getAllProductFB();
    super.onInit();
  }

  void setCheck() {
    isCheck.value = !isCheck.value;
    update();
  }

  void getAllProductFB() async {
    final List<ProductModel> data = await repository.getAllProductFB();
    products = data.obs;
    update();
  }

  void updateProduct(ProductModel product) async {
    await repository.updateProduct(product);
    update();
  }

  void removeProduct(ProductModel product) async {
    await repository
        .removeProduct(product)
        .then((value) => products.remove(product));
    update();
  }

  void addProduct(ProductModel product) async {
    await repository.addProduct(product).then((value) => products.add(product));
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
