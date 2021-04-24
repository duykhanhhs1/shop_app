import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key key,
      this.iconData,
      this.color,
      this.title,
      this.secondText = '',
      this.onTap})
      : super(key: key);
  final IconData iconData;
  final Color color;
  final String title;
  final String secondText;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              horizontalTitleGap: 0,
              leading: Icon(
                iconData,
                color: color,
              ),
              title: Text(title),
            ),
          ),
          Row(
            children: [
              Text(secondText),
              Icon(
                Icons.keyboard_arrow_right,
                color: Colors.black.withOpacity(.6),
              ),
              SizedBox(width: 12)
            ],
          )
        ],
      ),
    );
  }
}
