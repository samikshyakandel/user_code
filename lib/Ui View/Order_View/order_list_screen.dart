import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:new_user_singlevendor/Ui%20View/Order_View/Model/get_order_list_model.dart';
import 'package:new_user_singlevendor/Utils/app_textstyle.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Utils/app_colors.dart';
import '../../Utils/Routes/app_routes.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/drawer_menu.dart';
import '../App_Widgets/empty_widget.dart';
import 'OrderList_Controller/get_order_list_controller.dart';

class OrderListView extends StatefulWidget {
  const OrderListView({super.key});

  @override
  State<OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<OrderListView> {
  final GetOrderListController getOrderListController =
      Get.put(GetOrderListController());

  @override
  void initState() {
    getOrderListController.getOrderListAPI(isLoadingShow: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        drawer: DrawerMenu(),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarWidget(title: 'Order', isDrawer: true),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async => getOrderListController.getOrderListAPI(
                      isLoadingShow: false),
                  color: AppColors.orangeColor,
                  child: Obx(
                    () => Skeletonizer(
                      enabled: getOrderListController.isLoading.value,
                      child: getOrderListController
                                  .getOrderListModel.value.data?.isEmpty ??
                              true
                          ? const EmptyWidget()
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) =>
                                  Divider(color: AppColors.greyColor),
                              itemCount: getOrderListController
                                      .getOrderListModel.value.data?.length ??
                                  0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var orderData = getOrderListController
                                    .getOrderListModel.value.data?[index];
                                return orderItemWidget(index, orderData);
                              }),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget orderItemWidget(int index, OrderData? orderData) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.orderDetails, arguments: orderData),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5, top: 5, right: 10, left: 10),
        child: IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                child: Container(
                  width: 5,
                  decoration: BoxDecoration(
                    color: orderData?.chrStatus == "C"
                        ? AppColors.redColor
                        : orderData?.chrStatus == "A"
                            ? AppColors.orangeColor
                            : orderData?.chrStatus == "S"
                                ? AppColors.greenColor
                                : AppColors.blueColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    border:
                        Border.all(color: AppColors.lightGrayColor, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      orderData?.orderId ?? '',
                                      style:
                                          AppTextStyle.lableLargeBlue.copyWith(
                                        color: orderData?.chrStatus == "C"
                                            ? AppColors.redColor
                                            : orderData?.chrStatus == "A"
                                                ? AppColors.orangeColor
                                                : orderData?.chrStatus == "S"
                                                    ? AppColors.greenColor
                                                    : AppColors.blueColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(7, 3, 7, 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border.all(
                                            color: orderData?.chrStatus == "C"
                                                ? AppColors.redColor
                                                : orderData?.chrStatus == "A"
                                                    ? AppColors.orangeColor
                                                    : orderData?.chrStatus ==
                                                            "S"
                                                        ? AppColors.greenColor
                                                        : AppColors.blueColor,
                                            width: 1),
                                        color: AppColors.lightBlueColor),
                                    child: Text(
                                      orderData?.chrStatusText ?? '',
                                      style: AppTextStyle.orderStatusButtonText
                                          .copyWith(
                                        color: orderData?.chrStatus == "C"
                                            ? AppColors.redColor
                                            : orderData?.chrStatus == "A"
                                                ? AppColors.orangeColor
                                                : orderData?.chrStatus == "S"
                                                    ? AppColors.greenColor
                                                    : AppColors.blueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: Row(
                                children: [
                                  if (orderData?.dtCreateddate != null)
                                    Expanded(
                                      child: Text(
                                          Jiffy.parseFromDateTime(
                                            DateTime.parse(
                                                orderData?.dtCreateddate ?? ''),
                                          ).format(pattern: 'd MMM, yyyy'),
                                          style: AppTextStyle.lableLarge),
                                    ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0.0, 10, 0.0),
                                          child: SizedBox(
                                            height: 14,
                                            width: 1,
                                            child: Container(
                                              color: AppColors.lightGrayColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 5),
                                          child: Text(
                                              orderData?.totalProducts
                                                      .toString() ??
                                                  '',
                                              style:
                                                  AppTextStyle.qtyTextPurple),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0.0, 10, 0),
                                          child: SizedBox(
                                            height: 14,
                                            width: 2,
                                            child: Container(
                                                color:
                                                    AppColors.lightGrayColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      orderData?.varPayableAmount != null
                                          ? "${getOrderListController.currentUserController.currency.value}${orderData?.varPayableAmount}"
                                          : '',
                                      style:
                                          AppTextStyle.lableLargeBlue.copyWith(
                                        color: orderData?.chrStatus == "C"
                                            ? AppColors.redColor
                                            : orderData?.chrStatus == "A"
                                                ? AppColors.orangeColor
                                                : orderData?.chrStatus == "S"
                                                    ? AppColors.greenColor
                                                    : AppColors.blueColor,
                                      ),
                                    ),
                                  ),
                                ],
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
      ),
    );
  }
}
