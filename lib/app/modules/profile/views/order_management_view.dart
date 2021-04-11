import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/cart/widgets/order_payment_item_widget.dart';
import 'package:scrum_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';

class OrderManagementView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Đơn mua'),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(child: Text('Đã thanh toán')),
                Tab(child: Text('Đã giao')),
                Tab(child: Text('Chờ xác nhận')),
                Tab(child: Text('Đang giao')),
              ],
            ),
          ),
          body: GetBuilder(
            init: CartController.to,
            builder: (CartController controller) {
              return TabBarView(
                children: [
                  Column(
                    children: [
                      if (controller.paidOrders.length > 0)
                        Divider(thickness: 4, height: 4),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.paidOrders.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                OrderPaymentItem(
                                  order: controller.paidOrders[index],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 0,
                                    left: 10,
                                    right: 10,
                                    bottom: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Ngày thanh toán: ${controller.paidOrders[index].getCreateAt}',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(.6)),
                                      ),
                                      RoundedButton(
                                        color: Colors.deepOrange,
                                        radius: 5,
                                        onPressed: () {
                                          controller.reBuy(
                                              controller.paidOrders[index]);
                                        },
                                        textContent: 'Mua lại',
                                        height: 40,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(thickness: 4, height: 0),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Center(child: Text('Đang cập nhật...')),
                  Center(child: Text('Đang cập nhật...')),
                  Center(child: Text('Đang cập nhật...')),
                ],
              );
            },
          )),
    );
  }
}
