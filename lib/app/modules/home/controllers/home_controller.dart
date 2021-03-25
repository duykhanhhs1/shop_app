import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  final count = 0.obs;

  RxInt currentIndexBottomBar = RxInt(0);
  RxList<ProductModel> products = RxList<ProductModel>();

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() async {
    final List<ProductModel> data = await repository.getProducts();
    products = data.obs;
    update();
  }

  void setItemTapped(int index){
    currentIndexBottomBar.value = index;
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
