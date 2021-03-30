import 'package:cloud_firestore/cloud_firestore.dart';
class Product{
  int id;
  String name;
  int number;
  int price;

  Product(this.id, this.name, this.number, this.price);
}