import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';
import 'package:scrum_app/app/widgets/number_input_field_widget.dart';

class ProductCartItem extends StatelessWidget {
  const ProductCartItem({
    Key key,
    this.product,
    this.controller,
  }) : super(key: key);

  final ProductOverViewModel product;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    product.quantityController.text = '${product.count}';
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: .2,
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: kSecondaryColor,
          caption: 'Xóa',
          onTap: () {
            //controller.removeOrder(product);
          },
        )
      ],
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      controller.toggleChecked(product);
                    },
                    child: Icon(
                        product.isChecked
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        color: product.isChecked
                            ? kSecondaryColor
                            : Colors.black54),
                  ),
                  Image.network(product.link_image,
                      height: 70, width: 70, fit: BoxFit.cover),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.name,
                          style: TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '₫${NumberHelper.currencyFormat(product.getPriceCart)}',
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            NumberInputIncDec(
                              textController: product.quantityController,
                              setValue: () {
                                product.count = int.tryParse(
                                    product.quantityController.text);
                                controller.update();
                              },
                            )
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
      ),
    );
  }
}
