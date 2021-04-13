import 'package:flutter/material.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          width: 200.0,
        ),
      ),
    );
  }
}
