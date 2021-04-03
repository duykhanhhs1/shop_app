import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
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
                      buildFormAddCustomerDialog(ProductModel());
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
                      borderColor: Colors.transparent,
                      prefixIcon: Icons.search,
                      fillColor: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    )),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ProductManageCard(controller.products[index]),
                          Divider(thickness: 1, height: 1)
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

  Future<dynamic> buildFormAddCustomerDialog(ProductModel productReceive) {
    ProductModel product = productReceive;
    return Get.dialog(AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 14),
      contentPadding: const EdgeInsets.all(14),
      titlePadding: const EdgeInsets.all(14),
      actionsPadding: const EdgeInsets.all(14),
      title: Column(
        children: [
          Text(
            'Thêm sản phẩm',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 0,
          )
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
                  initialValue: product.name == null ? '' : product.name,
                  onChanged: (value) {
                    product.name = value;
                  },
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 15),
              FormInputField(
                title: 'Giá',
                require: true,
                child: FormRoundedInputField(
                  initialValue:
                      product.price == null ? '' : product.price.toString(),
                  onChanged: (value) {
                    product.price = int.tryParse(value);
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
                  initialValue:
                      product.amount == null ? '' : product.amount.toString(),
                  onChanged: (value) {
                    product.amount = int.tryParse(value);
                  },
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 15),
              FormInputField(
                title: 'Giảm giá (%)',
                child: FormRoundedInputField(
                  initialValue: product.discount == null
                      ? ''
                      : product.discount.toString(),
                  onChanged: (value) {
                    product.discount = int.tryParse(value);
                  },
                  keyboardType: TextInputType.number,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 15),
              FormInputField(
                title: 'Mô tả',
                child: FormRoundedInputField(
                  initialValue: product.desc == null ? '' : product.desc,
                  onChanged: (value) {
                    product.desc = value;
                  },
                  maxLines: 3,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            color: kPrimaryColor,
                          ),
                          Text(
                            'Thêm ảnh',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )
                        ],
                      ),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.grey)],
                          color: Colors.white),
                    ),
                  )
                ],
              ),
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
              if (product.productNo != null) {
                productReceive = product;
                controller.updateProduct(productReceive);
              } else
                controller.addProduct(product);
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
    ));
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
