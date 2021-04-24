import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/modules/admin/widgets/user_manage_card.dart';
import 'package:scrum_app/app/modules/profile/views/profile_view.dart';
import 'package:scrum_app/app/widgets/app_bottom_bar_admin_widget.dart';
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
              /*leading: InkWell(
                  onTap: () {
                    controller.setCheck();
                  },
                  child: Center(
                      child: Text(controller.isCheck.value ? 'Xong' : 'Sửa'))),*/
              leading: SizedBox(),
              title: Text('Quản lý khách hàng'),
              centerTitle: true,
            ),
            bottomNavigationBar: AppBottomNavigationBarAdmin(0),
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
                if (controller.users.length > 0)
                  Divider(thickness: 1, height: 1),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async{
                      controller.getUsers();
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.users.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  Get.dialog(
                                    AlertDialog(
                                      insetPadding: EdgeInsets.all(10),
                                      title: Text(
                                        'Thông tin khách hàng',
                                        textAlign: TextAlign.center,
                                      ),
                                      content:
                                          _buildInfoUser(controller.users[index]),
                                      actions: [
                                        RoundedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          radius: 5,
                                          textContent: 'Đóng',
                                        )
                                      ],
                                    ),
                                  );
                                },
                                child: UserCard(controller.users[index])),
                            Divider(thickness: 1, height: 0),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}

Widget _buildInfoUser(UserModel user) {
  return Container(
    width: Get.width,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileField(title: 'Tên', content: user.fullName),
        SizedBox(height: 15),
        if (user.gender != null)
          Column(
            children: [
              ProfileField(title: 'Giới tính', content: user.gender),
              SizedBox(height: 15),
            ],
          ),
        ProfileField(title: 'Số điện thoại', content: user.phone),
        SizedBox(height: 15),
        ProfileField(title: 'Email', content: user.email),
        SizedBox(height: 15),
        if (user.description != null)
          Column(
            children: [
              ProfileField(title: 'Mô tả', content: user.description),
              SizedBox(height: 15),
            ],
          ),
      ],
    ),
  );
}
