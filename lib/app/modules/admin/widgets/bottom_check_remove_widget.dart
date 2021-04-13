import 'package:flutter/material.dart';

class BottomCheckRemove extends StatelessWidget {
  const BottomCheckRemove({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.grey.shade100,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.black.withOpacity(.6),
                  )),
              SizedBox(width: 5),
              Text('Tất cả')
            ],
          ),
          Text(
            'Xóa',
            style: TextStyle(color: Colors.deepOrange),
          )
        ],
      ),
    );
  }
}