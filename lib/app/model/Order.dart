import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  int id;
  String idUser;
  int number;
  int total;
  String idProduct;
  String timeCreated;
  String status;

  Order(this.id, this.idUser, this.number, this.total, this.idProduct,
      this.timeCreated, this.status);
}