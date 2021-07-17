import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/category_model.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/utils/endpoints.dart';
import 'package:scrum_app/app/utils/http_utils.dart';

class ProductProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<void> addOrder(OrderCreateModel order) async {
    try {
      final response = await HttpHelper.post(
        Endpoints.ORDERS,
        order.toJson(),
      );
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> removeProductsCart(List<int> productIds) async {
    try {
      final response = await HttpHelper.delete(Endpoints.CARTS, productIds);
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await HttpHelper.get(Endpoints.CATEGORIES);
      var result = response.body["categories"]
          .map<CategoryModel>((item) => CategoryModel.fromJson(item))
          .toList();
      return result;
    } on DioError catch (e) {
      return [];
    }
  }

  Future<List<ProductReviewModel>> getReviews(int productId) async {
    try {
      final response =
          await HttpHelper.get(Endpoints.PRODUCTS + "/$productId/reviews");
      var result = response.body["reviews"]
          .map<ProductReviewModel>((item) => ProductReviewModel.fromJson(item))
          .toList();
      return result;
    } on DioError catch (e) {
      return [];
    }
  }

  Future<void> addReview(ProductReviewModel review) async {
    try {
      final response = await HttpHelper.post(
        Endpoints.REVIEWS,
        review.toJson(),
      );
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> addProductToCart(int productId, int count) async {
    try {
      final response = await HttpHelper.post(
        Endpoints.CARTS,
        {"product_id": productId, "count": count},
      );
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateProductToCart(int productId, int count) async {
    try {
      final response = await HttpHelper.put(
        Endpoints.CARTS,
        {"product_id": productId, "count": count},
      );
      if (response.statusCode == 200) return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<ProductOverViewModel>> getProductsCart() async {
    try {
      final response = await HttpHelper.get(Endpoints.CARTS);
      var result = response.body["products"]
          .map<ProductOverViewModel>(
              (item) => ProductOverViewModel.fromJson(item))
          .toList();
      return result;
    } on DioError catch (e) {
      return [];
    }
  }

  Future<List<ProductOverViewModel>> getProducts(int pageIndex) async {
    try {
      final response =
          await HttpHelper.get(Endpoints.PRODUCTS + "?page=$pageIndex");
      var result = response.body["products"]
          .map<ProductOverViewModel>(
              (item) => ProductOverViewModel.fromJson(item))
          .toList();
      return result;
    } on DioError catch (e) {
      return [];
    }
  }

  Future<List<ProductOverViewModel>> getProductsByCate(
      int pageIndex, int categoryId) async {
    try {
      final response = await HttpHelper.get(
          Endpoints.CATEGORIES + "/$categoryId/products?page=$pageIndex");
      var result = response.body["products"]
          .map<ProductOverViewModel>(
              (item) => ProductOverViewModel.fromJson(item))
          .toList();
      return result;
    } on DioError catch (e) {
      return [];
    }
  }

  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await HttpHelper.get(Endpoints.ORDERS);
      var result = response.body["orders"]
          .map<OrderModel>((item) => OrderModel.fromJson(item))
          .toList();
      return result;
    } on DioError catch (e) {
      return [];
    }
  }

  ///FIRE BASE
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

  Future<ProductDetailModel> getProductDetailFB(int id) async {
    try {
      final response = await HttpHelper.get('${Endpoints.PRODUCTS}/$id');
      return ProductDetailModel.fromJson(response.body);
    } catch (e) {
      // return null;
      throw e;
    }
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

  Future<void> updateOrder(OrderCreateModel order) async {
    CollectionReference orders =
        FirebaseFirestore.instance.collection('orders');
    await orders
        .doc('${order.id}')
        .update(order.toJson())
        .then((value) => print("Update Product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
  }

  Future<OrderCreateModel> getOrder(int orderNo, int productNo) async {
    OrderCreateModel order;

    await FirebaseFirestore.instance
        .collection('orders')
        .doc('$orderNo')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        order = OrderCreateModel.fromJson(documentSnapshot.data());
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
