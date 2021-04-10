import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxBool isProcessing = RxBool(false);
  Rx<UserModel> userLogged = Rx(UserModel());

  static LoginController get to => Get.find<LoginController>();

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
      getCustomer(value.user.uid).then((value) {
        userLogged.value = value;
        if (value.role == 'admin') {
          Get.offAllNamed(Routes.ADMIN);
        } else {
          Get.offAllNamed(Routes.HOME);
        }
      });
      isProcessing.value = false;
    }).catchError((onError) {
      Get.snackbar('Error', 'User not found',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
      isProcessing.value = false;
    });
  }

  Future<UserModel> getCustomer(String id) async {
    UserModel customer = UserModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        customer = UserModel.fromJson(map);
        return customer;
      } else {
        return customer;
      }
    });
    return customer;
  }

  Future<void> addCustomer(
      {String email, String password, UserModel user}) async {
    isProcessing.value = true;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //upload info customer
      user.userNo = FirebaseAuth.instance.currentUser.uid;
      //var idUser = FirebaseAuth.instance.currentUser.uid;
//      Customer.uid = value.uid;
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(user.userNo).set(user.toJson()).then((value) {
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
