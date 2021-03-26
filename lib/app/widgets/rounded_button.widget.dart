import 'package:flutter/material.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.width,
    this.height = 45,
    this.color = kPrimaryColor,
    this.textColor,
    this.textContent,
    this.onPressed,
    this.radius = 50,
  });

  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final String textContent;
  final Function onPressed;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          textContent,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
