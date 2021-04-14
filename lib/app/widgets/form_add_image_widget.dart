import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class FormAddImage extends StatelessWidget {
  const FormAddImage({
    Key key,
    this.onTapGallery,
    this.onTapCamera,
  }) : super(key: key);

  final Function onTapGallery;
  final Function onTapCamera;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CloseButton(
                onPressed: () {
                  Get.back();
                },
              ),
              Text(
                'Thêm ảnh',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(width: 55)
            ],
          ),
          Divider(height: 0),
          ListTile(
            onTap: onTapGallery,
            leading: Icon(
              Icons.perm_media_outlined,
              color: kPrimaryColor,
            ),
            title: Text('Chọn ảnh có sẵn'),
          ),
          Divider(height: 0),
          ListTile(
            onTap: onTapCamera,
            leading: Icon(
              Icons.photo_camera_outlined,
              color: kPrimaryColor,
            ),
            title: Text('Chụp ảnh'),
          ),
        ],
      ),
    );
  }
}
