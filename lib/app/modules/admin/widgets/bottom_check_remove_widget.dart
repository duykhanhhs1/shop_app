import 'package:flutter/material.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class BottomCheckRemove extends StatelessWidget {
  const BottomCheckRemove({
    Key key,
    this.controller,
  }) : super(key: key);

  final AdminController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      color: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              controller.setCheckedAll();
            },
            child: Row(
              children: [
                Icon(
                  controller.isCheckedAll.value
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                  color: controller.isCheckedAll.value
                      ? kSecondaryColor
                      : kLightTextColor,
                ),
                SizedBox(width: 5),
                Text('Tất cả')
              ],
            ),
          ),
          if (controller.checkedProducts.length > 0)
            IconButton(
                onPressed: () {
                  controller.removeChecked();
                },
                icon: Icon(
                  Icons.delete,
                  color: kSecondaryColor,
                ))
        ],
      ),
    );
  }
}
