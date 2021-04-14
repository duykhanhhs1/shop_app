import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

class HomeController extends GetxController {
  final ProductRepository repository;

  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  RxBool isLoading = false.obs;

  RxInt currentIndexBottomBar = RxInt(0);
  RxList<ProductOverViewModel> products = RxList<ProductOverViewModel>();

  @override
  void onInit() async {
    /*for(int i=0; i<5; i ++ ){
       ManageProduct.addProduct(ProductModel(
      name: 'Samsung 12',
      price: 1200,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ0pjgqxKJIOkbM7xMnLer4j8MWJUUEP3PJw&usqp=CAU',
      rating: 4.5,
      shippingCost: 2000,
      shopLocation: 'Vinh',
      shopName: 'thegioibanve',
      shopImage:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ0pjgqxKJIOkbM7xMnLer4j8MWJUUEP3PJw&usqp=CAU',
      imageUrls: [
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ0pjgqxKJIOkbM7xMnLer4j8MWJUUEP3PJw&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ0pjgqxKJIOkbM7xMnLer4j8MWJUUEP3PJw&usqp=CAU',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ0pjgqxKJIOkbM7xMnLer4j8MWJUUEP3PJw&usqp=CAU',
      ],
    ));
    }*/

    getAllProductOverview();
   // CartController.to.getOrders(LoginController.to.userLogged.value.userNo);
    super.onInit();
  }

  Future<void> getAllProductOverview() async {
    isLoading.value = true;
    final List<ProductOverViewModel> data =
        await repository.getAllProductOverview();
    products = data.obs;
    isLoading.value = false;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
