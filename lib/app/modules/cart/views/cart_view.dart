import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/widgets/product_cart_item.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/utils/helpers.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.find(),
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Giỏ hàng'),
              centerTitle: true,
              actions: [
                if (controller.checkedProducts.length > 0)
                  IconButton(
                      onPressed: () {
                        controller.removeCheckedProducts();
                      },
                      icon: Icon(Icons.delete_outline))
              ],
            ),
            bottomNavigationBar: _buildBottomNavigationBar(controller),
            body: controller.isLoadingCart.value
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      if (controller.products.length > 0)
                        Divider(
                          thickness: 5,
                          height: 5,
                        ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                ProductCartItem(
                                  controller: controller,
                                  product: controller.products[index],
                                ),
                                Divider(
                                  thickness: 5,
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ));
      },
    );
  }

  Widget _buildBottomNavigationBar(CartController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            child: Row(
              children: [
                Icon(
                  controller.isCheckedAll.value
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  color: controller.isCheckedAll.value
                      ? Colors.deepOrange
                      : Colors.black54,
                ),
                SizedBox(width: 5),
                Text('Tất cả')
              ],
            ),
            onTap: () {
              if (controller.products.length > 0) {
                controller.setCheckAllItem();
              }
            },
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text('Tổng tiền: '),
                Text(
                    '₫${NumberHelper.currencyFormat(controller.getTotalPrice())}',
                    style: TextStyle(
                        color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                SizedBox(width: 5),
                RoundedButton(
                  height: 40,
                  onPressed: controller.checkedProducts.length > 0
                      ? () {
                          Get.toNamed(Routes.PAYMENT);
                        }
                      : null,
                  color: Colors.deepOrange,
                  textContent: 'Mua hàng',
                  radius: 0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
