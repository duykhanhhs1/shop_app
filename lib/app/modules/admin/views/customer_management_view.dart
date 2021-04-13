import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:scrum_app/app/modules/admin/widgets/bottom_check_remove_widget.dart';
import 'package:scrum_app/app/modules/admin/widgets/user_manage_card.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/app_bottom_bar_admin_widget.dart';
import 'package:scrum_app/app/widgets/form_input_field.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

import '../controllers/admin_controller.dart';

class CustomerManagementView extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<AdminController>(),
      builder: (AdminController controller) {
        return Scaffold(
            appBar: AppBar(
              leading: Center(
                child: InkWell(
                    onTap: () {
                      controller.setCheck();
                    },
                    child: Text(controller.isCheck.value ? 'Xong' : 'Sửa')),
              ),
              title: Text('Quản lý khách hàng'),
              centerTitle: true,
            ),
            bottomNavigationBar: controller.isCheck.value
                ? BottomCheckRemove()
                : AppBottomNavigationBarAdmin(0),
            body: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    height: 50,
                    child: FormRoundedInputField(
                      borderColor: Colors.transparent,
                      prefixIcon: Icons.search,
                      fillColor: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    )),
                if(controller.users.length > 0)
                Divider(thickness: 1, height: 1),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                    return Column(
                      children: [
                        UserCard(controller.users[index]),
                        Divider(thickness: 1, height: 0),
                      ],
                    );
                  },),
                ),
              ],
            ));
      },
    );
  }
}



