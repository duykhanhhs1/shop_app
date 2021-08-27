import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key key,
    this.product,
  }) : super(key: key);

  final ProductOverViewModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.DETAIL_PRODUCT, arguments: product.id);
      },
      child: GetBuilder<HomeController>(
        init: Get.find(),
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: kLightBackground),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 5,
                      offset: Offset(5, 5))
                ]),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    CachedNetworkImage(
                      errorWidget: (context, url, error) => ErrorImage(),
                      imageUrl: product.link_image,
                      placeholder: (context, url) =>
                          Container(color: Colors.grey.shade200),
                      width: Get.width,
                      height: Get.width * 0.4,
                      fit: BoxFit.cover,
                    ),
                    /* if (product.discount != null && product.discount > 0)
                      Positioned(
                          top: 0,
                          right: 0,
                          child: Stack(
                            children: [
                              Icon(
                                CupertinoIcons.bookmark_fill,
                                size: 50,
                                color: Colors.yellow.shade600,
                              ),
                              Positioned(
                                  top: 15,
                                  left: 15,
                                  child: Text(
                                    "${product.discount}%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ))
                            ],
                          ))*/
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                  '₫${NumberHelper.currencyFormat(product.price)}',
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                child: Icon(
                                  product.isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: kSecondaryColor,
                                ),
                                onTap: () {
                                  ///Handle favorite product
                                  controller.setProductFavorite(product);
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ErrorImage extends StatelessWidget {
  const ErrorImage({
    Key key,
    this.size = 50,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Icon(
          CupertinoIcons.photo_fill,
          size: size,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
