import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_singlevendor/Utils/app_images.dart';

import '../../Utils/app_textstyle.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(AppImages.emptyImage),
            ),
            SizedBox(height: 30.h),
            Text("Opps....it’s empty in here", style: AppTextStyle.lableLarge),
            SizedBox(height: 30.h),
            // ButtonWidget(
            //   title: "SHOPE NOW",
            //   onTap: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
