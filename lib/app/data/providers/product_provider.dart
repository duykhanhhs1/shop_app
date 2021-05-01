import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

/*
  Future<List<ProductOverViewModel>> getProducts() async {
    return AppMock.products;
  }

  Future<ProductDetailModel> getProductDetail(productNo) async {
    return AppMock.productDetails
        .firstWhere((element) => element.productNo == productNo);
  }
*/

  ///FIRE BASE
  Future<List<ProductModel>> getProducts() async {
    List<ProductModel> products = [];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var map = element.data();
        products.add(ProductModel.fromJson(map));
      });
    });
    return products;
  }

  Future<List<ProductOverViewModel>> getAllProductOverview() async {
    List<ProductOverViewModel> products = [];
    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var map = element.data();
        products.add(ProductOverViewModel.fromJson(map));
      });
    });
    return products;
  }

  Future<List<ProductOverViewModel>> getFavoriteProducts(String userNo) async {
    List<ProductOverViewModel> products = [];
    List<Future> futures = <Future>[];

    await FirebaseFirestore.instance
        .collection('favorites')
        .where('userNo', isEqualTo: userNo)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        int productNo = FavoriteModel.fromJson(element.data()).productNo;
        futures.add(getProductOverViewFB(productNo).then((value) {
          products.add(value);
        }));
      });
    });
    await Future.wait(futures);
    return products;
  }

  Future<void> addProduct(ProductModel product) async {
    product.productNo = DateTime.now().millisecondsSinceEpoch;
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    await products
        .doc('${product.productNo}')
        .set(product.toJson())
        .then((value) => print("Add product Success!!"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future<void> removeProduct(int productNo) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');

    List<OrderModel> orders = [];
    List<FavoriteModel> favorites = [];

    await products
        .doc('$productNo')
        .delete()
        .then((value) => print("Delete product Success!!"))
        .catchError((error) => print("Failed to Delete product: $error"));

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) async {
        OrderModel order = OrderModel.fromJson(map.data());
        if (order.productNo == productNo) {
          orders.add(order);
        }
      });
    });
    orders.forEach((element) async {
      await removeOrder(element.orderNo);
    });

    await FirebaseFirestore.instance
        .collection('favorites')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) async {
        FavoriteModel favorite = FavoriteModel.fromJson(map.data());
        if (favorite.productNo == productNo) {
          favorites.add(favorite);
        }
      });
    });
    favorites.forEach((element) async {
      await removeFavoriteProduct(element);
    });
  }

  Future<void> updateProduct(ProductModel product) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    await products
        .doc('${product.productNo}')
        .update(product.toJson())
        .then((value) => print("Update product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
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
      } else {
        print('product detail not exists');
      }
    });
    return product;
  }

  Future<List<OrderModel>> getAllOrderFB(String userNo) async {
    List<OrderModel> orders = [];
    List<Future> futures = <Future>[];

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) async {
        OrderModel order = OrderModel.fromJson(map.data());
        if (order.userNo == userNo) {
          futures.add(getProductOverViewFB(order.productNo).then((value) {
            order.product = value;
            orders.add(order);
          }));
        }
      });
    });
    await Future.wait(futures);
    return orders;
  }

  Future<void> addFavoriteProduct(FavoriteModel favorite) async {
    favorite.favoriteNo = DateTime.now().millisecondsSinceEpoch;
    CollectionReference products =
        FirebaseFirestore.instance.collection('favorites');
    await products
        .doc('${favorite.favoriteNo}')
        .set(favorite.toJson())
        .then((value) => print("Add favorite product Success!!"))
        .catchError((error) => print("Failed to add favorite product: $error"));
  }

  Future<void> removeFavoriteProduct(FavoriteModel favorite) async {
    CollectionReference products =
        FirebaseFirestore.instance.collection('favorites');
    await products
        .doc('${favorite.favoriteNo}')
        .delete()
        .then((value) => print("Remove favorite product Success!!"))
        .catchError(
            (error) => print("Failed to Remove favorite product: $error"));
  }

  Future<FavoriteModel> getFavorite(String userNo, int productNo) async {
    List<FavoriteModel> favorites = [];
    FavoriteModel favorite = FavoriteModel();

    await FirebaseFirestore.instance
        .collection('favorites')
        .where('$userNo')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) async {
        favorites.add(FavoriteModel.fromJson(element.data()));
      });
    });
    favorites.forEach((element) {
      if (element.userNo == userNo && element.productNo == productNo) {
        favorite = element;
      }
    });
    return favorite;
  }

  ///Order
  Future<List<OrderModel>> getPaidOrders() async {
    List<OrderModel> orders = [];
    List<Future> futures = <Future>[];

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((map) async {
        OrderModel order = OrderModel.fromJson(map.data());
        if (order.createAt != null) {
          futures.add(getProductOverViewFB(order.productNo).then((value) {
            order.product = value;
            orders.add(order);
          }));
        }
      });
    });
    await Future.wait(futures);

    return orders;
  }

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

  Future<OrderModel> getOrder(int orderNo, int productNo) async {
    OrderModel order;

    await FirebaseFirestore.instance
        .collection('orders')
        .doc('$orderNo')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        order = OrderModel.fromJson(documentSnapshot.data());
      } else {
        print('order not exists');
      }
    });
    return order;
  }

  Future<void> removeOrder(int orderNo) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc('$orderNo')
        .delete()
        .then((value) => print('remove order success'))
        .catchError((e) => print('remove order fail + $e'));
  }
}
