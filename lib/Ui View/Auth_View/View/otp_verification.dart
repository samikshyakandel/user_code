import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:new_user_singlevendor/Utils/app_images.dart';

import '../../App_Widgets/appbar_widget.dart';
import '../../App_Widgets/button_outline_widget.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            AppbarWidget(
                title: 'Enter Verification Code',
                isCart: false,
                isSearch: false),
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
                          Image.asset(AppImages.verificationSuccess,
                              alignment: Alignment.center),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("We have sent SMS To \n-----523",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0x80000000))),
                        ],
                      ),
                      const SizedBox(height: 30),
                      OtpTextField(
                        fieldWidth: 60,
                        numberOfFields: 4,
                        borderRadius: BorderRadius.circular(6),
                        enabledBorderColor: AppColors.greyColor,
                        focusedBorderColor: AppColors.orangeColor,
                        showFieldAsBox: true,
                        onCodeChanged: (String code) {},
                        onSubmit: (String verificationCode) {}, // end onSubmit
                      ),
                      const SizedBox(height: 30),
                      ButtonOutlineWidget(
                        title: "SEND",
                        onTap: () {},
                      ),
                      const SizedBox(height: 30),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Resend Code?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 13, color: Color(0x80000000))),
                        ],
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
