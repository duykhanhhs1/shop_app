import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class HomeController extends GetxController {
  final ProductRepository repository;

  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  RxBool isLoading = false.obs;

  RxInt currentIndexBottomBar = RxInt(0);
  RxList<ProductOverViewModel> products = RxList<ProductOverViewModel>();

  List<ProductOverViewModel> get favoriteProducts =>
      products.where((_) => _.isFavorite).toList();

  @override
  void onInit() async {
    getAllProductOverview();
    super.onInit();
  }

  Future<void> getAllProductOverview() async {
    isLoading.value = true;
    final List<ProductOverViewModel> dataProducts =
        await repository.getAllProductOverview();
    final List<ProductOverViewModel> dataFavoriteProducts = await repository
        .getFavoriteProducts(LoginController.to.userLogged.value.userNo);
    products = dataProducts.obs;
    dataFavoriteProducts.forEach((_) {
      products.forEach((__) {
        if (_.productNo == __.productNo) __.isFavorite = true;
      });
    });
    isLoading.value = false;
    update();
  }

  Future<void> setProductFavorite(ProductOverViewModel product) async {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      FavoriteModel favorite = FavoriteModel(
          productNo: product.productNo,
          userNo: LoginController.to.userLogged.value.userNo);
      await repository.addFavoriteProduct(favorite);
    } else {
      FavoriteModel favorite = await repository.getFavorite(
          LoginController.to.userLogged.value.userNo, product.productNo);
      await repository.removeFavoriteProduct(favorite);
    }
    update();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
