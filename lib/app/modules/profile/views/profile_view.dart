import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/form_input_field.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trang cá nhân'),
        centerTitle: true,
      ),
      body: GetBuilder(
        builder: (ProfileController controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/images/Profile Image.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Duy Khanh',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text('description'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 5, height: 0),
                  _buildListTile(
                      iconData: Icons.article_outlined,
                      title: 'Đơn mua',
                      color: kPrimaryColor,
                      secondText: 'Xem lịch sử mua hàng'),
                  Divider(height: 0),
                  _buildListTile(
                      iconData: Icons.favorite_border,
                      color: Colors.deepOrange,
                      title: 'Yêu thích'),
                  Divider(height: 0),
                  InkWell(
                    onTap: () {
                      _showFormEditDialog();
                    },
                    child: _buildListTile(
                        iconData: Icons.account_box_outlined,
                        color: Colors.blue,
                        title: 'Tài khoản'),
                  ),
                  Divider(height: 0),
                  _buildListTile(
                      color: Colors.yellowAccent.shade700,
                      iconData: Icons.help_outline,
                      title: 'Trung tâm trợ giúp'),
                  Divider(height: 0),
                  _buildListTile(
                      color: Colors.red,
                      iconData: Icons.account_balance_wallet_outlined,
                      title: 'Ví voucher'),
                  Divider(height: 0),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: RoundedButton(
                      color: Colors.deepOrange,
                      textContent: 'Đăng xuất',
                      width: Get.width * 0.9,
                      onPressed: () {
                        Get.offAllNamed(Routes.LOGIN);
                      }))
            ],
          );
        },
      ),
    );
  }

  Future<dynamic> _showFormEditDialog() {
    return Get.dialog(GetBuilder(
      builder: (ProfileController controller) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 14),
          contentPadding: const EdgeInsets.all(14),
          titlePadding: const EdgeInsets.all(14),
          actionsPadding: const EdgeInsets.all(14),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thông tin cá nhân',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (!controller.isEditProfile.value)
                    InkWell(
                      child: Icon(
                        Icons.edit_outlined,
                        color: kPrimaryColor,
                      ),
                      onTap: () {
                        controller.setOpenEditForm(true);
                      },
                    )
                ],
              ),
              Divider()
            ],
          ),
          content: Container(
            width: Get.width,
            child: SingleChildScrollView(
                child: controller.isEditProfile.value
                    ? Column(
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
                                borderRadius: BorderRadius.circular(5)
                              ),
                              width: Get.width,
                              child: DropdownButtonHideUnderline(child: DropdownButton(
                                value: null,
                                onChanged: (value){

                                },
                                items:<String>['Nam', 'Nữ',]
                                    .map<DropdownMenuItem<String>>((String value) {
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
                      )
                    : _buildInfoUser()),
          ),
          actions: [
            if (controller.isEditProfile.value)
              RoundedButton(
                radius: 5,
                height: 40,
                textContent: 'Lưu',
                onPressed: () {
                  controller.setOpenEditForm(false);
                  //Get.back();
                },
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
        );
      },
    ));
  }

  Widget _buildInfoUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileField(title: 'Tên', content: 'Duy Khánh'),
        SizedBox(height: 15),
        ProfileField(title: 'Giới tính', content: 'Nam'),
        SizedBox(height: 15),
        ProfileField(title: 'Số điện thoại', content: '0328264648'),
        SizedBox(height: 15),
        ProfileField(title: 'Email', content: 'duykhanh@gmail.com'),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildListTile(
      {IconData iconData, Color color, String title, String secondText = ''}) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            horizontalTitleGap: 0,
            leading: Icon(
              iconData,
              color: color,
            ),
            title: Text(title),
          ),
        ),
        Row(
          children: [
            Text(secondText),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black.withOpacity(.6),
            ),
            SizedBox(width: 12)
          ],
        )
      ],
    );
  }
}

class ProfileField extends StatelessWidget {
  const ProfileField({
    Key key,
    this.title,
    this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProfileController>(),
      builder: (ProfileController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(content),
          ],
        );
      },
    );
  }
}

