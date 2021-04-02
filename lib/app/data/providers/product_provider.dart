import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/mock/app_mock.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<List<ProductOverViewModel>> getProducts() async {
    return AppMock.products;
  }

  Future<ProductDetailModel> getProductDetail(productNo) async {
    return AppMock.productDetails
        .firstWhere((element) => element.productNo == productNo);
  }

  ///FIRE BASE
  Future<List<ProductOverViewModel>> getAllProductFB() async {
    List<ProductOverViewModel> products = [];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var map = element.data();
        products.add(ProductOverViewModel.fromJson(map));
      });
      return products;
    });
    return products;
  }

  Future<ProductOverViewModel> getProductOverViewFB(int productNo) async {
    ProductOverViewModel product;

    await FirebaseFirestore.instance
        .collection('products')
        .doc('$productNo')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        product = ProductOverViewModel.fromJson(documentSnapshot.data());
      } else {
        print('product overview not exists');
      }
    });
    return product;
  }

  Future<ProductDetailModel> getProductDetailFB(int productNo) async {
    ProductDetailModel product = ProductDetailModel();
    await FirebaseFirestore.instance
        .collection('products')
        .doc('$productNo')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        product = ProductDetailModel.fromJson(documentSnapshot.data());
        return product;
      } else {
        print('product detail not exists');
        return product;
      }
    });
    return product;
  }

  Future<List<OrderModel>> getAllOrderFB() async {
    List<OrderModel> orders = [];
    List<Future> futures = <Future>[];

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) async {
        OrderModel order = OrderModel.fromJson(map.data());
        futures.add(getProductOverViewFB(order.productNo).then((value) {
          order.product = value;
          orders.add(order);
        }));
      });
    });
    await Future.wait(futures);
    return orders;
  }

  ///Order

  Future<void> addOrder(OrderModel order) async {
    order.orderNo = DateTime.now().millisecondsSinceEpoch;
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    await orders
        .doc('${order.orderNo}')
        .set(order.toJson())
        .then((value) => print("Add Order Success!!"))
        .catchError((error) => print("Failed to add order: $error"));
  }

  Future<void> updateOrder(OrderModel order) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    await orders
        .doc('${order.orderNo}')
        .update(order.toJson())
        .then((value) => print("Update Product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
  }
}
