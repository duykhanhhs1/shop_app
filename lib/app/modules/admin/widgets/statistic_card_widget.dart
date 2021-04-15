import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:scrum_app/app/theme/color_theme.dart';

class StatisticCard extends StatelessWidget {
  const StatisticCard({
    Key key,
    this.title,
    this.quantity,
    this.balance,
  }) : super(key: key);
  final String title;
  final int quantity;
  final double balance;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: 16, color: kLightTextColor)),
            Text(NumberFormat('#,###').format(quantity),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            Row(
              children: [
                Icon(
                  balance > 0
                      ? CupertinoIcons.arrow_up_right_circle
                      : CupertinoIcons.arrow_down_right_circle,
                  color: balance > 0 ? kPrimaryColor : Colors.deepOrange,
                ),
                SizedBox(width: 5),
                Text(
                  balance > 0 ? '+$balance%' : '$balance%',
                  style: TextStyle(
                      color: balance > 0 ? kPrimaryColor : Colors.deepOrange,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
