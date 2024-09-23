import 'package:flutter/material.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';

class RefundPolicy extends StatelessWidget {
  const RefundPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              AppbarWidget(
                  title: 'Refund Policy', isSearch: false, isCart: false),
              Expanded(
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 6),
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Lorem Ipsum is simply dummy of Lorem Ipsum isthe printing.",
                          style: AppTextStyle.bodyTextGray,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
