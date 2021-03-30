import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Customer{
  String id;
  String fullName;
  String address;
  String phone;
  static String uid;

  Customer(this.id, this.fullName, this.address, this.phone);

}