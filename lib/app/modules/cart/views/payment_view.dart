import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/cart/widgets/order_payment_item_widget.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
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
              Text('${controller.getTotalPrice()}',
                  style: TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              RoundedButton(
                height: 40,
                onPressed: () {
                  controller.setPaidStatus();
                  Get.offAllNamed(Routes.HOME);
                  Get.snackbar('Thông báo', 'Đặt hàng thành công',
                      colorText: Colors.green,
                      snackPosition: SnackPosition.BOTTOM);
                },
                color: Colors.deepOrange,
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
                    Icon(Icons.location_on_outlined, color: Colors.deepOrange),
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
                        controller: controller,
                        order: controller.checkedOrders[index],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Tổng số tiền (${controller.orders[index].quantity} sản phẩm)'),
                                Text(
                                    '₫${controller.orders[index].getPriceOrder}',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold))
                              ])
                        ]),
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
                        color: Colors.deepOrange,
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
