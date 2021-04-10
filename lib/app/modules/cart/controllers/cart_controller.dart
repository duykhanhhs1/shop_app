import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final ProductRepository repository;

  CartController({@required this.repository}) : assert(repository != null);

  static CartController get to => Get.find<CartController>();

  RxList<OrderModel> orders = RxList<OrderModel>();

  List<OrderModel> get checkedOrders =>
      orders.where((_) => _.isChecked).toList();
  RxInt total = RxInt(0);
  RxBool isCheckedAll = RxBool(false);
  RxBool isLoadingCart = RxBool(false);

  @override
  void onInit() {
    getOrders(LoginController.to.userLogged.value.userNo);
    super.onInit();
  }

  Future<void> getOrders(String userNo) async {
    isLoadingCart.value = true;
    final List<OrderModel> data = await repository.getAllOrderFB(userNo);
    orders = data.obs;
    isLoadingCart.value = false;
    update();
  }

  void addOrder(OrderModel order) async {
    OrderModel orderCheck = orders.singleWhere(
      (element) => element.productNo == order.productNo,
      orElse: () => null,
    );
    if (orderCheck != null) {
      order.orderNo = orderCheck.orderNo;
      order.quantity += orderCheck.quantity;
      await repository.updateOrder(order);
    } else {
      await repository.addOrder(order);
      orders.add(order);
    }
    update();
  }

  void removeCartItem(int index) {
    orders.removeAt(index);
    update();
  }

  int getTotalPrice() {
    total.value = 0;
    checkedOrders.forEach((element) {
      if (element.isChecked == true) {
        total.value += element.product.price * element.quantity;
      }
    });
    /* orders.forEach((element) {
      if (element.isChecked == true) {
        total.value += element.product.price * element.quantity;
      }
    });*/
    update();
    return total.value;
  }

  void setPaidStatus() async {
    checkedOrders.forEach((element) async {
      element.status = 'paid';
      await repository.updateOrder(element);
    });
  }

  void toggleChecked(OrderModel order) {
    order.isChecked = !order.isChecked;
    if (checkedOrders.length == orders.length) {
      isCheckedAll.value = true;
    } else
      isCheckedAll.value = false;
    update();
  }

  void setCheckAllItem() {
    if (isCheckedAll.value) {
      orders.forEach((element) {
        element.isChecked = false;
      });
      isCheckedAll.value = false;
    } else {
      orders.forEach((element) {
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
