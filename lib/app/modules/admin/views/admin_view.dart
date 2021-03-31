import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrum_app/app/modules/profile/views/profile_view.dart';

import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdminView'),
        centerTitle: true,
      ),
      body: Center(child: Text('zxc'),)
    );
  }
}
