import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/admin/widgets/bottom_check_remove_widget.dart';
import 'package:scrum_app/app/modules/admin/widgets/product_manage_card_widget.dart';

import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/app_bottom_bar_admin_widget.dart';
import 'package:scrum_app/app/widgets/form_input_field.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

import '../controllers/admin_controller.dart';

class ProductManagementView extends GetView<AdminController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              title: Text('Quản lý sản phẩm'),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      buildFormAddCustomerDialog(
                          productReceive: ProductModel(),
                          title: 'Thêm sản phẩm');
                    },
                    icon: Icon(Icons.add, color: Colors.white))
              ],
            ),
            bottomNavigationBar: controller.isCheck.value
                ? BottomCheckRemove()
                : AppBottomNavigationBarAdmin(1),
            body: Column(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                    height: 50,
                    child: FormRoundedInputField(
                      onChanged: (_){
                        controller.searchProducts();
                      },
                      controller: controller.productInputController,
                      borderColor: Colors.transparent,
                      prefixIcon: Icons.search,
                      fillColor: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    )),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.showProducts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ProductManageCard(controller.showProducts[index]),
                          Divider(thickness: 1, height: 0)
                        ],
                      );
                    },
                  ),
                )
              ],
            ));
      },
    );
  }

  Future<dynamic> buildFormAddCustomerDialog(
      {ProductModel productReceive, String title}) {
    controller.product.value = productReceive;
    return Get.dialog(GetBuilder(
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
              key: _formKey,
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
                  buildFormUploadImage(controller),
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
                if (_formKey.currentState.validate()) {
                  if (controller.product.value.productNo != null) {
                    productReceive = controller.product.value;
                    controller.updateProduct(productReceive);
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
    ));
  }

  Row buildFormUploadImage(AdminController controller) {
    return Row(
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, mainAxisSpacing: 5, crossAxisSpacing: 5),
            shrinkWrap: true,
            itemCount: controller.product.value.imageUrls.length + 1,
            itemBuilder: (context, index) {
              if (index == 0)
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: InkWell(
                    onTap: () async {
                      controller.pickImage();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: kPrimaryColor,
                            size: 27,
                          ),
                          Text(
                            'Thêm ảnh',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.black)],
                          color: Colors.white),
                    ),
                  ),
                );
              return SizedBox(
                  child: Image.network(
                controller.product.value.imageUrls[index - 1],
                fit: BoxFit.cover,
              ));
            },
          ),
        )
      ],
    );
  }
}
