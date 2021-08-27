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
  List<String> paymentMethods = ['Thanh toán khi nhận hàng', 'Thẻ tín dụng'];
  RxString paymentMethod = ''.obs;

  @override
  void onInit() {
    paymentMethod.value = paymentMethods[0];
    if (LoginController.to.isLogged) {
      getProducts();
    }
    super.onInit();
  }

  Future<void> addProduct(int productId, int count) async {
    try {
      isLoadingCart.value = true;
      await repository.addProductToCart(productId, count);
      if (products.indexWhere((element) => element.id == productId) == -1) {
        products.add(ProductOverViewModel(id: productId, count: count));
      }
      isLoadingCart.value = false;
      update();
    } catch (e) {
      Get.snackbar("Lỗi", "Đã xảy ra lỗi. Vui lòng thử lại",
          colorText: Colors.red);
    }
    update();
  }

  ///

  Future<void> getProducts() async {
    isLoadingCart.value = true;
    reCheckProducts();
    final List<ProductOverViewModel> data = await repository.getProductsCart();
    products = data.obs;
    isLoadingCart.value = false;
    update();
  }

  void removeCheckedProducts() async {
    try {
      for (var product in checkedProducts) {
        await repository.removeProductsCart(product.id);
        products.remove(product);
      }
      isCheckedAll.value = false;
    } catch (e) {
      Get.snackbar("Lỗi", "Đã có lỗi xảy ra. Vui lòng thử lại sau.",
          colorText: Colors.red);
    }
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

  Future<void> createOrder() async {
    try {
      List<ProductCartModel> cartProducts = [];
      checkedProducts.forEach((element) {
        cartProducts
            .add(ProductCartModel(id: element.id, count: element.count));
      });
      ProfileModel profile = _loginController.userLogged.value.profile;
      OrderCreateModel order = OrderCreateModel(
          address: profile.address,
          product_ids: cartProducts,
          pay_method_name: paymentMethod.value,
          phone_number: profile.phone_number);
      await repository.addOrder(order);
      products.clear();
    } catch (e) {
      Get.snackbar("Lỗi", "Đã xảy ra lỗi. Vui lòng thử lại",
          colorText: Colors.red);
    }
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
