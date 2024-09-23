import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/textfield_widget.dart';
import 'package:new_user_singlevendor/Ui%20View/Auth_View/auth_controller/auth_controller.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:new_user_singlevendor/Utils/app_images.dart';

import '../../../Utils/Routes/app_routes.dart';
import '../../../Utils/app_textstyle.dart';
import '../../App_Widgets/button_outline_widget.dart';
import '../../App_Widgets/loading_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.put(AuthController());
  bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(
        () => AbsorbPointer(
          absorbing: authController.isLoading.value,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: authController.loginFormGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Welcome back\nSign In",
                          style: AppTextStyle.headingLarge
                              .copyWith(color: AppColors.orangeColor),
                        ),
                        const SizedBox(height: 30),
                        TextFieldWidget(
                          controller: authController.emailCont,
                          headerText: "E-mail / Phone",
                          hintText: "+91 12345 78963",
                          validator: (nameValue) {
                            if (nameValue!.isEmpty) {
                              return "Enter E-mail";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFieldWidget(
                          controller: authController.passwordCont,
                          headerText: "Password",
                          hintText: "********",
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
                              return "Enter Password";
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            /*  Checkbox(
                              value: false,
                              onChanged: (value) {},
                              materialTapTargetSize: MaterialTapTargetSize.padded,
                              visualDensity: const VisualDensity(
                                  horizontal: VisualDensity.minimumDensity,
                                  vertical: VisualDensity.minimumDensity),
                            ),
                            const Text("Remember Password"),*/
                            Expanded(child: Container()),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.forgotPassword);
                              },
                              child: Text("Forgot Password?",
                                  style: AppTextStyle.bodyTextGray),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        ButtonOutlineWidget(
                          title: "LOGIN",
                          onTap: () {
                            if (authController.loginFormGlobalKey.currentState!
                                .validate()) {
                              authController.loginApi();
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              color: AppColors.underlineColor,
                              height: 1,
                            )),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "or",
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.blackColor),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                                child: Container(
                              color: AppColors.underlineColor,
                              height: 1,
                            )),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonOutlineWidget(
                                title: "Google",
                                borderColor: AppColors.greyColor,
                                textStyle: AppTextStyle.socialBtnTextColor,
                                startIcon: AppImages.logoGoogle,
                                onTap: () {},
                              ),
                            ),
                            const SizedBox(
                              width: 14,
                            ),
                            Expanded(
                              child: ButtonOutlineWidget(
                                title: "Facebook",
                                borderColor: AppColors.greyColor,
                                textStyle: AppTextStyle.socialBtnTextColor,
                                startIcon: AppImages.logofacebook,
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                              color: AppColors.underlineColor,
                              height: 1,
                            )),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              "or",
                              style: AppTextStyle.bodyLarge
                                  .copyWith(color: AppColors.blackColor),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Expanded(
                                child: Container(
                              color: AppColors.underlineColor,
                              height: 1,
                            )),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ButtonOutlineWidget(
                          title: "SEND OTP",
                          onTap: () {
                            Get.toNamed(AppRoutes.otpVerifyView);
                          },
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You Don’t have account?",
                              style: TextStyle(color: AppColors.gray),
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.singUp);
                              },
                              child: Text(
                                "Sign Up",
                                style: AppTextStyle.bodyLargeOrangeSixteen,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: authController.isLoading.value,
                child: const Positioned(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
