import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('CartView'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: Get.width,
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.location_on_rounded),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Địa chỉ người nhận',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text('Nguyễn Thị Thu Vân'),
                          SizedBox(height: 10),
                          Text(
                            '(+84) 98 364 45 67',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '12 Phan Bội Châu , Phường Trường An, Thừa Thiên Huế zxc zxc zxc',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Text('Thông tin vận chuyển'),
              Text('Thông tin thanh toán'),
              Text('Đơn hàng'),
              Text('Mã đơn hàng'),
              Text('Trạng thái đơn hàng'),
            ],
          ),
        ));
  }
}
