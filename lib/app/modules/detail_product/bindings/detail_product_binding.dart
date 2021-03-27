import 'package:get/get.dart';
import 'package:scrum_app/app/data/providers/product_provider.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductController>(
      () => DetailProductController(
          repository: ProductRepository(apiClient: ProductProvider())),
    );
  }
}
