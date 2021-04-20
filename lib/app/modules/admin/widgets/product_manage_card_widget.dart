import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/modules/admin/views/product_management_view.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';

class ProductManageCard extends GetView<AdminController> {
  const ProductManageCard(
    this.product, {
    Key key,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionExtentRatio: .2,
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: [
        IconSlideAction(
          icon: Icons.edit_outlined,
          caption: 'Cập nhật',
          color: Colors.blue,
          onTap: () {
            ProductManagementView().buildFormProduct(
                productReceive: product, title: 'Cập nhật sản phẩm');
          },
        ),
        IconSlideAction(
          icon: Icons.delete_outline,
          caption: 'Xóa',
          color: kSecondaryColor,
          onTap: () {
            controller.removeProduct(product);
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        child: Row(
          children: [
            if (controller.isCheck.value)
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        controller.setCheckedProduct(product);
                      },
                      child: Icon(
                        product.isChecked
                            ? Icons.check_box_outlined
                            : Icons.check_box_outline_blank,
                        color: product.isChecked
                            ? kSecondaryColor
                            : kLightTextColor,
                      )),
                  SizedBox(width: 14),
                ],
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '₫${NumberHelper.currencyFormat(product.price)}',
                    style: TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.bold),
                  ),
                  Text('Kho: ${NumberHelper.currencyFormat(product.amount)}')
                ],
              ),
            ),
            SizedBox(width: 14),
            Image.network(
              product.imageUrls[0],
              fit: BoxFit.cover,
              width: 75,
              height: 75,
            ),
          ],
        ),
      ),
    );
  }
}
