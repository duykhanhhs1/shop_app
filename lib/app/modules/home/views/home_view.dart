import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/cart_icon_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/category_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/special_card_widget.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/text_theme.dart';
import 'package:scrum_app/app/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

enum FilterOptions {
  Favorites,
  All,
}

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
                  keyboardType: TextInputType.text,
                  borderRadius: BorderRadius.circular(10),
                  prefixIcon: Icons.search_rounded,
                  hintText: 'Tìm kiếm sản phẩm',
                  maxLines: 1,
                ),
              ),
            ),
            actions: <Widget>[
              CartIcon(),
              PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {},
                icon: Icon(
                  Icons.filter_alt_outlined,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  )
                ],
              ),
            ],
          ),
          bottomNavigationBar: AppBottomNavigationBar(),
          body: GetBuilder(builder: (HomeController controller) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('Danh mục', style: textTitle)),
                    _buildCategoryGridView(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('Dành cho bạn', style: textTitle)),
                    _buildSpecialListView(),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('Sản phẩm nổi bật', style: textTitle)),
                    _buildPopularGridView(controller),
                    SizedBox(
                      height: 15,
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildCategoryGridView() {
    return SizedBox(
      height: Get.height * 0.33,
      child: GridView.builder(
        itemCount: 10,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            childAspectRatio: 1 / 1),
        itemBuilder: (context, index) {
          return CategoryCard();
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
            height: Get.height * 0.16,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Row(
                  children: [SpecialCard(), SizedBox(width: 10)],
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
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 7,
            mainAxisSpacing: 7,
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.29),
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            onTap: () {
              Get.toNamed(Routes.DETAIL_PRODUCT,arguments:controller.products[index].productNo);
            },
            product: controller.products[index],
          );
        });
  }
}
