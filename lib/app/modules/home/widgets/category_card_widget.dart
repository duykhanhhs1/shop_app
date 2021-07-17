import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/data/models/category_model.dart';
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
        decoration: BoxDecoration(border: Border.all(color: kLightBackground)),
        padding: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: Get.height * 0.07,
              height: Get.height * 0.07,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(category.link_image),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey,
                  shape: BoxShape.circle),
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
