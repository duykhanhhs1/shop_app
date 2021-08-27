import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
    this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: order.products.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                CachedNetworkImage(
                    imageUrl: order.products[index].link_image,
                    errorWidget: (context, url, error) => ErrorImage(size: 20),
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover),
                SizedBox(width: 10),
                Expanded(
                  child: SizedBox(
                    height: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          order.products[index].name,
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                                '₫${NumberHelper.currencyFormat(order.products[index].price)}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.6))),
                            Text(
                                'x${NumberHelper.currencyFormat(order.products[index].count)}',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(.6)))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(10),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Tổng số tiền (${order.quantity} sản phẩm)'),
            Text('₫${NumberHelper.currencyFormat(order.total_price)}',
                style: TextStyle(
                    color: kSecondaryColor, fontWeight: FontWeight.bold))
          ]),
        ),
      ],
    );
  }
}
