import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/modules/admin/views/product_management_view.dart';

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
          caption: 'Sửa',
          color: Colors.blue,
          onTap: (){
            ProductManagementView().buildFormAddCustomerDialog(product);
          },
        ),
        IconSlideAction(
          icon: Icons.delete_outline,
          caption: 'Xóa',
          color: Colors.deepOrange,
          onTap: (){controller.removeProduct(product);},
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
                      onTap: () {},
                      child: Icon(
                        Icons.check_box_outline_blank,
                        color: Colors.black.withOpacity(.6),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('${product.price} VND'),
                  Text('Kho: ${product.amount}')
                ],
              ),
            ),
            SizedBox(width: 14),
            ClipRRect(
              child: Image.network(
                'https://kenh14cdn.com/2018/10/30/photo-1-15409085973371237270098.jpg',
                width: 60,
                height: 60,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
          ],
        ),
      ),
    );
  }
}
