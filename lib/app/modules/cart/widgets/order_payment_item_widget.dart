import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';

class OrderPaymentItem extends StatelessWidget {
  const OrderPaymentItem({
    Key key,
    this.order,
    this.controller,
  }) : super(key: key);

  final OrderModel order;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(.15),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Image.network(order.product.imageUrl,
                    height: 70, width: 70, fit: BoxFit.cover),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        order.product.name,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text('₫${order.getPriceOrder}')],
                          ),
                          Text('x${order.quantity}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6)))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
