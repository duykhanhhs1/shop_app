import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/model/Product.dart';

class ManageProduct {
  static void addProduct(ProductOverViewModel product) {
    product.productNo = DateTime.now().millisecondsSinceEpoch;
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    products
        .doc('${product.productNo}')
        .set(product.toJson())
        .then((value) => print("Add Product Success!!"))
        .catchError((error) => print("Failed to add product: $error"));
  }

  static void updateProduct(Product product) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    products
        .doc('${product.id}')
        .update({'number': product.number, 'price': product.price})
        .then((value) => print("Update Product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
  }

  static void deleteProduct(int id) {
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    products
        .doc('$id')
        .delete()
        .then((value) => print("Update Product Success!!"))
        .catchError((error) => print("Failed to Update product: $error"));
  }

  static Product getProduct(int id) {
    FirebaseFirestore.instance
        .collection('products')
        .doc('$id')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var map = documentSnapshot.data();
        return Product(id, map['name'], map['number'], map['price']);
      } else {
        return null;
      }
    });
  }

  static List<ProductOverViewModel> getAllProduct() {
    List<ProductOverViewModel> products = [];
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        var map = element.data();
        products
            .add(ProductOverViewModel.fromJson(map));
        print(products.length);
      });
      return products;
    });
    return [];
  }
}
