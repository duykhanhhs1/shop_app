import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

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
    CartController.to.getOrders(LoginController.to.userLogged.value.userNo);
    super.onInit();
  }

  void getAllProductOverview() async {
    isLoading.value = true;
    final List<ProductOverViewModel> data =
        await repository.getAllProductOverview();
    products = data.obs;
    isLoading.value = false;
    update();
  }

  // void getProducts() async {
  //   final List<ProductOverViewModel> data = await repository.getProducts();
  //   products = data.obs;
  //   update();
  // }

  void setItemTapped(int index) {
    currentIndexBottomBar.value = index;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }

  @override
  void onClose() {}
}
