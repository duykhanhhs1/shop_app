import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/manage/ManageProduct.dart';
import 'package:scrum_app/app/model/Order.dart';

class ManageOrder {
  static bool addOrderFB(OrderModel cartItem) {
    cartItem.orderNo = DateTime.now().millisecondsSinceEpoch;
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    orders.doc('${cartItem.orderNo}').set(cartItem.toJson()).then((value) {
      print("Add Order Success!!");
      return true;
    }).catchError((error) {
      print("Failed to add order: $error");
      return false;
    });
  }

  // static Future<List<CartItemModel>> getAllOrderFB() async {
  //   List<CartItemModel> orders = [];
  //   await FirebaseFirestore.instance
  //       .collection('products')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((map) async {
  //       CartItemModel cartItem = CartItemModel.fromJson(map.data());
  //       cartItem.product =
  //           await ManageProduct.getProductOverViewFB(cartItem.productNo);
  //       orders.add(cartItem);
  //     });
  //     return orders;
  //   });
  //   return orders;
  // }

  ///
  static void updateOrder(Order order) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('orders');
    products
        .doc('${order.id}')
        .set({
          'idUser': order.idUser,
          'number': order.number,
          'total': order.total,
          'idProduct': order.idProduct,
          'timeCreated': order.timeCreated,
          'status': order.status
        })
        .then((value) => print("update Order Success!!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  static void deleteOrder(int id) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('orders');
    products
        .doc('$id')
        .delete()
        .then((value) => print("update Order Success!!"))
        .catchError((error) => print("Failed to update order: $error"));
  }

  static Order getOrder(int id) {
    FirebaseFirestore.instance
        .collection('orders')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Order(map['id'], map['idUser'], map['number'], map['total'],
            map['idProduct'], map['timeCreated'], map['status']);
      } else {
        return null;
      }
    });
  }

  // static List<Order> getAllOrder() {
  //   List<Order> orders = [];
  //   FirebaseFirestore.instance
  //       .collection('products')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((map) {
  //       orders.add(Order(map['id'], map['idUser'], map['number'], map['total'],
  //           map['idProduct'], map['timeCreated'], map['status']));
  //     });
  //     return orders;
  //   });
  // }
}
