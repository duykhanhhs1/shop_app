import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
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
              actions: [
                IconButton(
                  onPressed: () {
                    Get.dialog(AlertDialog(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 14),
                      contentPadding: const EdgeInsets.all(14),
                      titlePadding: const EdgeInsets.all(14),
                      actionsPadding: const EdgeInsets.all(14),
                      title: Column(
                        children: [
                          Text(
                            'Thêm khách hàng',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(height: 0,)
                        ],
                      ),
                      content: Container(
                        width: Get.width,
                        child: SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormInputField(
                              title: 'Tên',
                              child: FormRoundedInputField(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(height: 15),
                            FormInputField(
                                title: 'Giới tính',
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: kPrimaryColor),
                                      borderRadius: BorderRadius.circular(5)),
                                  width: Get.width,
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                    value: null,
                                    onChanged: (value) {},
                                    items: <String>[
                                      'Nam',
                                      'Nữ',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                                )),
                            SizedBox(height: 15),
                            FormInputField(
                              title: 'Số điện thoại',
                              child: FormRoundedInputField(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(height: 15),
                            FormInputField(
                              title: 'Email',
                              child: FormRoundedInputField(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        )),
                      ),
                      actions: [
                        RoundedButton(
                          radius: 5,
                          height: 40,
                          textContent: 'Lưu',
                          onPressed: () {},
                        ),
                        RoundedButton(
                          radius: 5,
                          height: 40,
                          textContent: 'Đóng',
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ));
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
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
                      fillColor: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    )),
                UserCard(),
                Divider(thickness: 1, height: 1),
              ],
            ));
      },
    );
  }
}

class BottomCheckRemove extends StatelessWidget {
  const BottomCheckRemove({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.black.withOpacity(.6),
                  )),
              SizedBox(width: 5),
              Text('Tất cả')
            ],
          ),
          Text(
            'Xóa',
            style: TextStyle(color: Colors.deepOrange),
          )
        ],
      ),
    );
  }
}

class UserCard extends GetView<AdminController> {
  const UserCard({
    Key key,
  }) : super(key: key);

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
        ),
        IconSlideAction(
          icon: Icons.delete_outline,
          caption: 'Xóa',
          color: Colors.deepOrange,
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
                    'Tran Duy Khanh',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('Vinh, Nghe An'),
                  Text('0328264648')
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
