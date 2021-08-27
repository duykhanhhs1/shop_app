import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/views/search_product_view.dart';
import 'package:scrum_app/app/modules/home/widgets/category_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/special_card_widget.dart';
import 'package:scrum_app/app/theme/text_theme.dart';
import 'package:scrum_app/app/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:scrum_app/app/widgets/cart_icon_widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: SizedBox(
                height: 40,
                child: FormRoundedInputField(
                  onTap: () {
                    controller.searchedProducts = controller.products;
                    Get.to(() => SearchProductView());
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  borderRadius: BorderRadius.circular(10),
                  prefixIcon: Icons.search_rounded,
                  hintText: 'Tìm kiếm sản phẩm',
                  maxLines: 1,
                ),
              ),
            ),
            actions: <Widget>[
              Center(child: CartIcon()),
              SizedBox(width: 12),
            ],
          ),
          bottomNavigationBar: AppBottomNavigationBar(),
          body: GetBuilder(
            builder: (HomeController controller) {
              return RefreshIndicator(
                displacement: 0,
                onRefresh: () async {
                  controller.getProducts(0);
                  controller.getCategories();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /*                     Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text('Ưu đãi giá sốc', style: textTitle)),
                      _buildSpecialListView(),*/
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Danh mục', style: textTitle)),
                      _buildCategoryGridView(),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Gợi ý hôm nay', style: textTitle)),
                      controller.isLoading.value
                          ? Center(child: CupertinoActivityIndicator())
                          : _buildPopularGridView(controller),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCategoryGridView() {
    return controller.isLoadingCategories.value
        ? Center(
            child: CupertinoActivityIndicator(),
          )
        : Container(
            padding: EdgeInsets.only(left: 10),
            height: Get.height * 0.27,
            child: GridView.builder(
              itemCount: controller.categories.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.2 / 1),
              itemBuilder: (context, index) {
                return CategoryCard(
                  category: controller.categories[index],
                  onTap: () {
                    controller.onCategoryTap(controller.categories[index]);
                  },
                );
              },
            ),
          );
  }

  Widget _buildSpecialListView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            height: Get.height * 0.3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: controller.productsDiscount.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                      width: Get.width * 0.5,
                      child: ProductCard(
                          product: controller.productsDiscount[index])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularGridView(HomeController controller) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.23),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: controller.products[index],
          );
        });
  }
}
