import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/manage/ManageProduct.dart';
import 'package:scrum_app/app/model/Product.dart';

class HomeController extends GetxController {
  final ProductRepository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  final count = 0.obs;

  RxInt currentIndexBottomBar = RxInt(0);
  RxList<ProductOverViewModel> products = RxList<ProductOverViewModel>();
  List<ProductOverViewModel> productModels = <ProductOverViewModel>[];

  @override
  void onInit() async {
    getProducts();
    productModels = ManageProduct.getAllProduct();
    ManageProduct.addProduct(ProductOverViewModel(productNo: 12312233, name: 'zxcxvx 123c',price: 2323, imageUrl: 'zxczxc.png'));
    super.onInit();
  }

  void getProducts() async {
    final List<ProductOverViewModel> data = await repository.getProducts();
    products = data.obs;
    update();
  }

  void setItemTapped(int index) {
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
