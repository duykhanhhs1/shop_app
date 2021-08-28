import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';
import 'package:scrum_app/app/modules/detail_product/controllers/detail_product_controller.dart';
import 'package:scrum_app/app/modules/detail_product/widgets/review_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
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
      init: DetailProductController.to,
      builder: (DetailProductController controller) {
        ProductDetailModel product = controller.productDetail.value;
        return controller.isLoadingProduct.value
            ? Scaffold(body: Center(child: CupertinoActivityIndicator()))
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
                    _buildBottomAddCart(product);
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildDetailInfo(product),
                      ),
                      Divider(height: 30, thickness: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: _buildReviews(product),
                      ),
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
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            return ReviewCard(
              productReview: controller.reviews[index],
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
          'Mô tả sản phẩm: ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Divider(),
        Text(product.description),
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
        Text(
          'Số lượng hiện tại trong kho: ${product.count}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }

  Widget _buildShopInfo(ProductDetailModel product) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    product.shop_link_image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 5),
                Text(product.name_shop),
                /*  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(product.name_shop),
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
                )*/
              ],
            ),
            Text(
              "Chi tiết shop",
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
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
                    ? 'Miễn phí'
                    : '₫${NumberHelper.currencyFormat(product.shippingCost)}',
                style: TextStyle(
                  color: Colors.black87,
                )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.payments,
              color: Colors.black.withOpacity(.7),
            ),
            SizedBox(width: 5),
            Text('Đã bán: ${product.count_purchased}',
                style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                )),
          ],
        ),
      ],
    );
  }

  Widget _buildListImage(ProductDetailModel product) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.width,
          child: PageView(
            scrollDirection: Axis.horizontal,
            children: List.generate(
              product.imageUrls.length,
              (index) => Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: '${product.imageUrls[index]}',
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.contain,
                    errorWidget: (context, url, error) => ErrorImage(
                      size: 100,
                    ),
                  ),
                  Positioned(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 10),
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
        ),
        _buildDiscount(product),
      ],
    );
  }

  Widget _buildReviewRating() {
    ProductReviewModel review = controller.review.value;
    return Column(
      children: [
        FormRoundedInputField(
          contentPadding: const EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(10),
          maxLines: 3,
          hintText: 'Đánh giá của bạn',
          onChanged: (value) => review.comment = value,
          controller: controller.reviewTextController,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RatingBar.builder(
              initialRating: controller.rating.value,
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
                review.rating = rating;
                controller.update();
              },
            ),
            RoundedButton(
              color: review.rating > 0 ? kPrimaryColor : kPrimaryGreyColor,
              textContent: 'Gửi',
              width: 100,
              radius: 10,
              height: 35,
              onPressed: () {
                if (review.rating > 0) controller.onSubmitReview();
              },
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

  Future<dynamic> _buildBottomAddCart(ProductDetailModel product) {
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
                    children: <Widget>[
                      CachedNetworkImage(
                        imageUrl: controller.productDetail.value.imageUrls[0],
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            ErrorImage(size: 20),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 80,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.productDetail.value.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
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
                                      'Kho: ${NumberHelper.currencyFormat(controller.productDetail.value.count)}',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(.6),
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
              product.count > 0 &&
                      controller.productDetail.value.quantity <= product.count
                  ? GetBuilder(
                      init: Get.find<CartController>(),
                      builder: (CartController cartController) {
                        return RoundedButton(
                          width: Get.width,
                          onPressed: () async {
                            if (LoginController.to.isLogged) {
                              await cartController.addProduct(
                                  controller.productDetail.value.id,
                                  controller.productDetail.value.quantity);
                              Get.back();
                            } else {
                              Get.toNamed(Routes.LOGIN);
                            }
                          },
                          textContent: cartController.isLoadingCart.value
                              ? "Đang xử lý..."
                              : 'Thêm vào giỏ hàng',
                        );
                      },
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 50,
                        width: Get.width,
                        child: Center(
                          child: Text(
                            'Hết hàng',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                        color: Colors.deepOrange,
                      ),
                    )
            ],
          ),
        );
      },
    ));
  }

  Widget _buildDiscount(ProductDetailModel product) {
    return product.discount != null && product.discount > 0
        ? Positioned(
            top: 0,
            right: 0,
            child: Stack(
              children: [
                Icon(
                  CupertinoIcons.bookmark_fill,
                  size: 60,
                  color: Colors.yellow.shade600,
                ),
                Positioned(
                    top: 18,
                    left: 18,
                    child: Text(
                      "${((product.discount / product.price) * 100).round()}%",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ))
              ],
            ))
        : SizedBox();
  }

  Widget _buildRating(ProductDetailModel product) {
    return product.rating != null && product.rating.round() > 0
        ? Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColor.withOpacity(.4),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    '${product.rating.round()}',
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
            ),
          )
        : SizedBox();
  }
}
