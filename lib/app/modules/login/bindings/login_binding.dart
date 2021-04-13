import 'package:get/get.dart';
import 'package:scrum_app/app/data/providers/user_provider.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(
        LoginController(repository: UserRepository(apiClient: UserProvider())),
        permanent: true);
  }
}
