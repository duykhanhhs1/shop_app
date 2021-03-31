import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/model/Customer.dart';

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
  void onInit() {
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
    }).catchError((onError) {
      print("login failure" + onError.toString());
      isProcessing.value = true;
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
      users
          .doc(idUser)
          .set({
            'id': idUser,
            'fullName': fullName,
            'address': address,
            'phone': phone
          })
          .then((value) => print("Add Customer Success!!"))
          .catchError((error) => print("Failed to add customer: $error"));
      isProcessing.value = false;
    }).catchError((onError) {
      print("register failure" + onError.toString());
      isProcessing.value = true;
    });
  }
}
