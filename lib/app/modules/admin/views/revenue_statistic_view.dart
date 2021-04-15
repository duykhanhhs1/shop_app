import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/modules/admin/widgets/statistic_card_widget.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
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
              Padding(
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
              ),
              Card(
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Doanh thu',
                        style: TextStyle(fontSize: 16, color: kLightTextColor),
                      ),
                      SizedBox(height: 5),
                      Text('₫20,000,000',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      _buildLineStatistic(
                          title: 'Tổng thu',
                          price: '55,000,000',
                          icon: CupertinoIcons.arrow_right_circle,
                          color: kPrimaryColor),
                      SizedBox(height: 10),
                      _buildLineStatistic(
                          title: 'Tổng chi',
                          price: '35,000,000',
                          icon: CupertinoIcons.arrow_left_circle,
                          color: Colors.deepOrange),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              GridView(
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
              ),
              SizedBox(height: 20),
              _buildTableOrders(),
              SizedBox(height: 20),
              Card(
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
                                style: TextStyle(
                                    fontSize: 16, color: kLightTextColor),
                              ),
                              Text('6 tháng gần đây',
                                  style: TextStyle(color: kLightTextColor))
                            ],
                          ),
                          SizedBox(height: 10),
                          Text('₫120,650,000',
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      width: Get.width,
                      height: 250,
                      child: LineChart(LineChartData(
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                              tooltipBgColor: Colors.grey.shade100),
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
                            getTextStyles: (value) => const TextStyle(
                                color: kLightTextColor, fontSize: 16),
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
                              ColorTween(
                                      begin: kPrimaryColor, end: kPrimaryColor)
                                  .lerp(0),
                            ],
                            barWidth: 3,
                            isStrokeCapRound: false,
                            dotData: FlDotData(
                              show: false,
                            ),
                            belowBarData: BarAreaData(show: true, colors: [
                              ColorTween(
                                      begin: kPrimaryColor, end: Colors.white)
                                  .lerp(0.93),
                            ]),
                          ),
                        ],
                      )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableOrders() {
    return Card(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danh sách đơn hàng mới',
          style: TextStyle(color: kLightTextColor, fontSize: 16),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Row(
            children: [
              Expanded(
                  child: Text('STT',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  flex: 1),
              Expanded(
                  child: Text('Khách hàng',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  flex: 4),
              Expanded(
                  child: Text('Số tiền (₫)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  flex: 3),
              Expanded(
                  child: Text('Thời gian',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  flex: 2),
            ],
          ),
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.orders.length > 10 ? 10 : controller.orders.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Divider(height: 0,),
                _buildTableRow(
                    order: controller.orders[index], index: index + 1),
              ],
            );
          },
        )
      ],
    ));
  }

  Padding _buildTableRow({OrderModel order, int index}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        children: [
          Expanded(
              child: Text(
                '$index',
              ),
              flex: 1),
          Expanded(
              child: Text(
                order.customerName,
              ),
              flex: 4),
          Expanded(
              child: Text(
                '${order.getPriceOrder}',
              ),
              flex: 3),
          Expanded(
              child: Text(
                order.getShortDate,
              ),
              flex: 2),
        ],
      ),
    );
  }

  Widget _buildLineStatistic(
      {String title, String price, IconData icon, Color color}) {
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
            Text(title)
          ],
        ),
        Text('₫$price')
      ],
    );
  }
}
