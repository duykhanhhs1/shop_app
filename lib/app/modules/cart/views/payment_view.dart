import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/cart/widgets/order_payment_item_widget.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';

class PaymentView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Thanh toán'),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text('Tổng thanh toán: '),
              Text('₫${controller.getTotalPrice()}',
                  style: TextStyle(
                      color: kSecondaryColor, fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              RoundedButton(
                height: 40,
                onPressed: () {
                  controller.updatePaidOrder();
                  Get.dialog(
                      AlertDialog(
                        title: Text(
                          'Thông báo',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: SizedBox(
                          width: Get.width,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check_circle_outline,
                                  color: kPrimaryColor, size: 100),
                              Text('Bạn đã đặt hàng thành công.'),
                              SizedBox(height: 30),
                              RoundedButton(
                                width: Get.width,
                                textContent: 'OK',
                                onPressed: () {
                                  Get.offAllNamed(Routes.HOME);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      barrierDismissible: true);
                },
                color: kSecondaryColor,
                textContent: 'Đặt hàng',
                radius: 0,
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_outlined, color: kSecondaryColor),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Địa chỉ nhận hàng'),
                        SizedBox(height: 5),
                        Text(
                            'Trần Duy Khánh | 0328264648 \nĐH Kinh Tế, Đà Nẵng'),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(thickness: 4, height: 0),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.checkedOrders.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      OrderPaymentItem(
                        order: controller.checkedOrders[index],
                      ),
                      Divider(thickness: 4, height: 0),
                    ],
                  );
                },
              ),
              Divider(thickness: 4, height: 0),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Icon(
                        Icons.attach_money_rounded,
                        color: kSecondaryColor,
                      ),
                      SizedBox(width: 10),
                      Text('Phương thức thanh toán')
                    ]),
                    Text(
                      'Tiền mặt',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(height: 0),
            ],
          ),
        ));
  }
}
