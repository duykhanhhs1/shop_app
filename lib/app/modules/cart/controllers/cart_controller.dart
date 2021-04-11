import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final ProductRepository repository;

  CartController({@required this.repository}) : assert(repository != null);

  static CartController get to => Get.find<CartController>();

  RxList<OrderModel> orders = RxList<OrderModel>();

  List<OrderModel> get checkedOrders =>
      orders.where((_) => _.isChecked).toList();

  List<OrderModel> get paidOrders {
    List<OrderModel> paidOrders =
        orders.where((_) => _.status == 'paid').toList();
    paidOrders.sort((a, b) => a.createAt.compareTo(b.createAt));
    return paidOrders;
  }

  List<OrderModel> get pendingOrders =>
      orders.where((_) => _.status == 'pending').toList();

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
      (element) =>
          element.productNo == order.productNo && element.status == 'pending',
      orElse: () => null,
    );
    if (orderCheck != null) {
      order.orderNo = orderCheck.orderNo;
      order.quantity += orderCheck.quantity;
      await repository.updateOrder(order);
    } else {
      await repository.addOrder(order);
      await repository
          .getProductOverViewFB(order.productNo)
          .then((product) => order.product = product);
      orders.add(order);
    }
    update();
  }

  void removeOrder(OrderModel order) async {
    await repository.removeOrder(order.orderNo);
    orders.remove(order);
    if (pendingOrders.length == 0) isCheckedAll.value = false;
    update();
  }

  void removeCheckedOrders() async {
    checkedOrders.forEach((order) async {
      await repository
          .removeOrder(order.orderNo)
          .then((value) => orders.remove(order));
    });
    isCheckedAll.value = false;
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

  void updatePaidOrder() async {
    checkedOrders.forEach((element) async {
      element.status = 'paid';
      element.isChecked = false;
      element.createAt = DateTime.now();
      await repository.updateOrder(element);
    });
  }

  void reBuy(OrderModel order) async {
    orders.forEach((element) {
      element.isChecked = false;
    });

    //
    OrderModel orderReBuy = order;
    orderReBuy.status = 'pending';
    orderReBuy.isChecked = true;
    await repository.addOrder(orderReBuy);
    Get.toNamed(Routes.CART);
  }

  void toggleChecked(OrderModel order) {
    order.isChecked = !order.isChecked;
    if (checkedOrders.length == pendingOrders.length) {
      isCheckedAll.value = true;
    } else
      isCheckedAll.value = false;
    update();
  }

  void setCheckAllItem() {
    if (isCheckedAll.value) {
      pendingOrders.forEach((element) {
        element.isChecked = false;
      });
      isCheckedAll.value = false;
    } else {
      pendingOrders.forEach((element) {
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
