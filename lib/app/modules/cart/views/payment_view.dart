import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/cart/widgets/product_payment_item_widget.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class PaymentView extends GetView<CartController> {
  final UserModel user = LoginController.to.userLogged.value;

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
              Text(
                  '₫${NumberHelper.currencyFormat(controller.getTotalPrice())}',
                  style: TextStyle(
                      color: kSecondaryColor, fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              RoundedButton(
                height: 40,
                onPressed: () async {
                  await controller.createOrder();
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
        body: GetBuilder<CartController>(
          init: CartController.to,
          builder: (controller) => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,
                              color: kSecondaryColor),
                          SizedBox(width: 10),
                          Text('Địa chỉ nhận hàng'),
                        ],
                      ),
                      SizedBox(height: 5),
                      FormRoundedInputField(
                        hintText: "Nhập địa chỉ nhận hàng",
                        initialValue: user.profile.address,
                        onChanged: (value) {
                          user.profile.address = value;
                        },
                        borderRadius: BorderRadius.circular(10),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.phone, color: kSecondaryColor),
                          SizedBox(width: 10),
                          Text('Số điện thoại'),
                        ],
                      ),
                      SizedBox(height: 5),
                      FormRoundedInputField(
                        hintText: "Nhập số điện thoại",
                        initialValue: user.profile.phone_number,
                        borderRadius: BorderRadius.circular(10),
                        onChanged: (value) {
                          user.profile.phone_number = value;
                        },
                      ),
                    ],
                  ),
                ),
                Divider(thickness: 4, height: 0),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.checkedProducts.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ProductPaymentItem(
                          product: controller.checkedProducts[index],
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
                    children: [
                      Expanded(
                          child: FormRoundedInputField(
                        hintText: "Nhập mã khuyến mãi",
                        prefixIcon: Icons.payments,
                        borderRadius: BorderRadius.circular(10),
                      )),
                      SizedBox(width: 10),
                      RoundedButton(
                        textContent: "Áp dụng",
                        radius: 10,
                        onPressed: () {},
                      ),
                    ],
                  ),
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
                      DropdownButton<String>(
                        value: controller.paymentMethod.value,
                        icon: const Icon(Icons.arrow_drop_down_outlined),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(
                            color: kPrimaryColor, fontWeight: FontWeight.bold),
                        underline: Container(
                          height: 2,
                          color: kPrimaryColor,
                        ),
                        onChanged: (String newValue) {
                          controller.paymentMethod.value = newValue;
                          controller.update();
                        },
                        items: controller.paymentMethods
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                Divider(height: 0),
              ],
            ),
          ),
        ));
  }
}
