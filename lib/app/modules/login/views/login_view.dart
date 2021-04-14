import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class LoginView extends GetView<LoginController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                    width: 200.0,
                  ),
                  SizedBox(height: 50.0),
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
                          ? 'Đăng nhập...'
                          : 'Đăng nhập',
                      onPressed: controller.isProcessing.value
                          ? null
                          : () async {
                              if (_formKey.currentState.validate()) {
                                await controller.login(
                                    email: controller.emailController.text,
                                    password:
                                        controller.passwordController.text);
                              }
                            },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Bạn chưa có tài khoản?'),
                      InkWell(
                          onTap: () {
                            controller.isProcessing.value = false;
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: Text(
                            ' Đăng ký',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
