import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


import 'package:scrum_app/app/model/Customer.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxBool isProcessing = RxBool(false);


  final count = 0.obs;

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void verifyUser() {}

  @override
  void onClose() {}

  void increment() => count.value++;
  //signIn
  Future<void> signIn({String email, String password}) async {
    isProcessing.value = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      Customer.uid = FirebaseAuth.instance.currentUser.uid;
      print("login success!");
      isProcessing.value = false;
      Get.offAllNamed(Routes.HOME);
    }).catchError((onError) {
      Get.snackbar('Error', 'User not found',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      isProcessing.value = false;
    });
  }

  Future<void> customerRegister(
      {String email,
      String password,
      String fullName,
      String address,
      String phone}) async {
    isProcessing.value = true;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //upload info customer
      var idUser = FirebaseAuth.instance.currentUser.uid;
//      Customer.uid = value.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(idUser).set({
        'id': idUser,
        'fullName': fullName,
        'address': address,
        'phone': phone
      }).then((value) {
        print("Add Customer Success!!");
        Get.offAllNamed(Routes.LOGIN);
        Get.snackbar('Success', 'Register success',
            snackPosition: SnackPosition.BOTTOM, colorText: Colors.green);
      }).catchError((error) => print("Failed to add customer: $error"));
      isProcessing.value = false;
    }).catchError((onError) {
      print("register failure" + onError.toString());
      isProcessing.value = false;
    });
  }
}
