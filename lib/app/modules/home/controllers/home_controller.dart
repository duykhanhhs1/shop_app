import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/category_model.dart';
import 'package:scrum_app/app/data/models/product_model.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class HomeController extends GetxController {
  final ProductRepository repository;

  HomeController({@required this.repository}) : assert(repository != null);

  static HomeController get to => Get.find<HomeController>();

  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isLoadingCategories = false.obs;
  RxBool isLoadingDiscountProduct = false.obs;

  RxInt currentIndexBottomBar = RxInt(0);
  RxList<ProductOverViewModel> products = RxList<ProductOverViewModel>();
  RxList<ProductOverViewModel> productsDiscount =
      RxList<ProductOverViewModel>();
  RxList<ProductOverViewModel> searchedProducts =
      RxList<ProductOverViewModel>();
  RxList<ProductOverViewModel> productsByCate = RxList<ProductOverViewModel>();

  List<ProductOverViewModel> get favoriteProducts =>
      products.where((_) => _.isFavorite).toList();

  //
  RxList<CategoryModel> categories = RxList([]);
  CategoryModel currentCategory = CategoryModel();
  int pageIndex = 0;

  @override
  void onInit() async {
    getProducts(pageIndex);
    getCategories();
    getProductsDiscount();
    super.onInit();
  }

  void onCategoryTap(CategoryModel categoryModel) async {
    currentCategory = categoryModel;
    Get.toNamed(Routes.PRODUCT_CATEGORY);
    getProductsByCate(0, currentCategory.id);
    update();
  }

  Future<void> getProducts(int pageIndex) async {
    isLoading.value = true;
    try {
      final List<ProductOverViewModel> data =
          await repository.getProducts(pageIndex);
      products = data.obs;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
    update();
  }

  Future<void> getProductsDiscount() async {
    isLoadingDiscountProduct.value = true;
    try {
      final List<ProductOverViewModel> data =
          await repository.getProductsDiscount();
      productsDiscount = data.obs;
      isLoadingDiscountProduct.value = false;
    } catch (e) {
      isLoadingDiscountProduct.value = false;
    }
    update();
  }

  Future<void> searchProducts(String searchKey) async {
    isSearching.value = true;
    try {
      final List<ProductOverViewModel> data =
          await repository.searchProducts(searchKey);
      searchedProducts = data.obs;
      isSearching.value = false;
    } catch (e) {
      isSearching.value = false;
    }
  }

  Future<void> getProductsByCate(int pageIndex, int categoryId) async {
    isLoading.value = true;
    final List<ProductOverViewModel> data =
        await repository.getProductsByCate(pageIndex, categoryId);
    productsByCate = data.obs;
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
