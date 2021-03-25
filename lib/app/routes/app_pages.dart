import 'package:get/get.dart';

import 'package:scrum_app/app/modules/admin/bindings/admin_binding.dart';
import 'package:scrum_app/app/modules/admin/views/admin_view.dart';
import 'package:scrum_app/app/modules/cart/bindings/cart_binding.dart';
import 'package:scrum_app/app/modules/cart/views/cart_view.dart';
import 'package:scrum_app/app/modules/home/bindings/home_binding.dart';
import 'package:scrum_app/app/modules/home/views/home_view.dart';
import 'package:scrum_app/app/modules/login/bindings/login_binding.dart';
import 'package:scrum_app/app/modules/login/views/login_view.dart';
import 'package:scrum_app/app/modules/register/bindings/register_binding.dart';
import 'package:scrum_app/app/modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN,
      page: () => AdminView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
  ];
}
