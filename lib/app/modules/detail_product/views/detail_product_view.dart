import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/order_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/detail_product/controllers/detail_product_controller.dart';
import 'package:scrum_app/app/modules/detail_product/widgets/review_card_widget.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/utils/helpers.dart';
import 'package:scrum_app/app/widgets/number_input_field_widget.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

import '../../../widgets/cart_icon_widget.dart';

class DetailProductView extends GetView<DetailProductController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (DetailProductController controller) {
        ProductDetailModel product = controller.productDetail.value;
        return controller.isLoadingProduct.value
            ? Scaffold(body: Center(child: CircularProgressIndicator()))
            : Scaffold(
                appBar: AppBar(
                  title: Text(product.name),
                  centerTitle: true,
                  actions: <Widget>[
                    Center(child: CartIcon()),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    _buildBottomAddCart();
                  },
                  backgroundColor: kPrimaryColor,
                  child: Icon(
                    Icons.add_shopping_cart_rounded,
                    color: Colors.white,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildListImage(product),
                      Divider(height: 4, thickness: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildOverviewInfo(product),
                      ),
                      Divider(height: 30, thickness: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildShopInfo(product),
                      ),
                      Divider(height: 30, thickness: 4),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   child: _buildDetailInfo(product),
                      // ),
                      // Divider(height: 30, thickness: 5),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   child: _buildReviews(product),
                      // ),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
              );
      },
    );
  }

  Widget _buildReviews(ProductDetailModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('ĐÁNH GIÁ SẢN PHẨM',
            style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        _buildReviewRating(),
        Divider(height: 30),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: product.productReviews.length,
          itemBuilder: (context, index) {
            return ReviewCard(
              productReview: product.productReviews[index],
            );
          },
        ),
      ],
    );
  }

  Widget _buildDetailInfo(ProductDetailModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Chi tiết sản phẩm: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Divider(),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: product.productProperties.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SizedBox(height: 10),
                _buildLineDetail(
                    productProperty: product.productProperties[index])
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildShopInfo(ProductDetailModel product) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                product.shopImage,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(product.shopName),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on_outlined,
                        size: 15, color: Colors.black.withOpacity(.7)),
                    Text(
                      product.shopLocation == null
                          ? 'Vinh'
                          : product.shopLocation,
                      style: TextStyle(color: Colors.black.withOpacity(.7)),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewInfo(ProductDetailModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: <Widget>[
                  _buildRating(product),
                  SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      product.name,
                      style: TextStyle(fontSize: 18),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            //_buildDiscount(product)
          ],
        ),
        SizedBox(height: 10),
        Text('₫${NumberHelper.currencyFormat(product.price)}',
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        if (product.oldPrice != null)
          Text('${NumberHelper.currencyFormat(product.oldPrice)}\$',
              style: TextStyle(
                  color: Colors.black.withOpacity(.6),
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough)),
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Icon(
              Icons.local_shipping_outlined,
              color: Colors.black.withOpacity(.7),
            ),
            SizedBox(width: 5),
            Text('Phí vận chuyển: ',
                style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                )),
            Text(
                product.shippingCost == null
                    ? '₫0'
                    : '₫${NumberHelper.currencyFormat(product.shippingCost)}',
                style: TextStyle(
                  color: Colors.black87,
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildListImage(ProductDetailModel product) {
    return Container(
      width: Get.width,
      height: Get.width,
      child: PageView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          product.imageUrls.length,
          (index) => Stack(
            children: [
              Image.network(
                '${product.imageUrls[index]}',
                width: Get.width,
                height: Get.height,
                fit: BoxFit.contain,
              ),
              Positioned(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: kPrimaryColor.withOpacity(.8)),
                    child: Text(
                      '${index + 1}/${product.imageUrls.length}',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )),
                bottom: 10,
                right: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewRating() {
    return Column(
      children: [
        FormRoundedInputField(
          borderRadius: BorderRadius.circular(10),
          maxLines: 3,
          hintText: 'Đánh giá của bạn',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 15,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            RoundedButton(
              textContent: 'Gửi',
              width: 100,
              radius: 10,
              height: 35,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLineDetail({ProductPropertyModel productProperty}) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(productProperty.property,
                style: TextStyle(color: Colors.black.withOpacity(.7))),
            flex: 3),
        Expanded(child: Text(productProperty.content), flex: 5)
      ],
    );
  }

  Future<dynamic> _buildBottomAddCart() {
    controller.quantityController.text = '1';
    controller.productDetail.value.quantity = 1;
    return Get.bottomSheet(GetBuilder<DetailProductController>(
      init: Get.find(),
      builder: (controller) {
        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Image.network(
                            controller.productDetail.value.imageUrls[0],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                  '${NumberHelper.currencyFormat(controller.getPrice())} VNĐ',
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                  'Kho: ${NumberHelper.currencyFormat(controller.productDetail.value.amount)}',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(.6),
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      GestureDetector(
                          child: Icon(Icons.clear),
                          onTap: () {
                            Get.back();
                          })
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Số lượng'),
                      NumberInputIncDec(
                        setValue: () {
                          controller.productDetail.value.quantity =
                              int.tryParse(controller.quantityController.text);
                          controller.update();
                        },
                        textController: controller.quantityController,
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
              GetBuilder(
                init: Get.find<CartController>(),
                builder: (CartController cartController) {
                  return RoundedButton(
                    width: Get.width,
                    onPressed: () {
                      cartController.addOrder(OrderModel(
                          status: 'pending',
                          userNo: LoginController.to.userLogged.value.userNo,
                          productNo: controller.productDetail.value.productNo,
                          quantity: int.tryParse(
                              controller.quantityController.text)));
                      Get.back();
                    },
                    textContent: 'Thêm vào giỏ hàng',
                  );
                },
              )
            ],
          ),
        );
      },
    ));
  }

  Widget _buildDiscount(ProductDetailModel product) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
      child: Text(
        '- ${product.discount}%',
        style: TextStyle(
            color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRating(ProductDetailModel product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor.withOpacity(.4),
      ),
      child: Row(
        children: <Widget>[
          Text(
            product.rating == null ? '4.9' : '${product.rating}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(.6)),
          ),
          Icon(
            Icons.star_rounded,
            color: Colors.yellow.shade700,
          )
        ],
      ),
    );
  }
}
