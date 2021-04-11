import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/product_model.dart';

class OrderPaymentItem extends StatelessWidget {
  const OrderPaymentItem({
    Key key,
    this.order,
  }) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Image.network(order.product.imageUrl,
                  height: 70, width: 70, fit: BoxFit.cover),
              SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        order.product.name,
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('₫${order.product.price}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6))),
                          Text('x${order.quantity}',
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
        Divider(height: 0),
        Padding(
          padding: const EdgeInsets.all(10),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Tổng số tiền (${order.quantity} sản phẩm)'),
            Text('₫${order.getPriceOrder}',
                style: TextStyle(
                    color: Colors.deepOrange, fontWeight: FontWeight.bold))
          ]),
        ),
      ],
    );
  }
}
