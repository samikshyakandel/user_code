import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Address_Screen/adress_list.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/textfield_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_widget.dart';
import '../Home_View/Model/product_model.dart';
import 'checkout_controller.dart';
import 'promocode_model.dart';

class CheckoutView extends StatelessWidget {
  CheckoutView({super.key});

  final CheckoutController checkoutController = Get.put(CheckoutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidget(title: "Checkout", isSearch: false, isCart: false),
            // const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(
                    () => Skeletonizer(
                      enabled:
                          checkoutController.cartController.isLoading.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Purchase Item",
                            style: AppTextStyle.bodyLargeW600,
                          ),
                          const SizedBox(height: 6),
                          ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Divider(color: AppColors.greyColor),
                            ),
                            itemCount: checkoutController.cartController
                                    .cartListModel.value.productData?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) {
                              var productData = checkoutController
                                  .cartController
                                  .cartListModel
                                  .value
                                  .productData?[index];
                              return cartCardWidget(productData);
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Delivery",
                                  style: AppTextStyle.bodyLargeW600,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Get.bottomSheet(AddressListView(),
                                      isScrollControlled: true,
                                      ignoreSafeArea: false);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.greyColor)),
                                  child: Text("Change Address",
                                      style: AppTextStyle.lableLarge),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (checkoutController.selectAddress.value.chrType !=
                              null) ...[
                            Text(
                              checkoutController.selectAddress.value.chrType ??
                                  '',
                              style: AppTextStyle.bodyLargeW600,
                            ),
                            Text(
                              "${checkoutController.selectAddress.value.varHouseNo}, "
                              "${checkoutController.selectAddress.value.varAppName}, "
                              "${checkoutController.selectAddress.value.varLandmark}, "
                              "${checkoutController.selectAddress.value.varCity}, "
                              "${checkoutController.selectAddress.value.varState}, "
                              "${checkoutController.selectAddress.value.varCountry}, "
                              "${checkoutController.selectAddress.value.varPincode}",
                              style: AppTextStyle.bodyTextGray,
                            ),
                          ],
                          const SizedBox(height: 20),
                          Text(
                            "Payment Method",
                            style: AppTextStyle.bodyLargeW600,
                          ),
                          const SizedBox(height: 10),
                          TextFieldWidget(
                            controller: checkoutController.promocodeCont,
                            hintText: "456DFGV63154D",
                            borderColor: AppColors.orangeColor,
                            onChanged: (val) {
                              if (val.isEmpty) {
                                checkoutController.promocodeModel.value =
                                    PromocodeModel();
                                checkoutController.cartController
                                    .cartListApi(isLoadingShow: false);
                              }
                            },
                            suffixIcon: InkWell(
                              onTap: () {
                                // Get.bottomSheet(const ApplyCouponView(),
                                //     isScrollControlled: true,
                                //     ignoreSafeArea: false);
                                if (checkoutController
                                    .promocodeCont.text.isNotEmpty) {
                                  checkoutController.promocodeApi();
                                } else {
                                  checkoutController.promocodeModel.value =
                                      PromocodeModel();
                                  AppConstant()
                                      .snackbars("Error", "Enter Promocode");
                                  checkoutController.cartController
                                      .cartListApi(isLoadingShow: false);
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 140.w,
                                decoration: BoxDecoration(
                                  color: AppColors.orangeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "APPLY COUPON",
                                  style: AppTextStyle.bodyLargeDarkGray16
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => Text(
                              checkoutController.promocodeModel.value.message ??
                                  '',
                              style: AppTextStyle.bodyLargeDarkGray
                                  .copyWith(color: AppColors.orangeColor),
                            ),
                          ),
                          const SizedBox(height: 20),
                          totalWidget(
                            title: "Subtotal",
                            price:
                                "${checkoutController.currentUserController.currency.value}${checkoutController.cartController.cartListModel.value.subTotal}",
                          ),
                          const SizedBox(height: 6),
                          Obx(
                            () => totalWidget(
                              title: "Discount (-)",
                              price:
                                  "${checkoutController.currentUserController.currency.value}${checkoutController.cartController.cartListModel.value.discountTotal?.value ?? 0.00}",
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(
                            () => totalWidget(
                              title: "Discount Coupon (-)",
                              price:
                                  "${checkoutController.currentUserController.currency.value}${double.parse(checkoutController.promocodeModel.value.discountPrice != 'null' ? checkoutController.promocodeModel.value.discountPrice ?? "0.00" : "0.00").toStringAsFixed(2)}",
                              // "${checkoutController.currentUserController.currency.value}${double.parse(checkoutController.promocodeModel.value.discountPrice ?? "0.00").toStringAsFixed(2)}",
                            ),
                          ),
                          const SizedBox(height: 6),
                          totalWidget(
                              title: "Delivery Charges (+)",
                              price:
                                  "${checkoutController.currentUserController.currency.value}0.00"),
                          const SizedBox(height: 6),
                          totalWidget(
                            title: "GST / TAX (+)",
                            price:
                                "${checkoutController.currentUserController.currency.value}${checkoutController.cartController.cartListModel.value.gstTotal}",
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => totalWidget(
                                title: "Payable Amount",
                                price:
                                    "${checkoutController.currentUserController.currency.value}${checkoutController.cartController.cartListModel.value.grossTotal?.value ?? 0.00}",
                                textColor: AppColors.orangeColor),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity),
                                  activeColor: AppColors.greenColor,
                                  value: checkoutController.paymentOption[0],
                                  onChanged: (bool? value) {
                                    if (value!) {
                                      checkoutController.paymentOption[0] =
                                          value;
                                      if (checkoutController.paymentOption[0] ==
                                          true) {
                                        checkoutController.paymentOption[1] =
                                            false;
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Online Payment",
                                style: AppTextStyle.bodyLargeW600,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Obx(
                                () => Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(
                                      horizontal: VisualDensity.minimumDensity,
                                      vertical: VisualDensity.minimumDensity),
                                  activeColor: AppColors.greenColor,
                                  value: checkoutController.paymentOption[1],
                                  onChanged: (bool? value) {
                                    if (value!) {
                                      checkoutController.paymentOption[1] =
                                          value;
                                      if (checkoutController.paymentOption[1] ==
                                          true) {
                                        checkoutController.paymentOption[0] =
                                            false;
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Cash on Delivery",
                                style: AppTextStyle.bodyLargeW600,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        child: Visibility(
          visible: !checkoutController.isLoading.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10)),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                          horizontal: VisualDensity.minimumDensity,
                          vertical: VisualDensity.minimumDensity),
                      activeColor: AppColors.greenColor,

                      value: checkoutController.isPrivacy.value,
                      onChanged: (bool? value) {
                        checkoutController.isPrivacy.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          "I have read and accept the",
                          style: AppTextStyle.bodyTextGray,
                        ),
                        const SizedBox(width: 5),
                        Text("Terms & Conditions",
                            style: AppTextStyle.bodyTextGray.copyWith(
                              color: AppColors.blueColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.blueColor,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              ButtonWidget(
                title: "PLACE ORDER",
                onTap: () => {
                  if (checkoutController.selectAddress.value.chrType != null)
                    {
                      if (checkoutController.isPrivacy.value)
                        {
                          checkoutController.placeOrderApi(),
                        }
                      else
                        {
                          AppConstant()
                              .snackbars("Error", "Select Terms & Conditions"),
                        }
                    }
                  else
                    {
                      AppConstant().snackbars("Error", "Select Address"),
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row totalWidget(
      {required String title, required String price, Color? textColor}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.lableLarge.copyWith(color: textColor),
          ),
        ),
        Text(
          price,
          style: AppTextStyle.priceTextBlack.copyWith(color: textColor),
        ),
      ],
    );
  }

  Widget cartCardWidget(ProductsModel? productData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6,
              surfaceTintColor: AppColors.whiteColor,
              shadowColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: productData?.varImage?.isNotEmpty ?? false
                    ? Image.network(
                        productData!.varImage!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Skeletonizer(
                            enabled: true,
                            child: Image.asset(
                              AppImages.icProductImg,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      )
                    : SizedBox(
                        height: 100,
                        width: 100,
                        child: Icon(
                          Icons.image,
                          color: AppColors.gray,
                          size: 40,
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(productData?.varTitle ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.lableLarge),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${checkoutController.currentUserController.currency.value}${productData?.variantDetails?.sellingPrice ?? ''}",
                          style: AppTextStyle.bodyLargeGreen,
                        ),
                      ),
                      Text(
                          " x ${productData?.cartItem?.value.toString() ?? '0'}",
                          style: AppTextStyle.lableLarge)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        // const SizedBox(height: 20),
        // SizedBox(
        //   height: 1,
        //   child: Container(color: AppColors.greyColor),
        // ),
      ],
    );
  }
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
