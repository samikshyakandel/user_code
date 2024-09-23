import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';

import '../../Utils/app_textstyle.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.name,
    this.imagePath,
    this.onTap,
    this.size,
    this.isSelected,
  });

  final String? name;
  final String? imagePath;
  final void Function()? onTap;
  final double? size;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size ?? 70,
            height: size ?? 70,
            decoration: BoxDecoration(
              color: AppColors.greyColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ?? false
                    ? AppColors.orangeColor
                    : AppColors.transperentColor,
                width: 2.0,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: imagePath!.isNotEmpty
                  ? Image.network(
                      imagePath!,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.image,
                      color: AppColors.gray,
                    ),
            ),
          ),
          // CircleAvatar(
          //   radius: isSelected ?? false ? radius! + 3 : radius ?? 40,
          //   backgroundColor: AppColors.orangeColor,
          //   child: imagePath!.isNotEmpty
          //       ? CircleAvatar(
          //           radius: radius ?? 40,
          //           backgroundColor: AppColors.greyLightColor,
          //           backgroundImage: Image.network(
          //             imagePath!,
          //             // fit: BoxFit.scaleDown,
          //             // height: 20,
          //             // width: 20,
          //             loadingBuilder: (BuildContext context, Widget child,
          //                 ImageChunkEvent? loadingProgress) {
          //               if (loadingProgress == null) return child;
          //               return Center(
          //                 child: CircularProgressIndicator(
          //                   value: loadingProgress.expectedTotalBytes != null
          //                       ? loadingProgress.cumulativeBytesLoaded /
          //                           loadingProgress.expectedTotalBytes!
          //                       : null,
          //                 ),
          //               );
          //             },
          //           ).image,
          //         )
          //       : CircleAvatar(
          //           radius: radius ?? 40,
          //           backgroundColor: AppColors.greyLightColor,
          //           child: Icon(
          //             Icons.image,
          //             color: AppColors.gray,
          //           ),
          //         ),
          // ),
          const SizedBox(height: 4),
          SizedBox(
            height: 28.h,
            width: size ?? 70,
            child: Text(
              name ?? '',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: AppTextStyle.lableCategory,
            ),
          ),
        ],
      ),
    );
  }
}
