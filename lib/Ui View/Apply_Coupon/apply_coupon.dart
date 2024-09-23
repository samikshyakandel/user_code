import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';

class ApplyCouponView extends StatelessWidget {
  const ApplyCouponView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          alignment: FractionalOffset.topLeft,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
              alignment: FractionalOffset.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppbarWidget(
                    title: 'Coupon',
                    isCart: false,
                    isSearch: false,
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5),
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  SizedBox(
                                    child: Container(
                                      // height: 95,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          color: AppColors.colorsList[index %
                                              AppColors.colorsList.length],
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin:
                                          const EdgeInsets.fromLTRB(0, 0, 5, 0),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                        border: Border.all(
                                            color: AppColors.lightGrayColor,
                                            width: 1),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 7, 5, 7),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text("ORDooo221",
                                                            style: AppTextStyle
                                                                .lableLargeBlue
                                                                .copyWith(
                                                              color: AppColors
                                                                      .colorsList[
                                                                  index %
                                                                      AppColors
                                                                          .colorsList
                                                                          .length],
                                                            )),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          if (Get
                                                              .isBottomSheetOpen!) {
                                                            Get.back();
                                                          }
                                                        },
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .fromLTRB(
                                                                  7, 3, 7, 3),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7),
                                                              border: Border.all(
                                                                  color: AppColors
                                                                          .colorsList[
                                                                      index %
                                                                          AppColors
                                                                              .colorsList
                                                                              .length],
                                                                  width: 1),
                                                              color: AppColors
                                                                  .lightBlueColor),
                                                          child: Text(
                                                            "APPLY",
                                                            style: AppTextStyle
                                                                .orderStatusButtonText
                                                                .copyWith(
                                                              color: AppColors
                                                                      .colorsList[
                                                                  index %
                                                                      AppColors
                                                                          .colorsList
                                                                          .length],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 1,
                                                  width: double.infinity,
                                                  child: Container(
                                                    color: AppColors
                                                        .lightGrayColor,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          8, 8, 8, 8),
                                                  child: Text(
                                                    "Lorem Ipsum is simply dummy of Lorem Ipsum isthe printing.",
                                                    style: AppTextStyle
                                                        .bodyTextGray,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
