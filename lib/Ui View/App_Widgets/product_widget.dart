import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Current_User/current_user_controller.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/Routes/app_routes.dart';
import '../../Utils/app_colors.dart';
import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../Product_Details_View/product_details_controller.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    super.key,
    required this.fkProduct,
    this.imagePath,
    this.name,
    this.varPrice,
    this.sellingPrice,
    this.isFavorite,
    this.onTapFavorite,
    required this.offer,
    required this.cartItem,
    this.onTapIncrement,
    this.onTapDecrement,
    this.isBack,
  });

  final String fkProduct;
  final String? imagePath;
  final String? name;
  final String? varPrice;
  final String? sellingPrice;
  final String? isFavorite;
  final void Function()? onTapFavorite;
  final int offer;
  final int cartItem;
  final void Function()? onTapIncrement;
  final void Function()? onTapDecrement;
  final bool? isBack;

  final CurrentUserController currentUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        if (isBack ?? false)
          {
            Get.back(),
            Get.delete<ProductDetailsController>(),
            Get.toNamed(AppRoutes.productDetails, arguments: [fkProduct, name]),
          }
        else
          {
            Get.toNamed(AppRoutes.productDetails, arguments: [fkProduct, name]),
          }
      },
      borderRadius: BorderRadius.circular(10.r),
      child: SizedBox(
        width: 165,
        child: Card(
          elevation: 6,
          surfaceTintColor: AppColors.whiteColor,
          shadowColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: imagePath?.isNotEmpty ?? false
                            ? Image.network(
                                imagePath!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.fill,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Skeletonizer(
                                    enabled: true,
                                    child: Image.asset(
                                      AppImages.icProductImg,
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              )
                            : SizedBox(
                                height: 150,
                                width: 150,
                                child: Icon(
                                  Icons.image,
                                  color: AppColors.gray,
                                  size: 40,
                                ),
                              )
                        // Image.asset(
                        //     AppImages.icProductImg,
                        //     height: 150,
                        //     width: 150,
                        //     fit: BoxFit.cover,
                        //   ),
                        ),
                    Visibility(
                      visible: offer > 0,
                      child: Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            width: 42,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppColors.greenColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                            child: Text(
                              "$offer%",
                              style: AppTextStyle.bodyLargeWhite,
                            )),
                      ),
                    ),
                    Positioned(
                      top: 2,
                      right: 2,
                      child: InkWell(
                        onTap:
                            currentUserController.currentUser.value.data == null
                                ? () => AppConstant().loginDialog()
                                : onTapFavorite,
                        child: isFavorite == "Y"
                            ? Icon(Icons.favorite, color: AppColors.redColor)
                                .animate()
                                .flip()
                                .scale(delay: 400.ms)
                            : Icon(
                                Icons.favorite_outline,
                                color: AppColors.gray,
                              ).animate().flip().scale(delay: 500.ms),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                SizedBox(
                  height: 32.h,
                  child: Text(
                    name ?? "",
                    style: AppTextStyle.lableCategory12,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentUserController.currency.value}${sellingPrice ?? ""}",
                            style: AppTextStyle.bodyLargeGreen,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Visibility(
                            // visible: offer > 0,
                            child: Text(
                              offer > 0
                                  ? "${currentUserController.currency.value}${varPrice ?? ""}"
                                  : '',
                              style: AppTextStyle.bodyLargeDarkGray.copyWith(
                                  decoration: TextDecoration.lineThrough),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (cartItem <= 0)
                      InkWell(
                        onTap:
                            currentUserController.currentUser.value.data == null
                                ? () => AppConstant().loginDialog()
                                : onTapIncrement,
                        child: SvgPicture.asset(
                          AppImages.icCartLogo,
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    if (cartItem > 0) ...[
                      qtyWidget(title: "-", onTap: onTapDecrement),
                      qtyWidget(title: "$cartItem"),
                      qtyWidget(title: "+", onTap: onTapIncrement),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget qtyWidget({required String title, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(6)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyle.titleLarge.copyWith(fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}
