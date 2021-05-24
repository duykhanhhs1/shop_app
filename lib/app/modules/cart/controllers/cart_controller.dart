import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  final ProductRepository repository;

  CartController({@required this.repository}) : assert(repository != null);

  static CartController get to => Get.find<CartController>();

  LoginController _loginController = LoginController.to;

  RxList<ProductOverViewModel> products = RxList<ProductOverViewModel>();

  List<ProductOverViewModel> get checkedProducts =>
      products.where((_) => _.isChecked).toList();

  RxInt total = RxInt(0);
  RxBool isCheckedAll = RxBool(false);
  RxBool isLoadingCart = RxBool(false);
  RxBool isUpdated = RxBool(false);

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  Future<void> addProduct(int productId, int count) async {
    if (products.indexWhere((element) => element.id == productId) != null) {
      isLoadingCart.value = true;
      await repository.addProductToCart(productId, count);
      products.length++;
      isLoadingCart.value = false;
    } else {
      isLoadingCart.value = true;
      await repository.updateProductToCart(productId, count);
      isLoadingCart.value = false;
    }

    update();
  }

  ///

  Future<void> getProducts() async {
    isLoadingCart.value = true;
    final List<ProductOverViewModel> data = await repository.getProductsCart();
    products = data.obs;
    isLoadingCart.value = false;
    update();
  }

  void removeCheckedProducts() async {
    List<int> productIds;
    checkedProducts.forEach((product) {
      productIds.add(product.id);
      products.remove(product);
    });
    await repository.removeProductsCart(productIds);
    isCheckedAll.value = false;
    update();
  }

  void reCheckProducts() async {
    products.forEach((element) {
      element.isChecked = false;
    });
    update();
  }

  int getTotalPrice() {
    total.value = 0;
    checkedProducts.forEach((element) {
      if (element.isChecked == true) {
        total.value += element.price * element.count;
      }
    });
    return total.value;
  }

  void createOrder() async {
    List<ProductCartModel> cartProducts = [];
    checkedProducts.forEach((element) {
      cartProducts.add(ProductCartModel(id: element.id, count: element.count));
    });
    ProfileModel profile = _loginController.userLogged.value.profile;
    OrderCreateModel order =
        OrderCreateModel(address: profile.address, products: cartProducts);
    await repository.addOrder(order);
  }

  void reBuy(OrderCreateModel order) {
    // products.forEach((element) {
    //   element.isChecked = false;
    // });
    //
    // //
    // OrderModel orderReBuy = OrderModel.fromJson(order.toJson());
    // orderReBuy.product = order.product;
    // orderReBuy.status = 'pending';
    // orderReBuy.isChecked = true;
    // addOrder(orderReBuy);
    // Get.toNamed(Routes.CART);
  }

  void toggleChecked(ProductOverViewModel product) {
    product.isChecked = !product.isChecked;
    if (checkedProducts.length == products.length) {
      isCheckedAll.value = true;
    } else
      isCheckedAll.value = false;
    update();
  }

  void setCheckAllItem() {
    if (isCheckedAll.value) {
      products.forEach((element) {
        element.isChecked = false;
      });
      isCheckedAll.value = false;
    } else {
      products.forEach((element) {
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
  void onClose() {
    // orders.forEach((element) {
    //   element.isChecked = false;
    // });
  }
}
