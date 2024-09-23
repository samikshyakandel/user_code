import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';

import '../../Utils/app_textstyle.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color? borderColor;
  final String? startIcon;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final void Function()? onTap;

  const ButtonWidget({
    Key? key,
    required this.title,
    this.borderColor,
    this.startIcon,
    this.padding,
    this.width,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          /*border: Border.all(
            width: 1.0,
            color: borderColor ?? AppColors.orangeColor,
          ),*/
          color: AppColors.orangeColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (startIcon != null) ...[
              SvgPicture.asset(
                startIcon.toString(),
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              title,
              style: AppTextStyle.bodyLargeDarkGray16
                  .copyWith(color: AppColors.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
