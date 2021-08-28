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
  TextEditingController reviewTextController = TextEditingController();
  RxDouble rating = RxDouble(0.0);
  RxInt quantity = RxInt(0);
  int productId = 0;

  @override
  void onInit() {
    productId = Get.arguments;
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

  void getProductDetailFB(int id, {bool reload = true}) async {
    if (reload) {
      isLoadingProduct.value = true;
    }
    final ProductDetailModel data = await repository.getProductDetailFB(id);
    productDetail = data.obs;
    productDetail.value.imageUrls =
        List.generate(4, (index) => productDetail.value.link_image);
    isLoadingProduct.value = false;
    update();
  }

  void onSubmitReview() async {
    review.value.reviewer_name = _loginController.userLogged.value.email;
    review.value.product_id = productDetail.value.id;
    await repository.addReview(review.value);
    getProductDetailFB(productId, reload: false);
    reviewTextController.clear();
    rating.value = 0;
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
