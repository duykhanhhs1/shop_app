import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';

import 'package:scrum_app/app/widgets/number_input_field_widget.dart';

class CartItemContainer extends StatelessWidget {
  const CartItemContainer({
    Key key,
    this.cartItem,
    this.onTap,
    this.controller,
  }) : super(key: key);

  final OrderModel cartItem;
  final Function onTap;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    cartItem.quantityController.text = '${cartItem.quantity}';
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: .2,
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.deepOrange,
          caption: 'Xóa',
          onTap: onTap,
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
                      controller.toggleChecked(cartItem);
                    },
                    child: Icon(
                        cartItem.isChecked
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        color: cartItem.isChecked
                            ? Colors.deepOrange
                            : Colors.black54),
                  ),
                  Image.network(cartItem.product.imageUrl,
                      height: 70, width: 70, fit: BoxFit.cover),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          cartItem.product.name,
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${controller.getPrice(cartItem)}',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            NumberInputIncDec(
                              textController: cartItem.quantityController,
                              setValue: () {
                                cartItem.quantity = int.tryParse(
                                    cartItem.quantityController.text);
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
