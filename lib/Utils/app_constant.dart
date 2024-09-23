import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Ui View/App_Widgets/button_outline_widget.dart';
import 'Routes/app_routes.dart';
import 'app_colors.dart';
import 'app_textstyle.dart';

class AppConstant {
  snackbars(String title, String message,
          {Color? backgroundColor, Widget? icon}) =>
      Get.snackbar(
        title,
        message,
        titleText: Text(title),
        // messageText: ,
        backgroundColor: backgroundColor,
        icon: icon,
      );

  customPickImageDialog(
          {String? title,
          required TextTheme textTheme,
          required void Function()? onPressedCamera,
          required void Function()? onPressedGallary}) =>
      Get.defaultDialog(
        title: title ?? '',
        titleStyle: textTheme.titleMedium,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.camera_alt, size: 50.w),
              onPressed: onPressedCamera,
            ),
            IconButton(
              icon: Icon(Icons.image, size: 50.w),
              onPressed: onPressedGallary,
            ),
          ],
        ),
      );

  loginDialog() => Get.dialog(
        AlertDialog(
          backgroundColor: AppColors.whiteColor,
          contentPadding: const EdgeInsets.all(12),
          surfaceTintColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'You are not Login',
                      style: AppTextStyle.titleLarge.copyWith(
                          color: AppColors.orangeColor, fontSize: 22.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () => Get.back(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'You must be logged in to access this functionality.',
                style: AppTextStyle.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ButtonOutlineWidget(
                      borderColor: AppColors.greyColor,
                      title: "REGISTER",
                      textStyle: AppTextStyle.bodyLargeDarkGray16.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onTap: () => {
                        Get.back(),
                        Get.toNamed(AppRoutes.singUp),
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ButtonOutlineWidget(
                      borderColor: AppColors.greyColor,
                      title: "LOGIN",
                      textStyle: AppTextStyle.bodyLargeDarkGray16.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      onTap: () => {
                        Get.back(),
                        Get.toNamed(AppRoutes.loginView),
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      );
}
