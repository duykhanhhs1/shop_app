import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_rounded,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Profile',
        ),
      ],
      unselectedFontSize: 12,
      selectedFontSize: 12,
      currentIndex: currentIndex,
      backgroundColor: Colors.white,
      onTap: (tabIndex) {
        setState(() {
          currentIndex = tabIndex;
          if (tabIndex == 0) {
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.toNamed(Routes.PROFILE);
            currentIndex = 0;
          }
        });
      },
    );
  }
}
