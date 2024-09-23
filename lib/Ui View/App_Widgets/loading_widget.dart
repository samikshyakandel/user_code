import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.width});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 100.w,
      child: SpinKitFadingCircle(
        color: AppColors.orangeColor,
        // itemBuilder: (BuildContext context, int index) {
        //   return DecoratedBox(
        //     decoration: BoxDecoration(
        //       color: index.isEven ? Colors.red : Colors.green,
        //     ),
        //   );
        // },
      ),
    );
  }
}
