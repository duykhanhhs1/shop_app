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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  static AdminController get to => Get.find<AdminController>();

  RxList<ProductModel> products = RxList<ProductModel>();

  //RxList<ProductModel> lowerProducts = RxList<ProductModel>();
  // RxList<ProductModel> showProducts = RxList<ProductModel>();

  TextEditingController productInputController = TextEditingController();

  RxList<UserModel> users = RxList<UserModel>();

  RxBool isCheck = false.obs;
  RxBool isSubmit = false.obs;

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
    update();
  }

  void updateProduct(ProductModel product) async {
    await productRepository.updateProduct(product);
    getAllProductFB();
  }

  void removeProduct(ProductModel product) async {
    await productRepository.removeProduct(product);
    getAllProductFB();
    update();
  }

  void removeImage(String imageUrl) async {
    product.value.imageUrls.remove(imageUrl);
    update();
  }

  void addProduct(ProductModel product) async {
    await productRepository.addProduct(product);
    getAllProductFB();
    update();
  }

  void pickImage(ImageSource imageSource) async {
    final PickedFile pickedFile =
        await ImagePicker().getImage(source: imageSource);
    Get.back();
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

/*  void searchProducts() {
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
  }*/

  void submitProduct() {
    isSubmit.value = true;
    update();
    if (formKey.currentState.validate() && product.value.imageUrls.length > 0) {
      if (product.value.productNo != null) {
        updateProduct(product.value);
      } else
        addProduct(product.value);
      Get.back();
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
