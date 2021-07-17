import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/theme/text_theme.dart';
import 'package:scrum_app/app/widgets/cart_icon_widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class ProductCategoryView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SizedBox(
            height: 40,
            child: FormRoundedInputField(
              keyboardType: TextInputType.text,
              borderRadius: BorderRadius.circular(10),
              prefixIcon: Icons.search_rounded,
              hintText: 'Tìm kiếm sản phẩm',
              maxLines: 1,
            ),
          ),
        ),
        actions: <Widget>[
          Center(child: CartIcon()),
          SizedBox(width: 12),
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController.to,
        builder: (controller) => Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child:
                      Text(controller.currentCategory.name, style: textTitle),
                ),
                controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : controller.productsByCate.length == 0
                        ? Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                      "Hiện chưa có sản phẩm nào để hiện thị."),
                                  Text("Vui lòng quay lại sau."),
                                ],
                              ),
                            ),
                          )
                        : GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.productsByCate.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 7,
                                    mainAxisSpacing: 7,
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.23),
                            itemBuilder: (BuildContext context, int index) {
                              return ProductCard(
                                product: controller.productsByCate[index],
                              );
                            }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
