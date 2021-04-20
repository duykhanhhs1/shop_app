import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/modules/admin/widgets/statistic_card_widget.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/theme/text_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';
import 'package:scrum_app/app/widgets/app_bottom_bar_admin_widget.dart';

class RevenueStatisticView extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(width: 0),
        title: Text('Thống kê cửa hàng'),
        centerTitle: true,
      ),
      bottomNavigationBar: AppBottomNavigationBarAdmin(2),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              _buildTimePicker(),
              _buildRevenueCard(),
              SizedBox(height: 20),
              _buildGridViewStatistic(),
              SizedBox(height: 20),
              _buildTableOrders(),
              SizedBox(height: 20),
              _buildRevenueChart()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              iconSize: 18,
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back_ios,
              )),
          Text(
            'Tháng 4',
            style: TextStyle(fontSize: 20),
          ),
          IconButton(
              iconSize: 18,
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
              )),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng doanh thu',
                      style: TextStyle(fontSize: 16, color: kLightTextColor),
                    ),
                    Text('6 tháng gần đây',
                        style: TextStyle(color: kLightTextColor))
                  ],
                ),
                SizedBox(height: 10),
                Text('₫${NumberHelper.currencyFormat(230405000)}',
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            width: Get.width,
            height: 250,
            child: LineChart(LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData:
                    LineTouchTooltipData(tooltipBgColor: Colors.grey.shade100),
                enabled: true,
                getTouchLineStart: (barData, spotIndex) {
                  return 0;
                },
                getTouchLineEnd: (barData, spotIndex) {
                  return 0;
                },
              ),
              gridData: FlGridData(
                show: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTextStyles: (value) =>
                      const TextStyle(color: kLightTextColor, fontSize: 16),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 1:
                        return 'Th 11';
                      case 3:
                        return 'Th 12';
                      case 5:
                        return 'Th 1';
                      case 7:
                        return 'Th 2';
                      case 9:
                        return 'Th 3';
                      case 11:
                        return 'Th 4';
                    }
                    return '';
                  },
                ),
                leftTitles: SideTitles(
                  showTitles: false,
                ),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              minX: 0,
              maxX: 12,
              minY: 0,
              maxY: 10000000,
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    FlSpot(0, 2234000),
                    FlSpot(1, 2234000),
                    FlSpot(3, 1234000),
                    FlSpot(5, 4234000),
                    FlSpot(7, 3234000),
                    FlSpot(9, 7234000),
                    FlSpot(11, 2234000),
                    FlSpot(12, 2234000),
                  ],
                  isCurved: true,
                  colors: [
                    ColorTween(begin: kPrimaryColor, end: kPrimaryColor)
                        .lerp(0),
                  ],
                  barWidth: 3,
                  isStrokeCapRound: false,
                  dotData: FlDotData(
                    show: false,
                  ),
                  belowBarData: BarAreaData(show: true, colors: [
                    ColorTween(begin: kPrimaryColor, end: Colors.white)
                        .lerp(0.93),
                  ]),
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildGridViewStatistic() {
    return GridView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.8),
      children: [
        StatisticCard(
          title: 'Số lượng bán',
          quantity: controller.getSoldProductQuantity(),
          balance: 33.45,
        ),
        StatisticCard(
          title: 'Người dùng mới',
          quantity: controller.getUserQuantity(),
          balance: -12.56,
        ),
        StatisticCard(
          title: 'Số lượng nhập',
          quantity: 1280,
          balance: 23.45,
        ),
        StatisticCard(
          title: 'Kho hàng',
          quantity: controller.getInventoryProductQuantity(),
          balance: 33.45,
        ),
      ],
    );
  }

  Widget _buildRevenueCard() {
    return Card(
      color: kPrimaryColor,
      child: Container(
        width: Get.width,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Doanh thu',
              style: TextStyle(fontSize: 16, color: kWhiteTextColor),
            ),
            SizedBox(height: 5),
            Text('₫${NumberHelper.currencyFormat(23500000)}',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold,color: kWhiteTextColor)),
            SizedBox(height: 10),
            _buildLineStatistic(
                title: 'Tổng thu',
                price: 55000000,
                icon: CupertinoIcons.arrow_right_circle,
                color: kPrimaryLightColor),
            SizedBox(height: 10),
            _buildLineStatistic(
                title: 'Tổng chi',
                price: 35000000,
                icon: CupertinoIcons.arrow_left_circle,
                color: kSecondaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildTableOrders() {
    return Card(
      color: kPrimaryColor,
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            'Danh sách đơn hàng mới',
            style: TextStyle(color: kWhiteTextColor, fontSize: 16),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              Expanded(
                  child: Text('STT',
                      style: tableTextTitle),
                  flex: 1),
              Expanded(
                  child: Text('Khách hàng',
                      style: tableTextTitle),
                  flex: 4),
              Expanded(
                  child: Text('Số tiền (₫)',
                      style: tableTextTitle),
                  flex: 3),
              Expanded(
                  child: Text('Thời gian',
                      style: tableTextTitle),
                  flex: 2),
            ],
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount:
              controller.orders.length > 10 ? 10 : controller.orders.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Divider(
                  height: 0,color: kPrimaryLightColor,
                ),
                _buildTableRow(
                    order: controller.orders[index], index: index + 1),
              ],
            );
          },
        )
      ],
    ));
  }

  Widget _buildTableRow({OrderModel order, int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
                '$index',style: tableText,
              ),
              flex: 1),
          Expanded(
              child: Text(
                order.customerName,style: tableText,
              ),
              flex: 4),
          Expanded(
              child: Text(
                '${NumberHelper.currencyFormat(order.getPriceOrder)}',style: tableText,
              ),
              flex: 3),
          Expanded(
              child: Text(
                order.getShortDate,style: tableText,
              ),
              flex: 2),
        ],
      ),
    );
  }

  Widget _buildLineStatistic(
      {String title, int price, IconData icon, Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(width: 5),
            Text(title,style: TextStyle(color: kWhiteTextColor),)
          ],
        ),
        Text('₫${NumberHelper.currencyFormat(price)}',style: TextStyle(color: kWhiteTextColor),)
      ],
    );
  }
}
