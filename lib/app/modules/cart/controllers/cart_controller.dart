import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';


class CartController extends GetxController {
  //TODO: Implement CartController

  final ProductRepository repository;
  CartController({@required this.repository}) : assert(repository != null);

  static CartController get to => Get.find<CartController>();

  RxList<OrderModel> carts = RxList<OrderModel>();
  RxInt total = RxInt(0);
  RxBool isCheckedAll = RxBool(false);
  RxBool isLoadingCart = RxBool(false);

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }

  Future<void> getOrders() async {
    isLoadingCart.value = true;
    final List<OrderModel> data = await repository.getAllOrderFB();
    carts = data.obs;
    isLoadingCart.value = false;
    update();
  }

  void addOrder(OrderModel order) async {
    repository.addOrder(order);
    carts.add(order);
    update();
  }

  void removeCartItem(int index) {
    carts.removeAt(index);
    update();
  }

  // void updateQuantityCartItem(OrderModel order, String value) {
  //   order.quantity = int.tryParse(value);
  //   update();
  // }

  int getTotalPrice() {
    total.value = 0;
    carts.forEach((element) {
      if(element.isChecked == true){
        total.value += element.product.price * element.quantity;
      }
    });
    update();
    return total.value;
  }

  int getPrice(OrderModel order) {
    update();
    return order.product.price * order.quantity;
  }

  void toggleChecked(OrderModel order) {
    int count = 0;
    order.isChecked = !order.isChecked;
    carts.forEach((element) {
      if (element.isChecked == true) {
        count++;
      }
    });
    if (count == carts.length) {
      isCheckedAll.value = true;
    } else
      isCheckedAll.value = false;
    update();
  }

  void setCheckAllItem() {
    if (isCheckedAll.value) {
      carts.forEach((element) {
        element.isChecked = false;
      });
      isCheckedAll.value = false;
    } else {
      carts.forEach((element) {
        element.isChecked = true;
      });
      isCheckedAll.value = true;
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
