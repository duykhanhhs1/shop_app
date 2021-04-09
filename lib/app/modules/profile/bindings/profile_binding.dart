import 'package:get/get.dart';
import 'package:scrum_app/app/data/providers/user_provider.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(
          repository: UserRepository(apiClient: UserProvider())),
    );
  }
}
