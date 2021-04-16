import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';

class UserProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserModel> getUserLogged(String userNo) async {
    UserModel customer = UserModel();
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$userNo')
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

  Future<void> register({String email, String password, UserModel user}) async {
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
      }).catchError((error) => print("Failed to add customer: $error"));
    }).catchError((onError) {
      print("register failure" + onError.toString());
    });
  }

  ///ADMIN
  Future<List<UserModel>> getUsers() async {
    List<UserModel> users = [];
    await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        users.add(UserModel.fromJson(element.data()));
      });
    });
    return users;
  }

  Future<void> removeUser(String userNo) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('$userNo')
        .delete()
        .then((value) => print('delete success'));
  }

  Future<void> updateUserProfile(String userNo,String name, String gender, String phone, String des) async {
    Map<String,String> mapData = new HashMap<String,String>();
    mapData.putIfAbsent("userNo", () => userNo);
    mapData.putIfAbsent("name", () => name);
    mapData.putIfAbsent("gender", () => gender);
    mapData.putIfAbsent("phone", () => phone);
    mapData.putIfAbsent("description", () => des);
    mapData.forEach((key, value) {print("map");print(key+ "   "+value);});

    await FirebaseFirestore.instance
        .collection('users')
        .doc('$userNo')
        // .delete()
        // .then((value) => print('delete success'));
        .update(mapData)
        .then((value)=>print("Update Successfully"));
  }
}
