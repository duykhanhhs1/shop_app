import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/category_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/special_card_widget.dart';
import 'package:scrum_app/app/theme/app_theme.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/theme/text_theme.dart';
import 'package:scrum_app/app/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:scrum_app/app/widgets/cart_icon_widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class SearchProductView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      init: HomeController.to,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: SizedBox(
                height: 40,
                child: FormRoundedInputField(
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  borderRadius: BorderRadius.circular(10),
                  prefixIcon: Icons.search_rounded,
                  hintText: 'Tìm kiếm sản phẩm',
                  maxLines: 1,
                  onFieldSubmitted: (value) => controller.searchProducts(value),
                  textInputAction: TextInputAction.search,
                ),
              ),
            ),
          ),
          body: controller.isSearching.value
              ? Center(child: CupertinoActivityIndicator())
              : controller.searchedProducts.length == 0
                  ? Center(child: Text("Không tìm thấy sản phẩm."))
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: kHorizontalContentPadding),
                      shrinkWrap: true,
                      itemCount: controller.searchedProducts.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 7,
                          crossAxisCount: 2,
                          childAspectRatio: 1 / 1.23),
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          product: controller.searchedProducts[index],
                        );
                      }),
        );
      },
    );
  }
}
