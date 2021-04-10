import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/profile/controllers/profile_controller.dart';

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
              indicatorPadding: const EdgeInsets.all(0),
              labelPadding: const EdgeInsets.all(5),
              tabs: [
                Text('Đã thanh toán'),
                Text('Đã giao'),
                Text('Chờ xác nhận'),
                Text('Đang giao'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Text('1'),
              Text('2'),
              Text('Đang cập nhật...'),
              Text('Đang cập nhật...'),
            ],
          )),
    );
  }
}
