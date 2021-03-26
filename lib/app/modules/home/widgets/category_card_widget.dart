import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: kPrimaryColor,
      margin: EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: Get.height*0.08,
              height: Get.height*0.08,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3SP8vjcR1sdReAlqVxe_HRxMIdw-rBZ5aw&usqp=CAU'),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey,
                  shape: BoxShape.circle),
            ),
            SizedBox(height: Get.height*0.05, child: Text('Electronic home',textAlign: TextAlign.center,))
          ],
        ),
      ),
    );
  }
}
