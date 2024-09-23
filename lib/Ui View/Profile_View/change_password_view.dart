import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_widget.dart';
import '../App_Widgets/textfield_widget.dart';
import 'Controller/change_password_controller.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());

  bool showPassword = true;
  bool showPasswordN = true;
  bool showPasswordC = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidget(
              title: "Change Password",
              isCart: false,
              isSearch: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => AbsorbPointer(
                    absorbing: changePasswordController.isLoading.value,
                    child: Form(
                      key: changePasswordController.changePasswordFormGlobalKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              TextFieldWidget(
                                controller:
                                    changePasswordController.oldPassword,
                                headerText: "Old Password",
                                hintText: "Enter Old Password",
                                obscureText: showPassword,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(showPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility),
                                ),
                                validator: (nameValue) {
                                  if (nameValue!.isEmpty) {
                                    return "Enter Old Password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFieldWidget(
                                controller:
                                    changePasswordController.newPassword,
                                headerText: "New Password",
                                hintText: "Enter New Password",
                                obscureText: showPasswordN,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPasswordN = !showPasswordN;
                                    });
                                  },
                                  child: Icon(showPasswordN
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility),
                                ),
                                validator: (nameValue) {
                                  if (nameValue!.isEmpty) {
                                    return "Enter New Password";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              TextFieldWidget(
                                controller:
                                    changePasswordController.confirmPassword,
                                headerText: "Confirm New Password",
                                hintText: "Enter Confirm New Password",
                                obscureText: showPasswordC,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    setState(() {
                                      showPasswordC = !showPasswordC;
                                    });
                                  },
                                  child: Icon(showPasswordC
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility),
                                ),
                                validator: (nameValue) {
                                  if (nameValue!.isEmpty) {
                                    return "Enter Confirm Password";
                                  } else if (changePasswordController
                                          .newPassword.text !=
                                      changePasswordController
                                          .confirmPassword.text) {
                                    return "Confirm Password Don't Match";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                            ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.w, left: 20, right: 20),
              child: ButtonWidget(
                title: "CHANGE PASSWORD",
                onTap: () {
                  if (changePasswordController.changePasswordFormGlobalKey.currentState!.validate()) {
                      changePasswordController.updateProfileApi();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
