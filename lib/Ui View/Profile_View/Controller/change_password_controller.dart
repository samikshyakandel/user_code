import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../../../Utils/Routes/app_routes.dart';

class ChangePasswordController extends GetxController {
  final CurrentUserController currentUserController = Get.find();
  final changePasswordFormGlobalKey = GlobalKey<FormState>();

  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();
  var confirmPassword = TextEditingController();
  RxBool isLoading = false.obs;

  void updateProfileApi() async {
    isLoading.value = true;
    var profileData = await ApiServices().changePasswordService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        varCpassword: oldPassword.text,
        varNpassword: newPassword.text);
    isLoading.value = false;
    if (profileData.status == 1) {
      Get.offAllNamed(AppRoutes.mainBottomView);
    }
  }
}
