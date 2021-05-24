import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/login/controllers/login_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class AppBottomNavigationBarAdmin extends StatefulWidget {
  final int currentIndex;

  AppBottomNavigationBarAdmin(this.currentIndex);

  @override
  _AppBottomNavigationBarAdminState createState() =>
      _AppBottomNavigationBarAdminState(this.currentIndex);
}

class _AppBottomNavigationBarAdminState
    extends State<AppBottomNavigationBarAdmin> {
  int currentIndex;

  _AppBottomNavigationBarAdminState(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.supervised_user_circle,
          ),
          label: 'Người dùng',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.widgets,
          ),
          label: 'Sản phẩm',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.stacked_line_chart,
          ),
          label: 'Thông kê',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.logout,
          ),
          label: 'Đăng xuất',
        ),
      ],
      unselectedFontSize: 12,
      selectedFontSize: 12,
      unselectedItemColor: Colors.grey,
      unselectedLabelStyle: TextStyle(color: Colors.grey),
      selectedItemColor: kPrimaryColor,
      selectedLabelStyle: TextStyle(color: kPrimaryColor),
      showSelectedLabels: false,
      currentIndex: currentIndex,
      backgroundColor: Colors.grey.shade100,
      onTap: (tabIndex) {
        if (tabIndex == 0) {
          Get.toNamed(Routes.ADMIN);
        }
        if (tabIndex == 1) {
          Get.toNamed(Routes.PRODUCT_MANAGEMENT);
        }
        if (tabIndex == 2) {
          Get.toNamed(Routes.REVENUE_STATISTIC);
        }
        if (tabIndex == 3) {
          LoginController.to.logout();
        }
      },
    );
  }
}
