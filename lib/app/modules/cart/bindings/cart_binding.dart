import 'package:get/get.dart';
import 'package:scrum_app/app/data/providers/product_provider.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

import '../controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(
        CartController(
            repository: ProductRepository(
          apiClient: ProductProvider(),
        )),
        permanent: true);
  }
}
