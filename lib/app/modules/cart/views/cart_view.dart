import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/widgets/order_cart_item.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (CartController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Giỏ hàng'),
            centerTitle: true,
          ),
          bottomNavigationBar: Container(
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
                    controller.setCheckAllItem();
                  },
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Tổng tiền: '),
                      Text('${controller.getTotalPrice()} VNĐ',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 5),
                      RoundedButton(
                        height: 40,
                        onPressed: () {
                          Get.toNamed(Routes.PAYMENT);
                        },
                        color: Colors.deepOrange,
                        textContent: 'Mua hàng',
                        radius: 0,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: controller.isLoadingCart.value ? Center(child: CircularProgressIndicator()) : GetBuilder(
            builder: (CartController controller) {
              return Column(
                children: [
                  if (controller.orders.length > 0)
                          Divider(
                            thickness: 5,
                            height: 5,
                          ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.orders
                                .where((_) => _.status == 'pending')
                                .toList()
                                .length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  OrderCartItem(
                                    controller: controller,
                                    onTap: () {
                                      controller.removeCartItem(index);
                                    },
                                    order: controller.orders[index],
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
              );
            },
          ),
        );
      },
    );
  }
}
