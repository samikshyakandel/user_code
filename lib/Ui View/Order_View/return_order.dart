import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_widget.dart';
import '../App_Widgets/textfield_widget.dart';
import 'OrderList_Controller/return_order_controller.dart';

class ReturnOrderView extends StatelessWidget {
  ReturnOrderView({super.key});

  final ReturnOrderController returnOrderController =
      Get.put(ReturnOrderController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarWidget(title: 'Return Order', isSearch: false),
              Expanded(
                  child: SingleChildScrollView(
                child: Obx(
                  () => AbsorbPointer(
                    absorbing: returnOrderController.isLoading.value,
                    child: Form(
                      key: returnOrderController.returnOrderFormGlobalKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.h),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Card(
                                        elevation: 8,
                                        surfaceTintColor: AppColors.whiteColor,
                                        shadowColor: AppColors.whiteColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: returnOrderController
                                                        .fkProductArrArg
                                                        .varImage
                                                        ?.isEmpty ??
                                                    true
                                                ? Icon(
                                                    Icons.image,
                                                    color: AppColors.gray,
                                                    size: 40,
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      returnOrderController
                                                              .fkProductArrArg
                                                              .varImage ??
                                                          '',
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                            // Image.asset(AppImages.icProductImg)),
                                            ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                returnOrderController
                                                        .fkProductArrArg
                                                        .varName ??
                                                    '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle.lableLarge),
                                            SizedBox(
                                              height: 5.h,
                                            ),
                                            Row(
                                              children: [
                                                Text("Order No. :",
                                                    style: AppTextStyle
                                                        .bodyTextGray),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                    returnOrderController
                                                        .orderIdArg,
                                                    style: AppTextStyle
                                                        .bodyTextGray),
                                              ],
                                            ),
                                            SizedBox(height: 5.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "${returnOrderController.currentUserController.currency.value}${returnOrderController.fkProductArrArg.netPrice}",
                                                  style: AppTextStyle
                                                      .bodyLargeGreen,
                                                ),
                                                Text(
                                                    " x ${returnOrderController.fkProductArrArg.varQut}",
                                                    style:
                                                        AppTextStyle.lableLarge)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
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
                                        onTap: () => {
                                          if (1 <
                                              returnOrderController
                                                  .selectQty.value)
                                            {
                                              returnOrderController
                                                  .selectQty.value--,
                                            }
                                        },
                                      ),
                                      Obx(
                                        () => qtyWidget(
                                          title: returnOrderController.selectQty
                                              .toString(),
                                        ),
                                      ),
                                      qtyWidget(
                                        title: '+',
                                        onTap: () => {
                                          if (returnOrderController
                                                  .fkProductArrArg.varQut! >
                                              returnOrderController
                                                  .selectQty.value)
                                            {
                                              returnOrderController
                                                  .selectQty.value++,
                                            }
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TextFieldWidget(
                                      controller:
                                          returnOrderController.reasonTextCount,
                                      headerText: "Return Reason",
                                      hintText: "Enter Return Reason",
                                      minLines: 3,
                                      maxLines: 4,
                                      // validator: (nameValue) {
                                      //   if (nameValue!.isEmpty) {
                                      //     return "Enter Review";
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                  SizedBox(height: 100.h),
                                ],
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.all(20.h),
                child: ButtonWidget(
                  title: "SUBMIT",
                  onTap: () {
                    if (returnOrderController
                        .returnOrderFormGlobalKey.currentState!
                        .validate()) {
                      returnOrderController.orderReturnApi(
                          returnOrderController.fkProductArrArg.fkProduct,
                          returnOrderController.fkProductArrArg.fkVariant,
                          returnOrderController.orderIntGlCodeArg);
                    }
                  },
                ),
              ),
            ],
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
}
