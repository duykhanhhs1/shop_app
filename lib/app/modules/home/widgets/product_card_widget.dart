import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Image.network(
            product.imageUrl,
            width: Get.width,
            height: Get.width * 0.4,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: Get.height * 0.045,
                    child: Text(product.name, maxLines: 2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('${product.price}\$',
                        style: TextStyle(color: Colors.red, fontSize: 18)),
                    Icon(Icons.add_circle,color: kPrimaryColor,size: 35,)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
