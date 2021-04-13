import 'package:get/get.dart';
import 'package:scrum_app/app/data/providers/product_provider.dart';
import 'package:scrum_app/app/data/providers/user_provider.dart';
import 'package:scrum_app/app/data/repositories/product_repository.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';

import '../controllers/admin_controller.dart';

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(
      () => AdminController(userRepository: UserRepository(apiClient: UserProvider()),
          productRepository: ProductRepository(apiClient: ProductProvider())),
    );
  }
}
