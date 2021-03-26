import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/cart_icon_widget.dart';
import 'package:scrum_app/app/theme/color_theme.dart';

class DetailProductView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Iphone 12 Pro Max 256 GB'),
            centerTitle: true,
            actions: <Widget>[
              Center(child: CartIcon()),
              SizedBox(
                width: 20,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Image.network(
                              'https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/QuanLNH2/iphone-12-pro-1.jpg',
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('3000\$',
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold)),
                                Text('Inventory: 277',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.6),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                            child: Icon(Icons.clear),
                            onTap: () {
                              Get.back();
                            })
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Quantity'),
                        Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.remove,
                                size: 13,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              height: 30,
                              width: 43,
                              child: TextFormField(
                                onChanged: (value){},
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 5),
                                    enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey)),
                              width: 30,
                              height: 30,
                              child: Icon(
                                Icons.add,
                                size: 13,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Divider()
                  ],
                ),
              ));
            },
            backgroundColor: kPrimaryColor,
            child: Icon(
              Icons.add_shopping_cart_rounded,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      height: Get.width,
                      child: Image.network(
                        'https://fptshop.com.vn/Uploads/images/2015/Tin-Tuc/QuanLNH2/iphone-12-pro-1.jpg',
                      ),
                    ),
                    Positioned(
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: kPrimaryColor.withOpacity(.8)),
                          child: Text(
                            '3/5',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                      bottom: 10,
                      right: 10,
                    )
                  ],
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                _buildRating(),
                                SizedBox(width: 5),
                                Text(
                                  'Iphone 12 Pro Max 256 GB',
                                  style: TextStyle(fontSize: 18),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          _buildDiscount()
                        ],
                      ),
                      SizedBox(height: 10),
                      Text('3000\$',
                          style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      Text('3000\$',
                          style: TextStyle(
                              color: Colors.black.withOpacity(.6),
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough)),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container _buildDiscount() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.yellow),
      child: Text(
        '- 69%',
        style: TextStyle(
            color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container _buildRating() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor.withOpacity(.4),
      ),
      child: Row(
        children: <Widget>[
          Text(
            '4.8',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(.6)),
          ),
          Icon(
            Icons.star_rounded,
            color: Colors.yellow.shade700,
          )
        ],
      ),
    );
  }
}
