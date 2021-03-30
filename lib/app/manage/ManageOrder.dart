import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrum_app/app/model/Order.dart';

class ManageOrder{

  static void addOrder(Order order){
    order.id = DateTime.now().millisecondsSinceEpoch;
    CollectionReference products = FirebaseFirestore.instance.collection('orders');
    products.doc('${order.id}').set({
      'id': order.id,
      'idUser': order.idUser,
      'number': order.number,
      'total': order.total,
      'idProduct': order.idProduct,
      'timeCreated': order.timeCreated,
      'status': order.status
    }).then((value) => print("Add Order Success!!"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  static void updateOrder(Order order){
    CollectionReference products = FirebaseFirestore.instance.collection('orders');
    products.doc('${order.id}').set({
      'idUser': order.idUser,
      'number': order.number,
      'total': order.total,
      'idProduct': order.idProduct,
      'timeCreated': order.timeCreated,
      'status': order.status
    }).then((value) => print("update Order Success!!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  static void deleteOrder(int id){
    CollectionReference products = FirebaseFirestore.instance.collection('orders');
    products.doc('$id').delete().then((value) => print("update Order Success!!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  static Order getOrder(int id){
    FirebaseFirestore.instance
        .collection('orders')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Order(map['id'], map['idUser'], map['number'], map['total'], map['idProduct'], map['timeCreated'], map['status']);
      }else{
        return null;
      }
    });
  }
  static List<Order> getAllOrder(){
    List<Order> orders = [];
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) {
         orders.add(Order(map['id'], map['idUser'], map['number'], map['total'], map['idProduct'], map['timeCreated'], map['status']));
      });
      return orders;
    });
  }
}