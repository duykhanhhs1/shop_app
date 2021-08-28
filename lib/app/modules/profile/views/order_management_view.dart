import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:scrum_app/app/modules/profile/widgets/order_item_widget.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';

class OrderManagementView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Đơn mua'),
              centerTitle: true,
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  SizedBox(width: 200, child: Tab(child: Text('Chờ xác nhận'))),
                  SizedBox(width: 200, child: Tab(child: Text('Đã giao'))),
                ],
              ),
            ),
            body: GetBuilder<ProfileController>(
              init: ProfileController.to,
              builder: (controller) => TabBarView(
                children: [
                  controller.isLoadingOrder.value
                      ? Center(child: CupertinoActivityIndicator())
                      : controller.unVerifiedOrders.length == 0
                          ? Center(
                              child: Text("Bạn chưa mua đơn hàng nào. "),
                            )
                          : Column(
                              children: [
                                if (controller.unVerifiedOrders.length > 0)
                                  Divider(thickness: 4, height: 4),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.unVerifiedOrders.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          OrderItem(
                                            order: controller
                                                .unVerifiedOrders[index],
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Ngày thanh toán: ${controller.unVerifiedOrders[index].created_at}',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(.6)),
                                                ),
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
                  controller.isLoadingOrder.value
                      ? Center(child: CupertinoActivityIndicator())
                      : controller.verifiedOrders.length == 0
                          ? Center(
                              child: Text("Bạn chưa mua đơn hàng nào. "),
                            )
                          : Column(
                              children: [
                                if (controller.verifiedOrders.length > 0)
                                  Divider(thickness: 4, height: 4),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.verifiedOrders.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          OrderItem(
                                            order: controller
                                                .verifiedOrders[index],
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
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Text(
                                        'Ngày thanh toán: ${controller.verifiedOrders[index].created_at}',
                                                  style: TextStyle(
                                                      color: Colors.black
                                                          .withOpacity(.6)),
                                                ),
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
                ],
              ),
            )));
  }
}
