import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTextStyle {
  static TextStyle headingLarge = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 30.sp,
    color: AppColors.blackColor,
  );
  static TextStyle titleLarge = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 24.sp, //17
    color: AppColors.blackColor,
  );

  static TextStyle lableLarge = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: AppColors.blackColor,
  );

  static TextStyle priceTextBlack = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 13.sp,
    color: AppColors.blackColor,
  );

  static TextStyle bodyTextGray = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 13.sp,
    color: AppColors.gray,
  );

  static TextStyle lableLargeBlue = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 15.sp,
    color: AppColors.blueColor,
  );

  static TextStyle qtyTextPurple = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 15.sp,
    color: AppColors.pupleColor,
  );

  static TextStyle orderStatusButtonText = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
    color: AppColors.blueColor,
  );

  static TextStyle lableCategory = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 10.sp,
    color: AppColors.blackColor,
  );
  static TextStyle lableCategory12 = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
    color: AppColors.blackColor,
  );
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.blackColor,
  );
  static TextStyle bodyLargeW600 = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: AppColors.blackColor,
  );
  static TextStyle socialBtnTextColor = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 14.sp,
    color: AppColors.black,
  );
  static TextStyle bodyLargeOrange = GoogleFonts.inter(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    color: AppColors.orangeColor,
  );
  static TextStyle bodyLargeOrangeSixteen = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
    color: AppColors.orangeColor,
  );
  static TextStyle bodyLargeDarkGray = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 12.sp,
    color: AppColors.darkGrayColor,
  );
  static TextStyle bodyLargeDarkGray16 = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: AppColors.darkGrayColor,
  );
  static TextStyle bodyLargeGreen = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
    color: AppColors.greenColor,
  );

  static TextStyle screenTitle = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    color: AppColors.orangeColor,
  );
  static TextStyle bodyLargeWhite = GoogleFonts.inter(
    fontWeight: FontWeight.w700,
    fontSize: 10.sp,
    color: AppColors.whiteColor,
  );
// static TextStyle get titleSmallGrey => GoogleFonts.inter(
//       fontWeight: FontWeight.w500,
//       fontSize: 14.sp,
//       color: AppColors.greyColor,
//     );
// static TextStyle get titleSmallBlack => GoogleFonts.inter(
//       fontWeight: FontWeight.w500,
//       fontSize: 13.sp,
//       color: AppColors.blackColor,
//     );
}
