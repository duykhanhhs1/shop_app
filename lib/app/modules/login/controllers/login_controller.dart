import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController emailController;
  TextEditingController passwordController;
  RxBool isProcessing = RxBool(false);


  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void verifyUser(){

  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
