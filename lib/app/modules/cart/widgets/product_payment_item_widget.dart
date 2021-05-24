import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';

class ProductPaymentItem extends StatelessWidget {
  const ProductPaymentItem({
    Key key,
    this.product,
  }) : super(key: key);

  final ProductOverViewModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Image.network(product.link_image,
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
                        product.name,
                        style: TextStyle(fontSize: 16),
                        maxLines: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '₫${NumberHelper.currencyFormat(product.price)}',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(.6))),
                          Text(
                              'x${NumberHelper.currencyFormat(product.count)}',
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
            Text('Tổng số tiền (${product.count} sản phẩm)'),
            Text('₫${NumberHelper.currencyFormat(product.getPriceCart)}',
                style: TextStyle(
                    color: kSecondaryColor, fontWeight: FontWeight.bold))
          ]),
        ),
      ],
    );
  }
}
