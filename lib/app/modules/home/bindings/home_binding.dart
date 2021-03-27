import 'package:get/get.dart';
import 'package:scrum_app/app/data/providers/product_provider.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/modules/cart/controllers/cart_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        repository: ProductRepository(
          apiClient: ProductProvider()
        )
      ),
    );
    Get.put<CartController>(
        CartController(
            repository: ProductRepository(apiClient: ProductProvider())),
        permanent: true
    );
  }
}
