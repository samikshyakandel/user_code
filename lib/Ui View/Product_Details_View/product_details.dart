import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/button_outline_widget.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/button_widget.dart';
import 'package:new_user_singlevendor/Utils/Routes/app_routes.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:new_user_singlevendor/Utils/app_textstyle.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/product_widget.dart';
import '../Product_Review_View/give_review.dart';
import 'product_details_controller.dart';

class ProductDetailsView extends StatelessWidget {
  ProductDetailsView({super.key});

  final ProductDetailsController productDetailsController =
      Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              AppbarWidget(
                  title: productDetailsController.nameProductArg,
                  isSearch: false),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Obx(
                      () => Skeletonizer(
                        enabled: productDetailsController.isLoading.value,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    height: 345.h,
                                    child: Obx(
                                      () => Skeletonizer(
                                        enabled: productDetailsController
                                            .isLoading.value,
                                        child: PageView.builder(
                                          itemCount: productDetailsController
                                                  .selectVariantModel
                                                  .value
                                                  .variantImgs
                                                  ?.length ??
                                              0,
                                          onPageChanged: (val) =>
                                              productDetailsController
                                                  .selectBannerIndex
                                                  .value = val,
                                          itemBuilder: (context, i) => Padding(
                                            padding: EdgeInsets.only(
                                                left: i == 0 ? 6.0 : 0,
                                                right: 6.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: productDetailsController
                                                          .selectVariantModel
                                                          .value
                                                          .variantImgs?[i]
                                                          .isEmpty ??
                                                      true
                                                  ? Icon(
                                                      Icons.image,
                                                      color: AppColors.gray,
                                                      size: 40,
                                                    )
                                                  : Image.network(
                                                      productDetailsController
                                                              .selectVariantModel
                                                              .value
                                                              .variantImgs?[i] ??
                                                          '',
                                                      height: 345.h,
                                                      fit: BoxFit.fill,
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return Skeletonizer(
                                                          enabled: true,
                                                          child: Image.asset(
                                                            AppImages
                                                                .icHomeSliderImg,
                                                            height: 345.h,
                                                            // width: 150,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: Alignment.center,
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.center,
                                      children: List.generate(
                                        productDetailsController
                                                .selectVariantModel
                                                .value
                                                .variantImgs
                                                ?.length ??
                                            0,
                                        (index) => Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Obx(
                                            () => Icon(Icons.circle,
                                                size: 10,
                                                color: productDetailsController
                                                            .selectBannerIndex
                                                            .value ==
                                                        index
                                                    ? AppColors.orangeColor
                                                    : AppColors.gray),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ClipRRect(
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   child: Image.asset(
                                  //     AppImages.icProductImg,
                                  //     height: 345,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  // ),
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          productDetailsController
                                                  .productDetailsModel
                                                  .value
                                                  .data
                                                  ?.varTitle ??
                                              '',
                                          style: AppTextStyle.priceTextBlack,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      GestureDetector(
                                        onTap: () async => await Share.shareUri(
                                            Uri.parse(productDetailsController
                                                    .productDetailsModel
                                                    .value
                                                    .data
                                                    ?.shareUrl ??
                                                '')),
                                        child: Icon(
                                          Icons.share_outlined,
                                          color: AppColors.gray,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () => productDetailsController
                                                    .currentUserController
                                                    .currentUser
                                                    .value
                                                    .data ==
                                                null
                                            ? AppConstant().loginDialog()
                                            : {
                                                if (productDetailsController
                                                        .productDetailsModel
                                                        .value
                                                        .data
                                                        ?.like
                                                        ?.value ==
                                                    "Y")
                                                  {
                                                    productDetailsController
                                                        .productDetailsModel
                                                        .value
                                                        .data
                                                        ?.like
                                                        ?.value = "N",
                                                  }
                                                else
                                                  {
                                                    productDetailsController
                                                        .productDetailsModel
                                                        .value
                                                        .data
                                                        ?.like
                                                        ?.value = "Y",
                                                  },
                                                productDetailsController
                                                    .currentUserController
                                                    .favoriteAddRemoveApi(
                                                        fkProduct:
                                                            productDetailsController
                                                                .fkProductArg),
                                              },
                                        child: productDetailsController
                                                    .productDetailsModel
                                                    .value
                                                    .data
                                                    ?.like
                                                    ?.value ==
                                                "Y"
                                            ? Icon(Icons.favorite,
                                                    color: AppColors.redColor)
                                                .animate()
                                                .flip()
                                                .scale(delay: 400.ms)
                                            : Icon(
                                                Icons.favorite_outline,
                                                color: AppColors.gray,
                                              )
                                                .animate()
                                                .flip()
                                                .scale(delay: 500.ms),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      StarRating(
                                        starCount: 5,
                                        rating: double.parse(
                                            productDetailsController
                                                    .productDetailsModel
                                                    .value
                                                    .data
                                                    ?.ratting
                                                    .toString() ??
                                                '0.0'),
                                        color: AppColors.orangeColor,
                                        size: 20,
                                        onRatingChanged: (double double) {},
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        productDetailsController
                                                .productDetailsModel
                                                .value
                                                .data
                                                ?.ratting
                                                .toString() ??
                                            '0.0',
                                        style: AppTextStyle.bodyTextGray,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    productDetailsController.productDetailsModel
                                            .value.data?.varShortDescription ??
                                        '',
                                    style: AppTextStyle.bodyTextGray,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.greyLightColor),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ...List.generate(
                                      productDetailsController
                                              .productDetailsModel
                                              .value
                                              .data
                                              ?.prodOptions
                                              ?.length ??
                                          0,
                                      (i) {
                                        var prodOptionData =
                                            productDetailsController
                                                .productDetailsModel
                                                .value
                                                .data
                                                ?.prodOptions?[i];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              prodOptionData?.varAttribute ??
                                                  '',
                                              style: AppTextStyle.titleLarge
                                                  .copyWith(fontSize: 16),
                                            ),
                                            const SizedBox(height: 2),
                                            Wrap(
                                              spacing: 8,
                                              children: [
                                                ...List.generate(
                                                  prodOptionData
                                                          ?.attrsV?.length ??
                                                      0,
                                                  (ind) {
                                                    var attributData =
                                                        prodOptionData
                                                            ?.attrsV?[ind];
                                                    return IntrinsicWidth(
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () => productDetailsController
                                                                .changeVariantApi(
                                                                    attributeId:
                                                                        attributData?.intGlcode ??
                                                                            ''),
                                                            child: Obx(
                                                              () => Icon(
                                                                  productDetailsController
                                                                              .selectVariantModel
                                                                              .value
                                                                              .variantValues
                                                                              ?.contains(attributData
                                                                                  ?.intGlcode) ??
                                                                          false
                                                                      ? Icons
                                                                          .check_box_rounded
                                                                      : Icons
                                                                          .check_box_outline_blank,
                                                                  color: productDetailsController
                                                                              .selectVariantModel
                                                                              .value
                                                                              .variantValues
                                                                              ?.contains(attributData
                                                                                  ?.intGlcode) ??
                                                                          false
                                                                      ? AppColors
                                                                          .orangeColor
                                                                      : AppColors
                                                                          .blackColor),
                                                            ),
                                                          ),
                                                          // const SizedBox(
                                                          //     width: 4),
                                                          Text(
                                                            attributData
                                                                    ?.varAttributesValues ??
                                                                '',
                                                            style: AppTextStyle
                                                                .bodyTextGray,
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                          ],
                                        );
                                      },
                                    ),
                                    ///////////////////
                                    // Text(
                                    //   "Select Size",
                                    //   style: AppTextStyle.titleLarge
                                    //       .copyWith(fontSize: 16),
                                    // ),
                                    // const SizedBox(height: 10),
                                    // Row(
                                    //   children: List.generate(
                                    //     4,
                                    //     (index) => Obx(
                                    //       () => sizeColorWidget(
                                    //         title: index == 0
                                    //             ? "S"
                                    //             : index == 1
                                    //                 ? "M"
                                    //                 : index == 2
                                    //                     ? "L"
                                    //                     : "XL",
                                    //         fillColor: productDetailsController
                                    //                     .selectSize.value ==
                                    //                 index
                                    //             ? AppColors.orangeColor
                                    //             : AppColors.whiteColor,
                                    //         borderColor:
                                    //             productDetailsController
                                    //                         .selectSize.value ==
                                    //                     index
                                    //                 ? null
                                    //                 : AppColors.lightGrayColor,
                                    //         textColor: productDetailsController
                                    //                     .selectSize.value ==
                                    //                 index
                                    //             ? AppColors.whiteColor
                                    //             : null,
                                    //         onTap: () =>
                                    //             productDetailsController
                                    //                 .selectSize.value = index,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 20),
                                    // Text(
                                    //   "Select Color",
                                    //   style: AppTextStyle.titleLarge
                                    //       .copyWith(fontSize: 16),
                                    // ),
                                    // const SizedBox(height: 10),
                                    // Row(
                                    //   children: List.generate(
                                    //     4,
                                    //     (index) => Obx(
                                    //       () => sizeColorWidget(
                                    //         title: "",
                                    //         fillColor: index == 0
                                    //             ? AppColors.orangeColor
                                    //             : index == 1
                                    //                 ? AppColors.redColor
                                    //                 : index == 2
                                    //                     ? AppColors.pinkColor
                                    //                     : AppColors.blueColor,
                                    //         borderColor:
                                    //             productDetailsController
                                    //                         .selectColor
                                    //                         .value ==
                                    //                     index
                                    //                 ? AppColors.blackColor
                                    //                 : null,
                                    //         textColor: productDetailsController
                                    //                     .selectColor.value ==
                                    //                 index
                                    //             ? AppColors.whiteColor
                                    //             : null,
                                    //         onTap: () =>
                                    //             productDetailsController
                                    //                 .selectColor.value = index,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                    // const SizedBox(height: 20),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Quantity",
                                      style: AppTextStyle.titleLarge
                                          .copyWith(fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        qtyWidget(
                                          title: '-',
                                          onTap: () => productDetailsController
                                                      .selectVariantModel
                                                      .value
                                                      .cartItem!
                                                      .value >
                                                  1
                                              ? productDetailsController
                                                  .selectVariantModel
                                                  .value
                                                  .cartItem
                                                  ?.value--
                                              : null,
                                        ),
                                        Obx(
                                          () => qtyWidget(
                                              title:
                                                  "${productDetailsController.selectVariantModel.value.cartItem?.value == 0 ? (productDetailsController.selectVariantModel.value.cartItem!.value += 1) : productDetailsController.selectVariantModel.value.cartItem?.value ?? '1'}"),
                                        ),
                                        qtyWidget(
                                          title: '+',
                                          onTap: () => {
                                            if (productDetailsController
                                                    .selectVariantModel
                                                    .value
                                                    .cartItem!
                                                    .value <
                                                int.parse(
                                                    productDetailsController
                                                            .selectVariantModel
                                                            .value
                                                            .varStock ??
                                                        '0'))
                                              {
                                                productDetailsController
                                                    .selectVariantModel
                                                    .value
                                                    .cartItem
                                                    ?.value++,
                                              }
                                            else
                                              {
                                                AppConstant().snackbars("Info",
                                                    "Currently we have only ${productDetailsController.selectVariantModel.value.varStock} In Stock."),
                                              }
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${productDetailsController.currentUserController.currency.value}${productDetailsController.selectVariantModel.value.sellingPrice ?? ''}",
                                          style: AppTextStyle.bodyLargeGreen
                                              .copyWith(fontSize: 22),
                                        ),
                                        // if(offer > 0)
                                        const SizedBox(width: 10),
                                        Text(
                                          "${productDetailsController.currentUserController.currency.value}${productDetailsController.selectVariantModel.value.varPrice ?? ''}",
                                          style: AppTextStyle.bodyLargeDarkGray
                                              .copyWith(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    ButtonOutlineWidget(
                                        title: "ADD TO CART",
                                        onTap: () => productDetailsController
                                                    .currentUserController
                                                    .currentUser
                                                    .value
                                                    .data ==
                                                null
                                            ? AppConstant().loginDialog()
                                            : {
                                                productDetailsController
                                                    .currentUserController
                                                    .cartAddUpdateApi(
                                                        fkProduct:
                                                            productDetailsController
                                                                .fkProductArg,
                                                        fkVariant:
                                                            productDetailsController
                                                                    .selectVariantModel
                                                                    .value
                                                                    .variantId ??
                                                                '',
                                                        qty: productDetailsController
                                                                .selectVariantModel
                                                                .value
                                                                .cartItem
                                                                ?.value
                                                                .toString() ??
                                                            '1'),
                                                AppConstant().snackbars(
                                                    "Success",
                                                    "Item Added to Cart Successfully."),
                                              }),
                                    const SizedBox(height: 15),
                                    ButtonWidget(
                                      title: "BUY NOW",
                                      onTap: () => productDetailsController
                                                  .currentUserController
                                                  .currentUser
                                                  .value
                                                  .data ==
                                              null
                                          ? AppConstant().loginDialog()
                                          : {
                                              if (productDetailsController
                                                      .selectVariantModel
                                                      .value
                                                      .cartItem!
                                                      .value <=
                                                  int.parse(
                                                      productDetailsController
                                                              .selectVariantModel
                                                              .value
                                                              .varStock ??
                                                          '0'))
                                                {
                                                  productDetailsController
                                                      .currentUserController
                                                      .cartAddUpdateApi(
                                                          fkProduct:
                                                              productDetailsController
                                                                  .fkProductArg,
                                                          fkVariant: productDetailsController
                                                                  .selectVariantModel
                                                                  .value
                                                                  .variantId ??
                                                              '',
                                                          qty: productDetailsController
                                                                  .selectVariantModel
                                                                  .value
                                                                  .cartItem
                                                                  ?.value
                                                                  .toString() ??
                                                              '1'),
                                                  Get.toNamed(
                                                      AppRoutes.checkout),
                                                }
                                              else
                                                {
                                                  AppConstant().snackbars(
                                                      "Info",
                                                      "Currently we have only ${productDetailsController.selectVariantModel.value.varStock} In Stock."),
                                                }
                                            },
                                    ),
                                  ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 40),
                                        Text(
                                          "Descriptions",
                                          style: AppTextStyle.titleLarge
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          productDetailsController
                                                  .productDetailsModel
                                                  .value
                                                  .data
                                                  ?.txtDescription ??
                                              '',
                                          style: AppTextStyle.bodyTextGray,
                                        ),
                                        const SizedBox(height: 30),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.greyLightColor),
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Specifications",
                                          style: AppTextStyle.titleLarge
                                              .copyWith(fontSize: 16),
                                        ),
                                        const SizedBox(height: 10),
                                        /*Text(
                                          productDetailsController.productDetailsModel.value.data?.txtNutrition ?? '',
                                          style: AppTextStyle.bodyTextGray,
                                        ),*/
                                        Center(
                                          child: Html(
                                            data: productDetailsController
                                                    .productDetailsModel
                                                    .value
                                                    .data
                                                    ?.txtNutrition ??
                                                '',
                                            /*  style: {
                                              'body': AppTextStyle.bodyTextGray.toString(),
                                            },*/
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (productDetailsController
                                                .productDetailsModel
                                                .value
                                                .productReview
                                                ?.isNotEmpty ??
                                            false)
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Rating & Reviews",
                                                    style: AppTextStyle
                                                        .titleLarge
                                                        .copyWith(fontSize: 16),
                                                  ),
                                                  const SizedBox(height: 14),
                                                  SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    child: Obx(
                                                      () => ListView.separated(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        separatorBuilder: (context,
                                                                index) =>
                                                            Divider(
                                                                color: AppColors
                                                                    .greyColor),
                                                        itemCount:
                                                            productDetailsController
                                                                    .productDetailsModel
                                                                    .value
                                                                    .productReview
                                                                    ?.length ??
                                                                0,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var revData =
                                                              productDetailsController
                                                                  .productDetailsModel
                                                                  .value
                                                                  .productReview?[index];
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      revData?.varName ??
                                                                          '',
                                                                      style: AppTextStyle
                                                                          .lableLarge,
                                                                    ),
                                                                  ),
                                                                  StarRating(
                                                                    starCount:
                                                                        5,
                                                                    rating: double.parse(
                                                                        revData?.varRating ??
                                                                            ''),
                                                                    color: Colors
                                                                        .orange,
                                                                    size: 20,
                                                                    onRatingChanged:
                                                                        (double
                                                                            double) {},
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                GetTimeAgo.parse(
                                                                    DateTime.parse(
                                                                        revData?.dtModifydate ??
                                                                            '')),
                                                                style: AppTextStyle
                                                                    .bodyTextGray,
                                                              ),
                                                              if (revData
                                                                      ?.varReview
                                                                      ?.isNotEmpty ??
                                                                  false) ...[
                                                                const SizedBox(
                                                                    height: 6),
                                                                Text(
                                                                  revData?.varReview ??
                                                                      '',
                                                                  style: AppTextStyle
                                                                      .bodyTextGray,
                                                                ),
                                                              ],
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                ]),
                                          ),
                                        if (productDetailsController
                                                .productDetailsModel
                                                .value
                                                .similarCategoryProduct
                                                ?.isNotEmpty ??
                                            false)
                                          Container(
                                            // padding: EdgeInsets.all(10.w),
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColors.greyLightColor),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    child: Text(
                                                      "Similar Items",
                                                      style: AppTextStyle
                                                          .titleLarge
                                                          .copyWith(
                                                              fontSize: 16),
                                                    ),
                                                  ),
                                                  // const SizedBox(height: 10),
                                                  ResponsiveGridList(
                                                    listViewBuilderOptions:
                                                        ListViewBuilderOptions(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                    ),
                                                    minItemWidth: 150,
                                                    minItemsPerRow: 2,
                                                    maxItemsPerRow: 5,
                                                    horizontalGridMargin: 10,
                                                    horizontalGridSpacing: 4,
                                                    children: List.generate(
                                                      productDetailsController
                                                              .productDetailsModel
                                                              .value
                                                              .similarCategoryProduct
                                                              ?.length ??
                                                          0,
                                                      (index) {
                                                        var hotProductData =
                                                            productDetailsController
                                                                .productDetailsModel
                                                                .value
                                                                .similarCategoryProduct?[index];
                                                        return ProductWidget(
                                                          isBack: true,
                                                          fkProduct: hotProductData
                                                                  ?.intGlcode ??
                                                              '',
                                                          imagePath:
                                                              hotProductData
                                                                  ?.varImage,
                                                          name: hotProductData
                                                              ?.varTitle,
                                                          varPrice: hotProductData
                                                              ?.variantDetails
                                                              ?.varPrice,
                                                          sellingPrice:
                                                              hotProductData
                                                                  ?.variantDetails
                                                                  ?.sellingPrice,
                                                          isFavorite:
                                                              hotProductData
                                                                  ?.like?.value,
                                                          onTapFavorite: () => {
                                                            if (hotProductData
                                                                    ?.like
                                                                    ?.value ==
                                                                "Y")
                                                              {
                                                                hotProductData
                                                                        ?.like
                                                                        ?.value =
                                                                    "N",
                                                              }
                                                            else
                                                              {
                                                                hotProductData
                                                                        ?.like
                                                                        ?.value =
                                                                    "Y",
                                                              },
                                                            productDetailsController
                                                                .currentUserController
                                                                .favoriteAddRemoveApi(
                                                                    fkProduct:
                                                                        hotProductData?.intGlcode ??
                                                                            '')
                                                          },
                                                          offer: int.parse(
                                                              hotProductData
                                                                      ?.varOffer ??
                                                                  '0'),
                                                          cartItem:
                                                              hotProductData
                                                                      ?.cartItem
                                                                      ?.value ??
                                                                  0,
                                                          onTapIncrement: () =>
                                                              {
                                                            if (hotProductData!
                                                                    .cartItem!
                                                                    .value <
                                                                int.parse(hotProductData
                                                                        .variantDetails
                                                                        ?.varStock ??
                                                                    '0'))
                                                              {
                                                                hotProductData
                                                                    .cartItem
                                                                    ?.value++,
                                                                productDetailsController.currentUserController.cartAddUpdateApi(
                                                                    fkProduct:
                                                                        hotProductData.intGlcode ??
                                                                            '',
                                                                    fkVariant: hotProductData
                                                                            .variantDetails
                                                                            ?.variantId ??
                                                                        '',
                                                                    qty: hotProductData
                                                                            .cartItem
                                                                            ?.value
                                                                            .toString() ??
                                                                        '0'),
                                                              }
                                                            else
                                                              {
                                                                AppConstant()
                                                                    .snackbars(
                                                                        "Info",
                                                                        "Currently we have only ${hotProductData.variantDetails?.varStock} In Stock."),
                                                              }
                                                          },
                                                          onTapDecrement: () =>
                                                              {
                                                            hotProductData
                                                                ?.cartItem
                                                                ?.value--,
                                                            if (hotProductData!
                                                                        .cartItem!
                                                                        .value <
                                                                    int.parse(hotProductData
                                                                            .variantDetails
                                                                            ?.varStock ??
                                                                        '0')
                                                                //         &&
                                                                // hotProductData
                                                                //         .cartItem!
                                                                //         .value >
                                                                //     0
                                                                )
                                                              {
                                                                productDetailsController.currentUserController.cartAddUpdateApi(
                                                                    fkProduct:
                                                                        hotProductData.intGlcode ??
                                                                            '',
                                                                    fkVariant: hotProductData
                                                                            .variantDetails
                                                                            ?.variantId ??
                                                                        '',
                                                                    qty: hotProductData
                                                                            .cartItem
                                                                            ?.value
                                                                            .toString() ??
                                                                        '0'),
                                                              }
                                                            else
                                                              {
                                                                if (hotProductData
                                                                        .cartItem!
                                                                        .value >
                                                                    0)
                                                                  {
                                                                    AppConstant()
                                                                        .snackbars(
                                                                            "Info",
                                                                            "Currently we have only ${hotProductData.variantDetails?.varStock} In Stock."),
                                                                  }
                                                              },
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10),
                                                ]),
                                          ),
                                      ]),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sizeColorWidget(
      {required String title,
      void Function()? onTap,
      Color? fillColor,
      Color? borderColor,
      Color? textColor}) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: fillColor ?? AppColors.whiteColor,
              border:
                  Border.all(color: borderColor ?? AppColors.transperentColor),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyle.titleLarge
                .copyWith(fontSize: 16, color: textColor),
          ),
        ),
      ),
    );
  }

  Widget qtyWidget({required String title, void Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.lightGrayColor),
              borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          child: Text(
            title,
            style: AppTextStyle.titleLarge.copyWith(fontSize: 16),
          ),
        ),
      ),
    );
  }

  /*Widget ratingRevieWidget(List<ProductReview>? productReview) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Lorem Ipsum",
                style: AppTextStyle.lableLarge,
              ),
            ),
            StarRating(
              starCount: 5,
              rating: 4.0,
              color: Colors.orange,
              size: 20,
              onRatingChanged: (double double) {},
            ),
          ],
        ),
        Text(
          "2 day ago",
          style: AppTextStyle.bodyTextGray,
        ),
        const SizedBox(height: 6),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
          style: AppTextStyle.bodyTextGray,
        ),
      ],
    );
  }*/
}
