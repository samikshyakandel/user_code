import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/textfield_widget.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';

import '../../../Utils/Routes/app_routes.dart';
import '../../../Utils/app_textstyle.dart';
import '../../App_Widgets/button_outline_widget.dart';
import '../../App_Widgets/loading_widget.dart';
import '../auth_controller/auth_controller.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
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
                    key: authController.signUpFormGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        Text(
                          "Welcome Sign Up",
                          style: AppTextStyle.headingLarge
                              .copyWith(color: AppColors.orangeColor),
                        ),
                        const SizedBox(height: 30),
                        TextFieldWidget(
                          controller: authController.name,
                          headerText: "Name",
                          hintText: "Enter Your Name",
                          validator: (nameValue) {
                            if (nameValue!.isEmpty) {
                              return "Enter Name";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFieldWidget(
                          controller: authController.email,
                          headerText: "E-mail",
                          hintText: "demo@demo.com",
                          validator: (nameValue) {
                            if (nameValue!.isEmpty) {
                              return "Enter E-mail";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFieldWidget(
                          controller: authController.phone,
                          headerText: "Phone",
                          hintText: "Enter Your Number",
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10)
                          ],
                          validator: (nameValue) {
                            if (nameValue!.isEmpty) {
                              return "Enter Phone";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 14),
                        TextFieldWidget(
                          controller: authController.password,
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
                        const SizedBox(height: 40),
                        ButtonOutlineWidget(
                          title: "REGISTER",
                          onTap: () {
                            if (authController.signUpFormGlobalKey.currentState!
                                .validate()) {
                              authController.signUpApi();
                            }
                          },
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style: TextStyle(color: AppColors.gray),
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.loginView);
                              },
                              child: Text(
                                "Login",
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
