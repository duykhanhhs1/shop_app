import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/widgets/number_input_field_widget.dart';

class OrderCartItem extends StatelessWidget {
  const OrderCartItem({
    Key key,
    this.order,
    this.controller,
  }) : super(key: key);

  final OrderModel order;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    order.quantityController.text = '${order.quantity}';
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: .2,
      secondaryActions: [
        IconSlideAction(
          icon: Icons.delete,
          color: Colors.deepOrange,
          caption: 'Xóa',
          onTap: () {
            controller.removeOrder(order);
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
                      controller.toggleChecked(order);
                    },
                    child: Icon(
                        order.isChecked
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        color: order.isChecked
                            ? Colors.deepOrange
                            : Colors.black54),
                  ),
                  Image.network(order.product.imageUrl,
                      height: 70, width: 70, fit: BoxFit.cover),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          order.product.name,style: TextStyle(fontSize: 16),
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('₫${order.getPriceOrder}',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            NumberInputIncDec(
                              textController: order.quantityController,
                              setValue: () {
                                order.quantity =
                                    int.tryParse(order.quantityController.text);
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
