import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../../../Utils/Routes/app_routes.dart';
import '../../../Utils/local_storage.dart';

class ProfileController extends GetxController {
  final CurrentUserController currentUserController = Get.find();
  final profileFormGlobalKey = GlobalKey<FormState>();

  var name = TextEditingController();
  var email = TextEditingController();
  var phone = TextEditingController();
  var dob = TextEditingController();
  var vartypeCont = "Male";
  RxBool isLoading = false.obs;

  void updateProfileApi() async {
    // if (vartypeCont == "Male") {
    // } else if (vartypeCont == "Female") {
    // } else {}
    isLoading.value = true;
    var profileData = await ApiServices().updateProfileService(
      userId: currentUserController.currentUser.value.data?.userId ?? '',
      varName: name.text,
      chrGender: vartypeCont,
      varDob: dob.text,
    );
    isLoading.value = false;
    if (profileData.status == 1) {
      await LocalStorage().currentUserSet(profileData);
      // currentUserController.currentUserDetailsGet(onlyUserDetailsGet: true);
      profileService(isLoadingShow: true);
      // Get.offAllNamed(AppRoutes.mainBottomView);
    }
  }

  @override
  void onInit() {
    profileService(isLoadingShow: true);
    super.onInit();
  }

  void profileService({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }

    var profileData = await ApiServices().profileService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (profileData.status == 1) {
      await LocalStorage().currentUserSet(profileData);
      currentUserController.currentUserDetailsGet(onlyUserDetailsGet: true);
      name.text = profileData.data!.varName!;
      email.text = profileData.data!.varEmail!;
      phone.text = profileData.data!.varMobileNo!;
      dob.text = profileData.data!.varDob!;
      if (profileData.data!.chrGender == "M") {
        vartypeCont = "Male";
      } else if (profileData.data!.chrGender == "F") {
        vartypeCont = "Female";
      } else {
        vartypeCont = "Other";
      }
    }
  }

  void deleteAccountApi() async {
    isLoading.value = true;
    var accountData = await ApiServices().deleteAcountService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (accountData == 1) {
      LocalStorage().removeCurrentUser();
      Get.deleteAll();
      Get.offAllNamed(AppRoutes.loginView);
    }
  }
}
