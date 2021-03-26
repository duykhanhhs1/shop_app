import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpecialCard extends StatelessWidget {
  const SpecialCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
                image: NetworkImage(
                    'https://vcdn-sohoa.vnecdn.net/2020/11/10/iPhone-3-2656-1605000003.jpg'),
                fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Smartphone',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '15 brands',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}