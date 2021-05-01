import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';
import 'package:scrum_app/app/utils/firebase_untils.dart';

class AdminController extends GetxController {
  //TODO: Implement AdminController
  final ProductRepository productRepository;
  final UserRepository userRepository;

  AdminController(
      {@required this.productRepository, @required this.userRepository})
      : assert(productRepository != null && userRepository != null);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static AdminController get to => Get.find<AdminController>();

  RxList<ProductModel> products = RxList<ProductModel>();

  List<ProductModel> get checkedProducts =>
      products.where((_) => _.isChecked).toList();

  //RxList<ProductModel> lowerProducts = RxList<ProductModel>();
  RxList<ProductModel> showProducts = RxList<ProductModel>();

  TextEditingController productInputController = TextEditingController();

  RxList<UserModel> users = RxList<UserModel>();
  RxList<OrderModel> orders = RxList<OrderModel>();

  RxBool isCheck = false.obs;
  RxBool isCheckedAll = false.obs;
  RxBool isSubmit = false.obs;
  RxBool isLoading = false.obs;

  RxList<String> imagePickedUrls = RxList<String>(['icon']);
  Rx<ProductModel> product = Rx(ProductModel());

  @override
  void onInit() {
    getProducts();
    getUsers().whenComplete(() => getPaidOrders());
    super.onInit();
  }

  void setCheck() {
    isCheck.value = !isCheck.value;
    update();
  }

  ///USER
  Future<void> getUsers() async {
    final List<UserModel> data = await userRepository.getUsers();
    users = data.obs;
    update();
  }

  Future<void> getPaidOrders() async {
    final List<OrderModel> data = await productRepository.getPaidOrders();
    orders = data.obs;
    orders.forEach((order) {
      users.forEach((user) {
        if (user.userNo == order.userNo) order.customerName = user.fullName;
      });
    });
    orders.sort((a, b) => b.createAt.compareTo(a.createAt));
    update();
  }

  void removeUser(String userNo) async {
    await userRepository.removeUser(userNo);
    getUsers();
  }

  ///PRODUCT
  Future<void> getProducts() async {
    final List<ProductModel> data = await productRepository.getProducts();
    products = data.obs;
    update();
  }

  Future<void> updateProduct(ProductModel product) async {
    await productRepository.updateProduct(product);
    getProducts();
  }

  Future<void> removeProduct(int productNo) async {
    await productRepository.removeProduct(productNo);
    getProducts();
    update();
  }

  void removeImage(String imageUrl) async {
    product.value.imageUrls.remove(imageUrl);
    update();
  }

  Future<void> addProduct(ProductModel product) async {
    await productRepository.addProduct(product);
    getProducts();
    update();
  }

  void pickImage(ImageSource imageSource) async {
    final PickedFile pickedFile =
        await ImagePicker().getImage(source: imageSource);
    Get.back();
    if (pickedFile != null) {
      String imageName;
      if (kIsWeb) {
        imageName = pickedFile.path.substring(
            pickedFile.path.lastIndexOf('/'), pickedFile.path.length - 1);
        product.value.imageUrls.add(await FirebaseHelper.uploadImageWeb(
            'product images', pickedFile, imageName));
      } else {
        File imageFile = File(pickedFile.path);
        imageName = imageFile.path.substring(
            imageFile.path.lastIndexOf('/'), imageFile.path.length - 1);
        product.value.imageUrls.add(await FirebaseHelper.uploadImage(
            'product images', imageFile, imageName));
      }

      product.value.imageUrl = product.value.imageUrls[0];
      update();
    }
  }

  void setCheckedProduct(ProductModel product) {
    product.isChecked = !product.isChecked;
    if (checkedProducts.length == products.length) {
      isCheckedAll.value = true;
    } else
      isCheckedAll.value = false;
    update();
  }

  void setCheckedAll() {
    if (isCheckedAll.value == false) {
      products.forEach((element) {
        element.isChecked = true;
      });
      isCheckedAll.value = true;
    } else {
      products.forEach((element) {
        element.isChecked = false;
      });
      isCheckedAll.value = false;
    }
    update();
  }

  void removeChecked() async {
    checkedProducts.forEach((element) async {
      await removeProduct(element.productNo);
    });
    update();
  }

  ///Statistic
  int getSoldProductQuantity() {
    int quantity = 0;
    orders.forEach((element) {
      quantity += element.quantity;
    });
    return quantity;
  }

  int getUserQuantity() {
    return users.length;
  }

  int getInventoryProductQuantity() {
    int quantity = 0;
    products.forEach((element) {
      quantity += element.amount;
    });
    return quantity;
  }

  void searchProducts() {
    showProducts = products
        .where((_) => _.name.contains(productInputController.text))
        .toList()
        .obs;
    update();
  }

  void saveProduct() async {
    isSubmit.value = true;
    if (formKey.currentState.validate() && product.value.imageUrls.length > 0) {
      isLoading.value = true;
      if (product.value.productNo != null) {
        await updateProduct(product.value);
      } else
        await addProduct(product.value);
      isLoading.value = false;
      isSubmit.value = false;
      Get.back();
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
