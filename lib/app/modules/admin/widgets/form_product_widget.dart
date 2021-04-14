import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/widgets/form_input_field.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class FormProduct extends StatelessWidget {
  const FormProduct({Key key, this.productReceive, this.title, this.formKey})
      : super(key: key);
  final ProductModel productReceive;
  final String title;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AdminController.to,
      builder: (AdminController controller) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 14),
          contentPadding: const EdgeInsets.all(14),
          titlePadding: const EdgeInsets.all(10),
          actionsPadding: const EdgeInsets.all(5),
          title: Column(
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Container(
            width: Get.width,
            child: SingleChildScrollView(
                child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormInputField(
                    title: 'Tên',
                    require: true,
                    child: FormRoundedInputField(
                      initialValue: controller.product.value.name == null
                          ? ''
                          : controller.product.value.name,
                      onChanged: (value) {
                        controller.product.value.name = value;
                      },
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 15),
                  FormInputField(
                    title: 'Giá',
                    require: true,
                    child: FormRoundedInputField(
                      initialValue: controller.product.value.price == null
                          ? ''
                          : controller.product.value.price.toString(),
                      onChanged: (value) {
                        controller.product.value.price = int.tryParse(value);
                      },
                      borderRadius: BorderRadius.circular(5),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(height: 15),
                  FormInputField(
                    title: 'Số lượng',
                    require: true,
                    child: FormRoundedInputField(
                      initialValue: controller.product.value.amount == null
                          ? ''
                          : controller.product.value.amount.toString(),
                      onChanged: (value) {
                        controller.product.value.amount = int.tryParse(value);
                      },
                      keyboardType: TextInputType.number,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 15),
                  FormInputField(
                    title: 'Giảm giá (%)',
                    child: FormRoundedInputField(
                      initialValue: controller.product.value.discount == null
                          ? ''
                          : controller.product.value.discount.toString(),
                      onChanged: (value) {
                        controller.product.value.discount = int.tryParse(value);
                      },
                      keyboardType: TextInputType.number,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 15),
                  FormInputField(
                    title: 'Mô tả',
                    child: FormRoundedInputField(
                      initialValue: controller.product.value.desc == null
                          ? ''
                          : controller.product.value.desc,
                      onChanged: (value) {
                        controller.product.value.desc = value;
                      },
                      maxLines: 3,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(height: 15),
                  //buildFormUploadImage(controller),
                  SizedBox(height: 15),
                ],
              ),
            )),
          ),
          actions: [
            RoundedButton(
              radius: 5,
              height: 40,
              textContent: 'Lưu',
              onPressed: () {
                if (formKey.currentState.validate()) {
                  if (controller.product.value.productNo != null) {
                    controller.updateProduct(controller.product.value);
                  } else
                    controller.addProduct(controller.product.value);
                  Get.back();
                }
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
    );
  }
}
