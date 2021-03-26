import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/modules/home/widgets/special_card_widget.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/text_theme.dart';

class ShowProductsView extends StatelessWidget {
  const ShowProductsView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Specials for you',
                  style: textTitle,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(
                      height: Get.height*0.16,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SpecialCard(),
                              SizedBox(width: 10)
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Popular products',
                  style: textTitle,
                ),
              ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 7,mainAxisSpacing: 7,
                      crossAxisCount: 2, childAspectRatio: 1 / 1.28),
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(
                      onTap: (){
                        Get.toNamed(Routes.DETAIL);
                      },
                      product: controller.products[index],
                    );
                  }),
              SizedBox(height: 15,)
            ],
          ),
        ),
      );
    });
  }
}