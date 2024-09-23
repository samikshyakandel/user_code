import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/button_outline_widget.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/button_widget.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Utils/Routes/app_routes.dart';
import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../../Utils/local_storage.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({super.key});
  final CurrentUserController currentUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 100.h,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.orangeColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible:
                        currentUserController.currentUser.value.data == null,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: ButtonOutlineWidget(
                        width: 150,
                        title: "Login",
                        borderColor: AppColors.whiteColor,
                        textStyle: AppTextStyle.bodyLargeDarkGray16
                            .copyWith(color: AppColors.whiteColor),
                        onTap: () => Get.toNamed(AppRoutes.loginView),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: currentUserController
                              .currentUser.value.data?.userId !=
                          null,
                      child: Text(
                        currentUserController.currentUser.value.data?.varName ??
                            '',
                        textAlign: TextAlign.start,
                        style: AppTextStyle.bodyLargeW600
                            .copyWith(color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: currentUserController
                              .currentUser.value.data?.userId !=
                          null,
                      child: Text(
                        currentUserController
                                .currentUser.value.data?.varEmail ??
                            '',
                        textAlign: TextAlign.start,
                        style: AppTextStyle.bodyLargeW600.copyWith(
                            color: AppColors.whiteColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w200),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Row(children: [
              Container(
                height: 38,
                width: 38,
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  AppImages.icLocation,
                ),
              ),
              Expanded(
                child: Text(
                  "Address",
                  textAlign: TextAlign.start,
                  style: AppTextStyle.bodyLargeW600,
                ),
              ),
              SizedBox(
                height: 11,
                width: 6,
                child: SvgPicture.asset(AppImages.icRight),
              ),
            ]),
            onTap: () => currentUserController.currentUser.value.data == null
                ? AppConstant().loginDialog()
                : Get.toNamed(AppRoutes.addressListView),
          ),
          ListTile(
            title: Row(children: [
              Container(
                height: 38,
                width: 38,
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  AppImages.icWishList,
                ),
              ),
              Expanded(
                child: Text(
                  "Wishlist",
                  textAlign: TextAlign.start,
                  style: AppTextStyle.bodyLargeW600,
                ),
              ),
              SizedBox(
                height: 11,
                width: 6,
                child: SvgPicture.asset(
                  AppImages.icRight,
                ),
              ),
            ]),
            onTap: () => currentUserController.currentUser.value.data == null
                ? AppConstant().loginDialog()
                : Get.toNamed(AppRoutes.wishListView),
          ),
          ListTile(
            title: Row(children: [
              Container(
                height: 38,
                width: 38,
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  AppImages.icPassword,
                ),
              ),
              Expanded(
                child: Text(
                  "Change Password",
                  textAlign: TextAlign.start,
                  style: AppTextStyle.bodyLargeW600,
                ),
              ),
              SizedBox(
                height: 11,
                width: 6,
                child: SvgPicture.asset(
                  AppImages.icRight,
                ),
              ),
            ]),
            onTap: () => currentUserController.currentUser.value.data == null
                ? AppConstant().loginDialog()
                : Get.toNamed(AppRoutes.changePasswordView),
          ),
          ListTile(
            title: Row(children: [
              Container(
                height: 38,
                width: 38,
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  AppImages.icShippingPolicy,
                ),
              ),
              Expanded(
                child: Text(
                  "Shipping Policy",
                  textAlign: TextAlign.start,
                  style: AppTextStyle.bodyLargeW600,
                ),
              ),
              SizedBox(
                height: 11,
                width: 6,
                child: SvgPicture.asset(
                  AppImages.icRight,
                ),
              ),
            ]),
            onTap: () => Get.toNamed(AppRoutes.shippingPolicy),
          ),
          ListTile(
            title: Row(children: [
              Container(
                height: 38,
                width: 38,
                margin: const EdgeInsets.only(right: 20),
                child: SvgPicture.asset(
                  AppImages.icRefundPolicy,
                ),
              ),
              Expanded(
                child: Text(
                  "Refund Policy",
                  textAlign: TextAlign.start,
                  style: AppTextStyle.bodyLargeW600,
                ),
              ),
              SizedBox(
                height: 11,
                width: 6,
                child: SvgPicture.asset(
                  AppImages.icRight,
                ),
              ),
            ]),
            onTap: () => Get.toNamed(AppRoutes.refundPolicy),
          ),
          Visibility(
            visible:
                currentUserController.currentUser.value.data?.userId != null,
            child: ListTile(
              title: Row(children: [
                Container(
                  height: 38,
                  width: 38,
                  margin: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    AppImages.icLogout,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Logout",
                    textAlign: TextAlign.start,
                    style: AppTextStyle.bodyLargeW600,
                  ),
                ),
                SizedBox(
                  height: 11,
                  width: 6,
                  child: SvgPicture.asset(
                    AppImages.icRight,
                  ),
                ),
              ]),
              onTap: () async {
                // await showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return const LogoutDialog();
                //   },
                // );
                Get.defaultDialog(
                  title: 'Logout',
                  titleStyle: AppTextStyle.headingLarge,
                  backgroundColor: AppColors.whiteColor,
                  content: Column(
                    children: [
                      Text(
                        'Are you sure you want to logout?',
                        style: AppTextStyle.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonOutlineWidget(
                            width: 60,
                            title: "No",
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            onTap: () => Get.back(),
                          ),
                          ButtonWidget(
                            width: 60,
                            title: "Yes",
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            onTap: () => {
                              LocalStorage().removeCurrentUser(),
                              Get.deleteAll(),
                              Get.back(),
                              Get.offAllNamed(AppRoutes.loginView),
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                /* await LocalStorage().removeCurrentUser();
                Get.deleteAll();
                Get.back();
                Get.offAllNamed(AppRoutes.loginView);*/
              },
            ),
          ),
        ],
      ),
    );
  }
}
