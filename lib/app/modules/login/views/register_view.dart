import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class RegisterView extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Thông tin đăng ký',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: kPrimaryColor),
                ),
                SizedBox(height: 60.0),
                FormRoundedInputField(
                  controller: controller.usernameController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.white.withOpacity(0.75),
                  prefixIcon: Icons.person,
                  hintText: 'Username',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Vui lòng nhập username'),
                  ]),
                  keyboardType: TextInputType.text,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                      controller.usernameController.text = value,
                ),
                SizedBox(height: 20),
                FormRoundedInputField(
                  controller: controller.emailController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.white.withOpacity(0.75),
                  prefixIcon: Icons.email,
                  hintText: 'Email',
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Vui lòng nhập email'),
                    EmailValidator(errorText: 'Email không hợp lệ'),
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) => controller.emailController.text = value,
                ),
                SizedBox(height: 20),
                FormRoundedInputField(
                  controller: controller.passwordController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  fillColor: Colors.white.withOpacity(0.75),
                  prefixIcon: Icons.lock,
                  hintText: 'Mật khẩu',
                  validator: MultiValidator(
                    [
                      RequiredValidator(errorText: 'Vui lòng nhập mật khẩu'),
                      MinLengthValidator(6,
                          errorText: 'Mật khẩu ít nhất 6 kí tự')
                    ],
                  ),
                  obscureText: true,
                  onChanged: (value) => null,
                  onSaved: (value) =>
                  controller.passwordController.text = value,
                  maxLines: 1,
                ),
                SizedBox(height: 20),
                Obx(
                      () => RoundedButton(
                    width: Get.width,
                    textContent: controller.isProcessing.value
                        ? 'Đăng ký...'
                        : 'Đăng ký',
                    onPressed: controller.isProcessing.value
                        ? null
                        : () async {
                      if (_formKey.currentState.validate()) {
                        controller.register();
                            }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bạn đã có tài khoản?'),
                    InkWell(
                        onTap: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text(
                          ' Đăng nhập',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ))
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
