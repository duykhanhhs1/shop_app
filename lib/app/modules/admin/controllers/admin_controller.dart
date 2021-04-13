import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  static AdminController get to => Get.find<AdminController>();

  RxList<ProductModel> products = RxList<ProductModel>();
  RxList<ProductModel> lowerProducts = RxList<ProductModel>();

  TextEditingController productInputController = TextEditingController();

  RxList<ProductModel> showProducts = RxList<ProductModel>();

  RxList<UserModel> users = RxList<UserModel>();

  RxBool isCheck = false.obs;

  RxList<String> imagePickedUrls = RxList<String>(['icon']);
  Rx<ProductModel> product = Rx(ProductModel());

  @override
  void onInit() {
    getAllProductFB();
    getUsers();
    super.onInit();
  }

  void setCheck() {
    isCheck.value = !isCheck.value;
    update();
  }

  ///USER
  void getUsers() async {
    final List<UserModel> data = await userRepository.getUsers();
    users = data.obs;
    update();
  }

  ///PRODUCT
  void getAllProductFB() async {
    final List<ProductModel> data = await productRepository.getAllProductFB();
    products = data.obs;
    showProducts = products;
    update();
  }

  void updateProduct(ProductModel product) async {
    await productRepository.updateProduct(product);
    update();
  }

  void removeProduct(ProductModel product) async {
    await productRepository
        .removeProduct(product)
        .then((value) => products.remove(product));
    update();
  }

  void addProduct(ProductModel product) async {
    await productRepository
        .addProduct(product)
        .then((value) => products.add(product));
    update();
  }

  void pickImage() async {
    final PickedFile pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imageName = imageFile.path.substring(
          imageFile.path.lastIndexOf('/'), imageFile.path.length - 1);
      product.value.imageUrls
          .add(await FirebaseHelper.uploadImage(imageFile, imageName));
      product.value.imageUrl = product.value.imageUrls[0];
      update();
    }
  }

  void searchProducts() {
    //showProducts.clear();
    String input = productInputController.text.toLowerCase();
    products.forEach((element) {
      lowerProducts.add(ProductModel.fromJson(element.toJson()));
    });
    lowerProducts.forEach((element) {
      element.name = element.name.toLowerCase();
    });
    if (input == '')
      showProducts = products;
    else {
      showProducts =
          lowerProducts.where((_) => _.name.contains(input)).toList().obs;
      print(showProducts.length);
      showProducts.forEach((sp) {
        products.forEach((p) {
          if (p.productNo == sp.productNo) sp.name = p.name;
        });
      });
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
