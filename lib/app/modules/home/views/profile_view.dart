  import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/routes/app_pages.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(builder: (HomeController controller) {
      return Scaffold(
        body:Text('zxc'),
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
      );
    });
  }
}
