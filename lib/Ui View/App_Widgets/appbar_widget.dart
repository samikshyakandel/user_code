import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Utils/Routes/app_routes.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../Address_Screen/Model/get_address_model.dart';
import 'button_outline_widget.dart';
import 'button_widget.dart';

class AppbarWidget extends StatelessWidget {
  AppbarWidget({
    super.key,
    required this.title,
    this.isDrawer = false,
    this.isFilter = false,
    this.onTapFilter,
    this.isSearch = true,
    this.isCart = true,
    this.isClearCart = false,
    this.isAddAddress = false,
  });

  final String title;
  final bool isDrawer;
  final bool isFilter;
  final void Function()? onTapFilter;
  final bool isSearch;
  final bool isCart;
  final bool isClearCart;
  final bool isAddAddress;

  final CurrentUserController currentUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.h,
      child: Row(
        children: [
          SizedBox(width: 6.w),
          isDrawer
              ? InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  borderRadius: BorderRadius.circular(10.r),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: SvgPicture.asset(
                      AppImages.icMenu,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(10.r),
                    child: SvgPicture.asset(AppImages.icBack),
                  ),
                ),
          // Container(
          //     child: title.isNotEmpty
          //         ? SizedBox(width: 10.w)
          //         : SizedBox(width: 24.w)),
          Expanded(
            child: title.isNotEmpty
                ? Text(
                    title,
                    style: AppTextStyle.screenTitle.copyWith(fontSize: 18.sp),
                    textAlign: isDrawer ? TextAlign.center : null,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Image.asset(
                    AppImages.logoWithNameImage,
                    scale: 7,
                  ),
          ),
          const SizedBox(width: 6),
          if (isFilter) ...[
            InkWell(
              onTap: onTapFilter,
              child: SvgPicture.asset(
                AppImages.icFilter,
              ),
            ),
            const SizedBox(width: 20),
          ],
          if (isSearch) ...[
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.searchView),
              child: SvgPicture.asset(
                AppImages.icSearch,
              ),
            ),
            const SizedBox(width: 20),
          ],
          if (isCart) ...[
            GestureDetector(
              onTap: () => currentUserController.currentUser.value.data == null
                  ? AppConstant().loginDialog()
                  : Get.toNamed(AppRoutes.cartView),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: SvgPicture.asset(
                      AppImages.icOrderTopBar,
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible:
                          currentUserController.cartCount.value.isNotEmpty &&
                              currentUserController.cartCount.value != '0',
                      child: Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 9,
                          backgroundColor: AppColors.orangeColor,
                          child: Text(
                            currentUserController.cartCount.value,
                            style: TextStyle(
                                color: AppColors.whiteColor, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20.w),
          ],
          if (isClearCart) ...[
            InkWell(
              onTap: () => Get.defaultDialog(
                title: 'Clear Cart',
                titleStyle: AppTextStyle.headingLarge,
                backgroundColor: AppColors.whiteColor,
                content: Column(
                  children: [
                    Text(
                      'Are you sure you want to clear cart products?',
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
                            Get.back(closeOverlays: true),
                            currentUserController.clearCartApi(),
                            // Get.back(),
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.greyColor)),
                child: Text("Clear Cart", style: AppTextStyle.lableLarge),
              ),
            ),
            const SizedBox(width: 20),
          ],
          if (isAddAddress) ...[
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.addAddress, arguments: AddressData());
              },
              child: SvgPicture.asset(
                AppImages.icAddLogo,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ],
      ),
    );
  }
}
