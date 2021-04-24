import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/custom_list_tile_widget.dart';
import 'package:scrum_app/app/widgets/form_add_image_widget.dart';
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
          return controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      controller.currentUser.imageUrl == null
                                          ? 'https://i.stack.imgur.com/l60Hf.png'
                                          : controller.currentUser.imageUrl,
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    child: InkWell(
                                      onTap: () {
                                        Get.bottomSheet(FormAddImage(
                                          onTapGallery: () {
                                            controller.pickAvatarProfile(
                                                ImageSource.gallery);
                                          },
                                          onTapCamera: () {
                                            controller.pickAvatarProfile(
                                                ImageSource.camera);
                                          },
                                        ));
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.all(3),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade300),
                                          child: Icon(
                                            Icons.camera_alt_rounded,
                                            size: 17,
                                          )),
                                    ),
                                    bottom: 0,
                                    right: 0,
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.currentUser.fullName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    controller.currentUser.phone,
                                    style: TextStyle(color: kLightTextColor),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(thickness: 5, height: 0),
                        CustomListTile(
                            onTap: () {
                              Get.toNamed(Routes.ORDER_MANAGEMENT);
                            },
                            iconData: Icons.article_outlined,
                            title: 'Đơn mua',
                            color: kPrimaryColor,
                            secondText: 'Xem lịch sử mua hàng'),
                        Divider(height: 0),
                        CustomListTile(
                            onTap: () {
                              controller.getFavoriteProducts();
                              Get.toNamed(Routes.FAVORITE);
                            },
                            iconData: Icons.favorite_border,
                            color: Colors.deepOrange,
                            title: 'Yêu thích'),
                        Divider(height: 0),
                        CustomListTile(
                            onTap: () {
                              _showFormEditDialog();
                            },
                            iconData: Icons.account_box_outlined,
                            color: Colors.blue,
                            title: 'Tài khoản'),
                        Divider(height: 0),
                        CustomListTile(
                            color: Colors.yellowAccent.shade700,
                            iconData: Icons.help_outline,
                            title: 'Trung tâm trợ giúp'),
                        Divider(height: 0),
                        CustomListTile(
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
                              LoginController.to.logout();
                            }))
                  ],
                );
        },
      ),
    );
  }

  Future<dynamic> _showFormEditDialog() {
    controller.userCreate = controller.userModel;
    // UserModel user = controller.currentUser;
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
                              initialValue:
                                  controller.userCreate.value.fullName,
                              onChanged: (value) => {
                                controller.userCreate.value.fullName = value
                              },
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
                                  value: controller.userCreate.value.gender ??
                                      null,
                                  onChanged: (value) {
                                    controller.setGender(value);
                                  },
                                  items: <String>[
                                    'Nam',
                                    'Nữ',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Text(value),
                                      ),
                                      // child: Text("value"),
                                    );
                                  }).toList(),
                                )),
                              )),
                          SizedBox(height: 15),
                          FormInputField(
                            title: 'Địa chỉ',
                            child: FormRoundedInputField(
                              initialValue: controller.userCreate.value.address,
                              onChanged: (value) =>
                                  {controller.userCreate.value.address = value},
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),
                          FormInputField(
                            title: 'Số điện thoại',
                            child: FormRoundedInputField(
                              keyboardType: TextInputType.phone,
                              initialValue: controller.userCreate.value.phone,
                              onChanged: (value) =>
                                  {controller.userCreate.value.phone = value},
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),
                          FormInputField(
                            title: 'Email',
                            child: FormRoundedInputField(
                              keyboardType: TextInputType.emailAddress,
                              initialValue: controller.userCreate.value.email,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),
                          FormInputField(
                            title: 'Mô tả',
                            child: FormRoundedInputField(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              initialValue:
                                  controller.userCreate.value.description ?? '',
                              onChanged: (value) => {
                                controller.userCreate.value.description = value
                              },
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
                  controller.updateUser();
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
    print(controller.currentUser.fullName);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileField(title: 'Tên', content: controller.currentUser.fullName),
        SizedBox(height: 15),
        if (controller.currentUser.gender != null)
          Column(
            children: [
              ProfileField(
                  title: 'Giới tính', content: controller.currentUser.gender),
              SizedBox(height: 15),
            ],
          ),
        ProfileField(
            title: 'Số điện thoại', content: controller.currentUser.phone),
        SizedBox(height: 15),
        ProfileField(title: 'Email', content: controller.currentUser.email),
        SizedBox(height: 15),
        if (controller.currentUser.description != null)
          Column(
            children: [
              ProfileField(
                  title: 'Mô tả', content: controller.currentUser.description),
              SizedBox(height: 15),
            ],
          ),
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

  String getContent() {
    return this.content;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(
          content != null ? content : "",
        ),
      ],
    );
  }
}
