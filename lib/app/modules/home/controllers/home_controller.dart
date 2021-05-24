import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/category_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';

class HomeController extends GetxController {
  final ProductRepository repository;

  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  RxBool isLoading = false.obs;
  RxBool isLoadingCategories = false.obs;

  RxInt currentIndexBottomBar = RxInt(0);
  RxList<ProductOverViewModel> products = RxList<ProductOverViewModel>();

  List<ProductOverViewModel> get favoriteProducts =>
      products.where((_) => _.isFavorite).toList();

  //
  RxList<CategoryModel> categories = RxList([]);
  int pageIndex = 0;

  @override
  void onInit() async {
    getProducts(pageIndex);
    getCategories();
    super.onInit();
  }

  Future<void> getProducts(int pageIndex) async {
    isLoading.value = true;
    final List<ProductOverViewModel> data =
        await repository.getProducts(pageIndex);
    products = data.obs;
    isLoading.value = false;
    update();
  }

  Future<void> getCategories() async {
    isLoadingCategories.value = true;
    final List<CategoryModel> data = await repository.getCategories();
    categories = data.obs;
    isLoadingCategories.value = false;
    update();
  }

  Future<void> setProductFavorite(ProductOverViewModel product) async {
    product.isFavorite = !product.isFavorite;
    if (product.isFavorite) {
      FavoriteModel favorite = FavoriteModel(
          productNo: product.id,
          userNo: LoginController.to.userLogged.value.userNo);
      await repository.addFavoriteProduct(favorite);
    } else {
      FavoriteModel favorite = await repository.getFavorite(
          LoginController.to.userLogged.value.userNo, product.id);
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
