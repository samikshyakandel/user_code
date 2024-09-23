import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/textfield_widget.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:new_user_singlevendor/Utils/app_images.dart';

import '../../../Utils/Routes/app_routes.dart';
import '../../../Utils/app_textstyle.dart';
import '../../App_Widgets/appbar_widget.dart';
import '../../App_Widgets/button_outline_widget.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            AppbarWidget(
                title: 'Forgot Password', isCart: false, isSearch: false),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.lockIcon,
                              alignment: Alignment.center),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "Lorem Ipsum is simply dummy text of the printing  and typesetting industry.",
                        textAlign: TextAlign.center,
                        style: AppTextStyle.bodyTextGray,
                      ),
                      const SizedBox(height: 30),
                      const TextFieldWidget(
                        headerText: "E-mail",
                        hintText: "demo@demo.com",
                      ),
                      const SizedBox(height: 50),
                      ButtonOutlineWidget(
                        title: "SEND",
                        onTap: () {
                          Get.toNamed(AppRoutes.otpVerifyView);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
