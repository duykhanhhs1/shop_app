import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class DetailProductController extends GetxController {
  //TODO: Implement DetailProductController
  final ProductRepository repository;

  DetailProductController({@required this.repository})
      : assert(repository != null);

  static DetailProductController get to => Get.find<DetailProductController>();

  final LoginController _loginController = LoginController.to;

  Rx<ProductDetailModel> productDetail =
      Rx<ProductDetailModel>(ProductDetailModel());
  RxBool isLoadingProduct = RxBool(false);
  RxBool isLoadingReviews = RxBool(false);
  RxBool isRated = RxBool(false);
  RxList<ProductReviewModel> reviews = RxList();
  Rx<ProductReviewModel> review = ProductReviewModel(rating: 0).obs;

  TextEditingController quantityController = TextEditingController();
  RxInt quantity = RxInt(0);

  @override
  void onInit() {
    final int productId = Get.arguments;
    getProductDetailFB(productId);
    getReviews(productId);
    super.onInit();
  }

  void getReviews(int productId) async {
    isLoadingReviews.value = true;
    final List<ProductReviewModel> data =
        await repository.getReviews(productId);
    reviews = data.obs;
    isLoadingReviews.value = false;
    update();
  }

  void getProductDetailFB(int id) async {
    isLoadingProduct.value = true;
    final ProductDetailModel data = await repository.getProductDetailFB(id);
    productDetail = data.obs;
    productDetail.value.imageUrls =
        List.generate(4, (index) => productDetail.value.link_image);
    isLoadingProduct.value = false;
    update();
  }

  void onSubmitReview(ProductReviewModel review) async {
    review.reviewer = _loginController.userLogged.value.email;
    review.product_id = productDetail.value.id;
    await repository.addReview(review);
    getReviews(productDetail.value.id);
    update();
  }

  int getPrice() {
    return productDetail.value.price * productDetail.value.quantity;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
