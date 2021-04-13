import 'package:get/get.dart';
import 'package:scrum_app/app/modules/admin/bindings/admin_binding.dart';
import 'package:scrum_app/app/modules/admin/views/customer_management_view.dart';
import 'package:scrum_app/app/modules/admin/views/product_management_view.dart';
import 'package:scrum_app/app/modules/cart/bindings/cart_binding.dart';
import 'package:scrum_app/app/modules/cart/views/cart_view.dart';
import 'package:scrum_app/app/modules/cart/views/payment_view.dart';
import 'package:scrum_app/app/modules/detail_product/bindings/detail_product_binding.dart';
import 'package:scrum_app/app/modules/detail_product/views/detail_product_view.dart';
import 'package:scrum_app/app/modules/home/bindings/home_binding.dart';
import 'package:scrum_app/app/modules/home/views/home_view.dart';
import 'package:scrum_app/app/modules/login/bindings/login_binding.dart';
import 'package:scrum_app/app/modules/login/views/login_view.dart';
import 'package:scrum_app/app/modules/login/views/register_view.dart';
import 'package:scrum_app/app/modules/login/views/splash_view.dart';
import 'package:scrum_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:scrum_app/app/modules/profile/views/order_management_view.dart';
import 'package:scrum_app/app/modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: LoginBinding(),
    ),

    //
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT,
      page: () => DetailProductView(),
      binding: DetailProductBinding(),
    ),

    //
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_MANAGEMENT,
      page: () => OrderManagementView(),
      binding: ProfileBinding(),
    ),

    //
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => PaymentView(),
      binding: CartBinding(),
    ),

    //
    GetPage(
      name: _Paths.ADMIN,
      page: () => CustomerManagementView(),
      binding: AdminBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_MANAGEMENT,
      page: () => ProductManagementView(),
      binding: AdminBinding(),
    ),
  ];
}
