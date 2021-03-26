import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:scrum_app/app/modules/home/controllers/home_controller.dart';
import 'package:scrum_app/app/modules/home/widgets/cart_icon_widget.dart';
import 'package:scrum_app/app/theme/color_theme.dart';
import 'package:scrum_app/app/widgets/rounded_button.widget.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

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
              _buildBottomAddCart();
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
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.local_shipping_outlined,
                            color: Colors.black.withOpacity(.7),
                          ),
                          SizedBox(width: 5),
                          Text('Shipping cost:',
                              style: TextStyle(
                                color: Colors.black.withOpacity(.7),
                              )),
                          Text(' 1.25\$ - 1.75\$',
                              style: TextStyle(
                                color: Colors.black87,
                              )),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJK5ssLOJ_fu9WoRvjZ6e6tQ9LXARku0GfKg&usqp=CAU',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('thegioididong'),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.location_on_outlined,
                                      size: 15,
                                      color: Colors.black.withOpacity(.7)),
                                  Text(
                                    'Đà Nẵng',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Chi tiết sản phẩm: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          _buildLineDetail(title: 'Kho', content: '23232'),
                          SizedBox(height: 10),
                          _buildLineDetail(
                              title: 'Dòng máy',
                              content: 'Apple Iphone 12 Pro Max'),
                          SizedBox(height: 10),
                          _buildLineDetail(
                              title: 'Chất liệu', content: 'Kim Loại'),
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('ĐÁNH GIÁ SẢN PHẨM',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 10),
                         // _buildReviewRating(),
                         // Divider(thickness: 1.5),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'duykhanhhs1',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(.7)),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.yellow.shade700,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.yellow.shade700,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 16,
                                        color: Colors.yellow.shade700,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),

                                  Text(
                                    'Cáp sạc nhanh USB-C to Lightning bắt buộc phải kết hợp với củ sạc đầu USB-C đ sử dụng , kết hợp với củ sạc PD mới đạt được hiệu quả sạc nhanh . Đồng thời có thể kết nối với đầu Thunderbolt3 của Macbook để sạc pin hoặc truyền dữ liệu (lưu ý sạc bằng cách này chỉ là sạc thường , không phải sạc nhanh ) ',
                                    textAlign: TextAlign.justify,
                                    maxLines: 6,
                                  ),

                                  SizedBox(height: 5),
                                  Image.network(
                                    'https://didongviet.vn/blog/wp-content/uploads/2020/11/Tre%CC%82n-tay-iPhone-12-Pro-Max-Tra%CC%89i-nghie%CC%A3%CC%82m-nhanh-nhu%CC%9B%CC%83ng-ti%CC%81nh-na%CC%86ng-mo%CC%9B%CC%81i-cu%CC%89a-ma%CC%81y-thumb.jpg',
                                    width: 80,
                                    height: 80,fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 100),
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

  Widget _buildReviewRating() {
    return Column(
      children: [
        FormRoundedInputField(
          borderRadius: BorderRadius.circular(10),
          maxLines: 3,
          hintText: 'Đánh giá của bạn',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 15,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            RoundedButton(
              textContent: 'Gửi',
              width: 100,
              radius: 10,
              height: 35,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLineDetail({String title, String content}) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(title,
                style: TextStyle(color: Colors.black.withOpacity(.7))),
            flex: 3),
        Expanded(child: Text(content), flex: 5)
      ],
    );
  }

  Future<dynamic> _buildBottomAddCart() {
    return Get.bottomSheet(Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: [
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
                          onChanged: (value) {},
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
              Divider(),
            ],
          ),
          RoundedButton(
            width: Get.width,
            onPressed: () {},
            textContent: 'Add to cart',
          )
        ],
      ),
    ));
  }

  Widget _buildDiscount() {
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

  Widget _buildRating() {
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
