import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GetBuilder(
          init: Get.find<CartController>(),
          builder: (CartController controller) {
            return IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CART);
                  controller
                      .getOrders(LoginController.to.userLogged.value.userNo);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ));
          },
        ),
        Positioned(
          right: 0,
          child: GetBuilder(
            init: Get.find<CartController>(),
            builder: (CartController cartController) {
              return cartController.orders.length > 0
                  ? Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          border: Border.all(color: Colors.white)),
                      child: Text(
                        '${cartController.orders.length}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    )
                  : SizedBox(height: 0);
            },
          ),
        )
      ],
    );
  }
}
