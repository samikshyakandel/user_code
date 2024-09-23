import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../../../Utils/Routes/app_routes.dart';
import '../../../Utils/local_storage.dart';

class AuthController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  final loginFormGlobalKey = GlobalKey<FormState>();
  var emailCont = TextEditingController();
  var passwordCont = TextEditingController();

  RxBool isLoading = false.obs;

  void loginApi() async {
    isLoading.value = true;
    var loginData = await ApiServices().logInService(
      email: emailCont.text,
      password: passwordCont.text,
      // fcmToken: fcmToken
    );
    isLoading.value = false;
    if (loginData.status == 1) {
      await LocalStorage().currentUserSet(loginData);
      Get.offAllNamed(AppRoutes.mainBottomView);
      currentUserController.currentUserDetailsGet();
      emailCont.clear();
      passwordCont.clear();
    }
  }

  //signUp
  final signUpFormGlobalKey = GlobalKey<FormState>();
  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var password = TextEditingController();

  void signUpApi() async {
    isLoading.value = true;
    var signUpData = await ApiServices().signUpService(
        email: email.text,
        varMobileNo: phone.text,
        varName: name.text,
        varPassword: password.text);
    isLoading.value = false;
    if (signUpData.status == 1) {
      await LocalStorage().currentUserSet(signUpData);
      Get.offAllNamed(AppRoutes.mainBottomView);
      currentUserController.currentUserDetailsGet();
      name.clear();
      email.clear();
      phone.clear();
      password.clear();
    }
  }
}
