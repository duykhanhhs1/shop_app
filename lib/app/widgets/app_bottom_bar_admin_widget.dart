import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/admin/controllers/admin_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class AppBottomNavigationBarAdmin extends StatefulWidget {
  final  int currentIndex;

  AppBottomNavigationBarAdmin(this.currentIndex);
  @override
  _AppBottomNavigationBarAdminState createState() => _AppBottomNavigationBarAdminState(this.currentIndex);
}

class _AppBottomNavigationBarAdminState extends State<AppBottomNavigationBarAdmin> {
   int currentIndex;
  _AppBottomNavigationBarAdminState(this.currentIndex);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.supervised_user_circle,
          ),
          label: 'User management',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.widgets,
          ),
          label: 'Product management',
        ),
      ],
      unselectedFontSize: 12,
      selectedFontSize: 12,
      currentIndex: currentIndex,
      backgroundColor: Colors.grey.shade100,
      onTap: (tabIndex) {
          if (tabIndex == 0) {
            Get.offAllNamed(Routes.ADMIN);
          } else if (tabIndex == 1) {

            Get.offAllNamed(Routes.PRODUCT_MANAGEMENT);
          }
      },
    );
  }
}
