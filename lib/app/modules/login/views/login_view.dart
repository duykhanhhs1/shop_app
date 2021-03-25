import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';
import 'package:form_field_validator/form_field_validator.dart';




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
                    'images/logo.png',
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
                      RequiredValidator(errorText: 'Email is required'),
                      EmailValidator(errorText: 'Invalid email'),
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
                    hintText: 'Password',
                    validator: MultiValidator(
                      [
                        RequiredValidator(errorText: 'Password is required'),
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
                      textContent:
                      controller.isProcessing.value ? 'Login...' : 'Login',
                      onPressed: () async {
                        // if (_formKey.currentState.validate()) {
                        //   controller.verifyUser();
                        // }
                        Get.offAllNamed(Routes.HOME);
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // FlatButton(
                  //   minWidth: Get.width,
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(18.0),
                  //   ),
                  //   child: Text(
                  //     'Forgot password?',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       color: kPrimaryColor,
                  //     ),
                  //   ),
                  //   onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
