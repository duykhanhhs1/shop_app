import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final ProductRepository repository;
  CartController({@required this.repository}) : assert(repository != null);

  static CartController get to => Get.find<CartController>();

  RxList<CartItemModel> carts = RxList<CartItemModel>();

  @override
  void onInit() {
    super.onInit();
  }

  void addCartItem(CartItemModel cartItemModel) {
    carts.add(cartItemModel);
    update();
  }

  void removeCartItem(int index) {
    carts.removeAt(index);
    update();
  }

  void updateQuantityCartItem(CartItemModel cartItem, String value) {
    cartItem.quantity = int.tryParse(value);
    update();
  }

  int getTotalPrice() {
    int total = 0;
    carts.forEach((element) {
      total += element.product.price;
    });
    return total;
  }

  void toggleChecked(CartItemModel cartItem){
    cartItem.isChecked = !cartItem.isChecked;
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
