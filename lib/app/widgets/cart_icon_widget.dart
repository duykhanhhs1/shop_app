import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (CartController controller) {
        return Stack(
          children: <Widget>[
            IconButton(
                tooltip: 'Giỏ hàng',
                onPressed: () {
                  controller.reCheckOrders();
                  Get.toNamed(Routes.CART);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                )),
            Positioned(
                right: 0,
                child: controller.pendingOrders.length > 0
                    ? Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                            border: Border.all(color: Colors.white)),
                        child: Text(
                          '${controller.pendingOrders.length}',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      )
                    : SizedBox(height: 0))
          ],
        );
      },
    );
  }
}
