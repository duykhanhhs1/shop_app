import 'package:get/get.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController

  final count = 0.obs;

  RxBool isEditProfile = RxBool(false);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void setOpenEditForm(bool value){
    isEditProfile.value = value;
    update();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
