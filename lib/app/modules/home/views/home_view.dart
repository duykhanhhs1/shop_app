import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:scrum_app/app/modules/home/widgets/product_card_widget.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/widgets/rounded_input_field.widget.dart';

import '../controllers/home_controller.dart';

enum FilterOptions {
  Favorites,
  All,
}

class HomeView extends GetView<HomeController> {
  static List<Widget> _widgetOptions = <Widget>[
    ViewProducts(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            title: Center(
              child: SizedBox(
                height: 40,
                child: FormRoundedInputField(
                  borderRadius: BorderRadius.circular(5),
                  prefixIcon: Icons.search_rounded,
                  hintText: 'Search your item',
                  maxLines: 1,
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.CART);
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  )),
              PopupMenuButton(
                onSelected: (FilterOptions selectedValue) {},
                icon: Icon(
                  Icons.filter_alt_outlined,
                ),
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text('Only Favorites'),
                    value: FilterOptions.Favorites,
                  ),
                  PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  )
                ],
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_rounded), label: 'Profile'),
              ],
              currentIndex: controller.currentIndexBottomBar.value,
              onTap: (index) {
                controller.setItemTapped(index);
              }),
          body: _widgetOptions.elementAt(controller.currentIndexBottomBar.value)
        );
      },
    );
  }
}

class ViewProducts extends StatelessWidget {
  const ViewProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
          child: GridView.builder(
              itemCount: controller.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.2),
              itemBuilder: (BuildContext context, int index) {
                return ProductCard(
                  product: controller.products[index],
                );
              }),
        );
      }
    );
  }
}


class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (HomeController controller) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/logo.png"),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color(0xFFF5F6F9),
                        onPressed: () {},
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }
    );
  }
}

