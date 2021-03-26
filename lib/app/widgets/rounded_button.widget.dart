import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.width,
    this.height,
    this.color,
    this.textColor,
    this.textContent,
    this.onPressed,
  }) : super(key: key);

  final double width;
  final double height;
  final Color color;
  final Color textColor;
  final String textContent;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: 45,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(textContent,style: TextStyle(fontWeight: FontWeight.bold),),
        color: color,
        textColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
