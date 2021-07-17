import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
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
          ProfileModel profile = controller.currentUser.profile;
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
                                      profile.photo_url,
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
                                  if (profile.first_name != null &&
                                      profile.last_name != null)
                                    Text(
                                      profile.fullName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  SizedBox(height: 5),
                                  if (profile.phone_number != null)
                                    Text(
                                      profile.phone_number,
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
                              controller.getOrders();
                            },
                            iconData: Icons.article_outlined,
                            title: 'Đơn mua',
                            color: kPrimaryColor,
                            secondText: 'Xem lịch sử mua hàng'),
                        Divider(height: 0),
                        CustomListTile(
                            onTap: () {
                              /*controller.getFavoriteProducts();
                              Get.toNamed(Routes.FAVORITE);*/
                            },
                            iconData: Icons.favorite_border,
                            color: Colors.deepOrange,
                            title: 'Yêu thích'),
                        Divider(height: 0),
                        CustomListTile(
                            onTap: () {
                              _showFormEditDialog(profile);
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

  Future<dynamic> _showFormEditDialog(profile) {
    controller.userCreate = controller.userModel;
    // UserModel user = controller.currentUser;
    return Get.dialog(GetBuilder(
      builder: (ProfileController controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AlertDialog(
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
                child: controller.isEditProfile.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FormInputField(
                                  title: 'Họ',
                                  child: FormRoundedInputField(
                                    initialValue: controller
                                        .userCreate.value.profile.first_name,
                                    onChanged: (value) => {
                                      controller.userCreate.value.profile
                                          .first_name = value
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: FormInputField(
                                  title: 'Tên',
                                  child: FormRoundedInputField(
                                    initialValue: controller
                                        .userCreate.value.profile.last_name,
                                    onChanged: (value) => {
                                      controller.userCreate.value.profile
                                          .last_name = value
                                    },
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
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
                                  value: controller
                                          .userCreate.value.profile.gender ??
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
                          /*FormInputField(
                            title: 'Ngày sinh',
                            child: FormRoundedInputField(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              initialValue: controller
                                  .userCreate.value.profile.description ??
                                  '',
                              onChanged: (value) => {
                                controller.userCreate.value.profile
                                    .description = value
                              },
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),*/
                          FormInputField(
                            title: 'Địa chỉ',
                            child: FormRoundedInputField(
                              initialValue:
                                  controller.userCreate.value.profile.address,
                              onChanged: (value) => {
                                controller.userCreate.value.profile.address =
                                    value
                              },
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),
                          FormInputField(
                            title: 'Số điện thoại',
                            child: FormRoundedInputField(
                              keyboardType: TextInputType.phone,
                              initialValue: controller
                                  .userCreate.value.profile.phone_number,
                              onChanged: (value) => {
                                controller.userCreate.value.profile
                                    .phone_number = value
                              },
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),
                          FormInputField(
                            title: 'Email',
                            child: FormRoundedInputField(
                              keyboardType: TextInputType.emailAddress,
                              initialValue:
                                  controller.userCreate.value.profile.email,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      )
                    : _buildInfoUser(profile),
              ),
              actions: [
                if (controller.isEditProfile.value)
                  RoundedButton(
                    radius: 5,
                    height: 40,
                    textContent: 'Lưu',
                    onPressed: () {
                      controller.updateProfile();
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
            ),
          ],
        );
      },
    ));
  }

  Widget _buildInfoUser(ProfileModel profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileField(title: 'Tên hiển thị', content: profile.fullName),
        SizedBox(height: 15),
        ProfileField(title: 'Giới tính', content: profile.gender),
        SizedBox(height: 15),
        ProfileField(title: 'Địa chỉ', content: profile.address),
        SizedBox(height: 15),
        ProfileField(title: 'Số điện thoại', content: profile.phone_number),
        SizedBox(height: 15),
        ProfileField(title: 'Email', content: profile.email),
        SizedBox(height: 15),
        if (profile.description != null)
          Column(
            children: [
              ProfileField(title: 'Mô tả', content: profile.description),
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
        content != null
            ? Text(
                content,
              )
            : Text(
                "Chưa thiết lập",
                style: TextStyle(color: kHintTextColor),
              ),
      ],
    );
  }
}
