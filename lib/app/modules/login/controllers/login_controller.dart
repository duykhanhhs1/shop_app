import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:scrum_app/app/data/models/user_model.dart';
import 'package:scrum_app/app/data/repositories/user_repository.dart';
import 'package:scrum_app/app/modules/login/bindings/login_binding.dart';
import 'package:scrum_app/app/routes/app_pages.dart';
import 'package:scrum_app/app/utils/keys.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final UserRepository repository;

  LoginController({@required this.repository}) : assert(repository != null);

  static LoginController get to => Get.find<LoginController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  RxBool isProcessing = RxBool(false);
  Rx<UserModel> userLogged = Rx(UserModel());

  final GetStorage _store = GetStorage();

  @override
  void onInit() async {
    await verifyUser();
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> verifyUser() async {
    final String storedToken = await _store.read(AppStorageKey.ACCESS_TOKEN);
    if (storedToken != null) {
      setUserLogged(FirebaseAuth.instance.currentUser.uid);
    } else
      Get.offAllNamed(Routes.LOGIN);
  }

  Future<void> logout() async {
    _store.remove(AppStorageKey.ACCESS_TOKEN);
    emailController.clear();
    passwordController.clear();
    FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
    isProcessing.value = false;
  }

  //signIn
  Future<void> login({String email, String password}) async {
    isProcessing.value = true;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await FirebaseAuth.instance.currentUser.getIdToken(true).then((token) {
        _store.write(AppStorageKey.ACCESS_TOKEN, token);
      });
      setUserLogged(value.user.uid);
    }).catchError((onError) {
      Get.snackbar('Error', 'User not found',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
    });
  }

  void setUserLogged(String uid) async {
    await getUserLogged(uid);
    if (userLogged.value.role == 'admin') {
      Get.offAllNamed(Routes.ADMIN);
    } else {
      Get.offAllNamed(Routes.HOME);
    }
  }

  Future<void> getUserLogged(String userNo) async {
    UserModel data = await repository.getUserLogged(userNo);
    userLogged = data.obs;
    update();
  }

  void register({String email, String password, UserModel user}) async{
    isProcessing.value = true;
    await repository.register(email:email,password:password,user:user);
    isProcessing.value = false;
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar('Success', 'Register success',
        snackPosition: SnackPosition.BOTTOM, colorText: Colors.green);
  }
}
