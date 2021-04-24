import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';

class FavoriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yêu thích'),
        centerTitle: true,
      ),
      body: GetBuilder<HomeController>(
        init: Get.find(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: controller.favoriteProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.23),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          product: controller.favoriteProducts[index],
                        );
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
