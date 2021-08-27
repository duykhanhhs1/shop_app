import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/category_model.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.category,
    this.onTap,
  }) : super(key: key);

  final CategoryModel category;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kLightBackground),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: Offset(5, 5))
            ]),
        padding: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: Get.height * 0.07,
              height: Get.height * 0.07,
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              child: CachedNetworkImage(
                imageUrl: category.link_image,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: ErrorImage(size: 20)),
                ),
              ),
            ),
            SizedBox(
                height: Get.height * 0.04,
                child: Text(
                  category.name.toString(),
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
