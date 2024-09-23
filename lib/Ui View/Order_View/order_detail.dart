import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Utils/app_textstyle.dart';
import '../../Utils/Routes/app_routes.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_outline_widget.dart';
import '../App_Widgets/button_widget.dart';
import 'OrderList_Controller/order_details_controller.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({super.key});

  final OrderDetailsController orderDetailsController =
      Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarWidget(title: 'Order Details', isSearch: false),
              Expanded(
                  child: SingleChildScrollView(
                child: Obx(
                  () => Skeletonizer(
                    enabled: orderDetailsController.isLoading.value,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Obx(
                                          () => Skeletonizer(
                                            enabled: orderDetailsController
                                                .isLoading.value,
                                            child: ListView.separated(
                                                padding: EdgeInsets.zero,
                                                separatorBuilder:
                                                    (context, index) => Divider(
                                                        color: AppColors
                                                            .greyColor),
                                                itemCount:
                                                    orderDetailsController
                                                            .getOrderListModel
                                                            .value
                                                            .data
                                                            ?.fkProductArr
                                                            ?.length ??
                                                        0,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  var fkProductData =
                                                      orderDetailsController
                                                              .getOrderListModel
                                                              .value
                                                              .data
                                                              ?.fkProductArr?[
                                                          index];
                                                  return GestureDetector(
                                                    onTap: () => Get.toNamed(
                                                        AppRoutes
                                                            .productDetails,
                                                        arguments: [
                                                          fkProductData
                                                              .fkProduct,
                                                          fkProductData.varName
                                                        ]),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Card(
                                                          elevation: 8,
                                                          surfaceTintColor:
                                                              AppColors
                                                                  .whiteColor,
                                                          shadowColor: AppColors
                                                              .whiteColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child: fkProductData
                                                                        ?.varImage
                                                                        ?.isEmpty ??
                                                                    true
                                                                ? Icon(
                                                                    Icons.image,
                                                                    color:
                                                                        AppColors
                                                                            .gray,
                                                                    size: 40,
                                                                  )
                                                                : Image.network(
                                                                    fkProductData
                                                                            ?.varImage ??
                                                                        '',
                                                                    height: 100,
                                                                    width: 100,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  fkProductData
                                                                          ?.varName ??
                                                                      '',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppTextStyle
                                                                      .lableLarge),
                                                              const SizedBox(
                                                                  height: 5),
                                                              if (orderDetailsController
                                                                      .getOrderListModel
                                                                      .value
                                                                      .data
                                                                      ?.dtCreateddate !=
                                                                  null)
                                                                Text(
                                                                  Jiffy
                                                                      .parseFromDateTime(
                                                                    DateTime.parse(orderDetailsController
                                                                            .getOrderListModel
                                                                            .value
                                                                            .data
                                                                            ?.dtCreateddate ??
                                                                        ''),
                                                                  ).format(
                                                                      pattern:
                                                                          'd MMM, yyyy'),
                                                                  // formatChanger(orderDetailsController
                                                                  //         .getOrderListModel
                                                                  //         .value
                                                                  //         .data
                                                                  //         ?.dtCreateddate ??
                                                                  //     ''),
                                                                  style: AppTextStyle
                                                                      .bodyTextGray,
                                                                ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${orderDetailsController.currentUserController.currency.value}${fkProductData?.varPrice}",
                                                                    style: AppTextStyle
                                                                        .bodyLargeGreen,
                                                                  ),
                                                                  Text(
                                                                      " x ${fkProductData?.varUnit}",
                                                                      style: AppTextStyle
                                                                          .lableLarge),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 6),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Visibility(
                                                                      visible: orderDetailsController
                                                                              .getOrderListModel
                                                                              .value
                                                                              .data
                                                                              ?.chrStatus ==
                                                                          "S",
                                                                      child:
                                                                          Visibility(
                                                                        visible:
                                                                            fkProductData!.varQut! >
                                                                                0,
                                                                        // !orderDetailsController
                                                                        //     .getOrderListModel
                                                                        //     .value
                                                                        //     .data!
                                                                        //     .returnProduct!
                                                                        //     .where((e) =>
                                                                        //         e.fkProduct ==
                                                                        //         fkProductData?.fkProduct)
                                                                        //     .isNotEmpty,
                                                                        child:
                                                                            ButtonOutlineWidget(
                                                                          // width: 90,
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 2),
                                                                          title:
                                                                              "RETURN",
                                                                          onTap: () => Get.toNamed(
                                                                              AppRoutes.returnOrderView,
                                                                              arguments: [
                                                                                fkProductData,
                                                                                orderDetailsController.getOrderListModel.value.data?.orderId,
                                                                                orderDetailsController.getOrderListModel.value.data?.intGlcode,
                                                                              ]),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          12),
                                                                  Expanded(
                                                                    child:
                                                                        Visibility(
                                                                      visible: orderDetailsController
                                                                              .getOrderListModel
                                                                              .value
                                                                              .data
                                                                              ?.chrStatus ==
                                                                          "S",
                                                                      child:
                                                                          ButtonOutlineWidget(
                                                                        // width: 90,
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                2),
                                                                        title:
                                                                            "REVIEW",
                                                                        onTap: () => Get.toNamed(
                                                                            AppRoutes.giveMeReview,
                                                                            arguments: [
                                                                              fkProductData,
                                                                              orderDetailsController.getOrderListModel.value.data?.intGlcode ?? ''
                                                                            ]),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration:
                                BoxDecoration(color: AppColors.greyLightColor),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: orderDetailsController
                                            .getOrderListModel
                                            .value
                                            .data
                                            ?.returnProduct
                                            ?.isNotEmpty ??
                                        false,
                                    child: ButtonOutlineWidget(
                                      // width: 90,
                                      // padding: const EdgeInsets.symmetric(
                                      //     vertical: 2),
                                      title: "Show Return Orders",
                                      onTap: () => Get.defaultDialog(
                                        title: 'Return Orders',
                                        titleStyle: AppTextStyle.titleLarge,
                                        backgroundColor: AppColors.whiteColor,
                                        content: Column(
                                          children: [
                                            ListView.separated(
                                                padding: EdgeInsets.zero,
                                                separatorBuilder:
                                                    (context, ind) => Divider(
                                                        color: AppColors
                                                            .greyColor),
                                                itemCount:
                                                    orderDetailsController
                                                            .getOrderListModel
                                                            .value
                                                            .data
                                                            ?.returnProduct
                                                            ?.length ??
                                                        0,
                                                shrinkWrap: true,
                                                itemBuilder: (context, ind) {
                                                  var returnOrderData =
                                                      orderDetailsController
                                                          .getOrderListModel
                                                          .value
                                                          .data
                                                          ?.returnProduct?[ind];
                                                  return Row(
                                                    children: [
                                                      Card(
                                                        elevation: 8,
                                                        surfaceTintColor:
                                                            AppColors
                                                                .whiteColor,
                                                        shadowColor: AppColors
                                                            .whiteColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: returnOrderData
                                                                      ?.varImage
                                                                      ?.isEmpty ??
                                                                  true
                                                              ? Icon(
                                                                  Icons.image,
                                                                  color:
                                                                      AppColors
                                                                          .gray,
                                                                  size: 40,
                                                                )
                                                              : Image.network(
                                                                  returnOrderData
                                                                          ?.varImage ??
                                                                      '',
                                                                  height: 80,
                                                                  width: 80,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      Expanded(
                                                        child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  returnOrderData
                                                                          ?.varName ??
                                                                      '',
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: AppTextStyle
                                                                      .lableLarge),
                                                              const SizedBox(
                                                                  height: 5),
                                                              if (orderDetailsController
                                                                      .getOrderListModel
                                                                      .value
                                                                      .data
                                                                      ?.dtCreateddate !=
                                                                  null)
                                                                Text(
                                                                  Jiffy
                                                                      .parseFromDateTime(
                                                                    DateTime.parse(orderDetailsController
                                                                            .getOrderListModel
                                                                            .value
                                                                            .data
                                                                            ?.dtCreateddate ??
                                                                        ''),
                                                                  ).format(
                                                                      pattern:
                                                                          'd MMM, yyyy'),
                                                                  // formatChanger(orderDetailsController
                                                                  //         .getOrderListModel
                                                                  //         .value
                                                                  //         .data
                                                                  //         ?.dtCreateddate ??
                                                                  //     ''),
                                                                  style: AppTextStyle
                                                                      .bodyTextGray,
                                                                ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    "${orderDetailsController.currentUserController.currency.value}${returnOrderData?.varPrice}",
                                                                    style: AppTextStyle
                                                                        .bodyLargeGreen,
                                                                  ),
                                                                  Text(
                                                                      " x ${returnOrderData?.varUnit}",
                                                                      style: AppTextStyle
                                                                          .lableLarge),
                                                                ],
                                                              ),
                                                            ]),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                            const SizedBox(height: 20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                ButtonOutlineWidget(
                                                  width: 60,
                                                  title: "Close",
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 4),
                                                  onTap: () => Get.back(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                        "Order ${orderDetailsController.getOrderListModel.value.data?.orderId ?? ''}",
                                        style: AppTextStyle.bodyLargeW600,
                                      )),
                                      Text(
                                        orderDetailsController.getOrderListModel
                                                    .value.data?.chrStatus ==
                                                "P"
                                            ? "Pending"
                                            : orderDetailsController
                                                        .getOrderListModel
                                                        .value
                                                        .data
                                                        ?.chrStatus ==
                                                    "W"
                                                ? "Packed & Ready To Ship"
                                                : orderDetailsController
                                                            .getOrderListModel
                                                            .value
                                                            .data
                                                            ?.chrStatus ==
                                                        "SH"
                                                    ? "Shipped"
                                                    : orderDetailsController
                                                                .getOrderListModel
                                                                .value
                                                                .data
                                                                ?.chrStatus ==
                                                            "RC"
                                                        ? "Reached your City"
                                                        : orderDetailsController
                                                                    .getOrderListModel
                                                                    .value
                                                                    .data
                                                                    ?.chrStatus ==
                                                                "R"
                                                            ? "Rejected"
                                                            : orderDetailsController
                                                                        .getOrderListModel
                                                                        .value
                                                                        .data
                                                                        ?.chrStatus ==
                                                                    "S"
                                                                ? "Delivered"
                                                                : orderDetailsController
                                                                            .getOrderListModel
                                                                            .value
                                                                            .data
                                                                            ?.chrStatus ==
                                                                        "A"
                                                                    ? "Accepted"
                                                                    : orderDetailsController.getOrderListModel.value.data?.chrStatus ==
                                                                            "C"
                                                                        ? "Cancelled"
                                                                        : 'Not Defined',
                                        style: AppTextStyle.bodyLargeOrange
                                            .copyWith(
                                          color: orderDetailsController
                                                      .getOrderListModel
                                                      .value
                                                      .data
                                                      ?.chrStatus ==
                                                  "C"
                                              ? AppColors.redColor
                                              : orderDetailsController
                                                          .getOrderListModel
                                                          .value
                                                          .data
                                                          ?.chrStatus ==
                                                      "A"
                                                  ? AppColors.orangeColor
                                                  : orderDetailsController
                                                              .getOrderListModel
                                                              .value
                                                              .data
                                                              ?.chrStatus ==
                                                          "S"
                                                      ? AppColors.greenColor
                                                      : AppColors.blueColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  IntrinsicHeight(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        IntrinsicWidth(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 14,
                                                backgroundColor:
                                                    AppColors.greenColor,
                                                child: Icon(
                                                  Icons.done_outlined,
                                                  color: AppColors.whiteColor,
                                                ),
                                              ),
                                              const SizedBox(width: 14),
                                              Text(
                                                "Received",
                                                style:
                                                    AppTextStyle.bodyLargeW600,
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (orderDetailsController
                                                .getOrderListModel
                                                .value
                                                .data
                                                ?.chrStatus ==
                                            "C") ...[
                                          Container(
                                            height: 50,
                                            width: 2,
                                            margin:
                                                const EdgeInsets.only(left: 13),
                                            color: AppColors.redColor,
                                          ),
                                          IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      AppColors.redColor,
                                                  child: Icon(
                                                    Icons.close,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Text(
                                                  "Cancelled",
                                                  style: AppTextStyle
                                                      .bodyLargeW600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        if (orderDetailsController
                                                .getOrderListModel
                                                .value
                                                .data
                                                ?.chrStatus !=
                                            "C") ...[
                                          Container(
                                            height: 50,
                                            width: 2,
                                            margin:
                                                const EdgeInsets.only(left: 13),
                                            color: AppColors.greenColor,
                                          ),
                                          IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      orderDetailsController
                                                                  .getOrderListModel
                                                                  .value
                                                                  .data
                                                                  ?.chrStatus ==
                                                              "S"
                                                          ? AppColors.greenColor
                                                          : AppColors.gray,
                                                  child: Icon(
                                                    orderDetailsController
                                                                .getOrderListModel
                                                                .value
                                                                .data
                                                                ?.chrStatus ==
                                                            "S"
                                                        ? Icons.done_outlined
                                                        : Icons.close,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Text(
                                                  "Processed",
                                                  style: AppTextStyle
                                                      .bodyLargeW600,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 2,
                                            margin:
                                                const EdgeInsets.only(left: 13),
                                            color: orderDetailsController
                                                        .getOrderListModel
                                                        .value
                                                        .data
                                                        ?.chrStatus ==
                                                    "S"
                                                ? AppColors.greenColor
                                                : AppColors.gray,
                                          ),
                                          IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      orderDetailsController
                                                                  .getOrderListModel
                                                                  .value
                                                                  .data
                                                                  ?.chrStatus ==
                                                              "S"
                                                          ? AppColors.greenColor
                                                          : AppColors.gray,
                                                  child: Icon(
                                                    orderDetailsController
                                                                .getOrderListModel
                                                                .value
                                                                .data
                                                                ?.chrStatus ==
                                                            "S"
                                                        ? Icons.done_outlined
                                                        : Icons.close,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Text(
                                                  "Shipped",
                                                  style: AppTextStyle
                                                      .bodyLargeW600,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 50,
                                            width: 2,
                                            margin:
                                                const EdgeInsets.only(left: 13),
                                            color: orderDetailsController
                                                        .getOrderListModel
                                                        .value
                                                        .data
                                                        ?.chrStatus ==
                                                    "S"
                                                ? AppColors.greenColor
                                                : AppColors.gray,
                                          ),
                                          IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 14,
                                                  backgroundColor:
                                                      orderDetailsController
                                                                  .getOrderListModel
                                                                  .value
                                                                  .data
                                                                  ?.chrStatus ==
                                                              "S"
                                                          ? AppColors.greenColor
                                                          : AppColors.gray,
                                                  child: Icon(
                                                    orderDetailsController
                                                                .getOrderListModel
                                                                .value
                                                                .data
                                                                ?.chrStatus ==
                                                            "S"
                                                        ? Icons.done_outlined
                                                        : Icons.close,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 14),
                                                Text(
                                                  "Delivered",
                                                  style: AppTextStyle
                                                      .bodyLargeW600,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30.h),
                                  Text(
                                    "Contact Number",
                                    style: AppTextStyle.bodyLargeW600,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    orderDetailsController.getOrderListModel
                                            .value.data?.varAlternateMobile ??
                                        '',
                                    style: AppTextStyle.lableCategory12,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    orderDetailsController.getOrderListModel
                                            .value.data?.varAddressType ??
                                        '',
                                    style: AppTextStyle.bodyLargeW600,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    orderDetailsController.getOrderListModel
                                            .value.data?.varUserAddress ??
                                        '',
                                    style: AppTextStyle.bodyTextGray,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Payment Method",
                                    style: AppTextStyle.bodyLargeW600,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    orderDetailsController.getOrderListModel
                                            .value.data?.varPaymentMode ??
                                        '',
                                    style: AppTextStyle.bodyLargeW600
                                        .copyWith(color: AppColors.orangeColor),
                                  ),
                                ]),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Subtotal",
                                        style: AppTextStyle.lableLarge,
                                      ),
                                    ),
                                    Text(
                                      "${orderDetailsController.currentUserController.currency.value}${orderDetailsController.getOrderListModel.value.data?.varTotalAmount}",
                                      style: AppTextStyle.priceTextBlack,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Discount (-)",
                                        style: AppTextStyle.lableLarge,
                                      ),
                                    ),
                                    Text(
                                      "${orderDetailsController.currentUserController.currency.value}${orderDetailsController.getOrderListModel.value.data?.varDiscountAmount}",
                                      style: AppTextStyle.priceTextBlack,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Convince fee (+)",
                                        style: AppTextStyle.lableLarge,
                                      ),
                                    ),
                                    Text(
                                      "${orderDetailsController.currentUserController.currency.value}${orderDetailsController.getOrderListModel.value.data?.convienceFee}",
                                      style: AppTextStyle.priceTextBlack,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Delivery Charges (+)",
                                        style: AppTextStyle.lableLarge,
                                      ),
                                    ),
                                    Text(
                                      "${orderDetailsController.currentUserController.currency.value}${orderDetailsController.getOrderListModel.value.data?.varDeliveryCharge}",
                                      style: AppTextStyle.priceTextBlack,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "GST / TAX (+)",
                                        style: AppTextStyle.lableLarge,
                                      ),
                                    ),
                                    Text(
                                      "${orderDetailsController.currentUserController.currency.value}${orderDetailsController.getOrderListModel.value.data?.gstPrice}",
                                      style: AppTextStyle.priceTextBlack,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Payable Amount",
                                        style: AppTextStyle.bodyLargeOrange,
                                      ),
                                    ),
                                    Text(
                                      "${orderDetailsController.currentUserController.currency.value}${orderDetailsController.getOrderListModel.value.data?.varPayableAmount}",
                                      style: AppTextStyle.bodyLargeOrange,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                /*     Visibility(
                                 */ /* visible: orderDetailsController
                                      .getOrderListModel
                                      .value
                                      .data
                                      ?.chrStatus ==
                                      "S",*/ /*
                                  child: ButtonOutlineWidget(
                                    title: "GIVE A REVIEW",
                                    onTap: () {
                                      Get.toNamed(AppRoutes.giveMeReview, arguments:orderDetailsController
                                          .getOrderListModel
                                          .value
                                          .data
                                          ?.fkProductArr?[index]);
                                    },
                                  ),
                                ),*/
                                SizedBox(
                                  height: 14.h,
                                ),
                                Visibility(
                                  visible: orderDetailsController
                                              .getOrderListModel
                                              .value
                                              .data
                                              ?.chrStatus ==
                                          "P" ||
                                      orderDetailsController.getOrderListModel
                                              .value.data?.chrStatus ==
                                          "W" ||
                                      orderDetailsController.getOrderListModel
                                              .value.data?.chrStatus ==
                                          "SH" ||
                                      orderDetailsController.getOrderListModel
                                              .value.data?.chrStatus ==
                                          "RC" ||
                                      orderDetailsController.getOrderListModel
                                              .value.data?.chrStatus ==
                                          "A",
                                  child: ButtonOutlineWidget(
                                    title: "CANCEL ORDER",
                                    onTap: () => Get.defaultDialog(
                                      title: 'Cancel Order',
                                      titleStyle: AppTextStyle.titleLarge,
                                      backgroundColor: AppColors.whiteColor,
                                      content: Column(
                                        children: [
                                          Text(
                                            'Are you sure you want to Cancel Order?',
                                            style: AppTextStyle.bodyLarge,
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ButtonOutlineWidget(
                                                width: 60,
                                                title: "No",
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                onTap: () => Get.back(),
                                              ),
                                              ButtonWidget(
                                                width: 60,
                                                title: "Yes",
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                onTap: () => {
                                                  Get.back(closeOverlays: true),
                                                  orderDetailsController
                                                      .cancelOrderAPI()
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
