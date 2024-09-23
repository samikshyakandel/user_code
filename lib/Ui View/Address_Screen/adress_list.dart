import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:new_user_singlevendor/Ui%20View/App_Widgets/appbar_widget.dart';
import 'package:new_user_singlevendor/Utils/Routes/app_routes.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/empty_widget.dart';
import '../Checkout_View/checkout_controller.dart';
import 'Address_Controller/get_address_list_controller.dart';

class AddressListView extends StatelessWidget {
  AddressListView({super.key});

  final GetAddressListController getAddressListController =
      Get.put(GetAddressListController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidget(
              title: "My Address",
              isAddAddress: true,
              isCart: false,
              isSearch: false,
            ),
            Expanded(
              child: Obx(
                () => Skeletonizer(
                  enabled: getAddressListController.isLoading.value,
                  child: getAddressListController
                              .getAddressModel.value.data?.isEmpty ??
                          true
                      ? const EmptyWidget()
                      : ListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 6.h),
                          separatorBuilder: (context, index) =>
                              Divider(color: AppColors.greyColor),
                          itemCount: getAddressListController
                                  .getAddressModel.value.data?.length ??
                              0,
                          itemBuilder: (BuildContext context, int index) {
                            var addressData = getAddressListController
                                .getAddressModel.value.data?[index];
                            return GestureDetector(
                              onTap: () {
                                if (Get.isBottomSheetOpen!) {
                                  final CheckoutController checkoutController =
                                      Get.put(CheckoutController());
                                  checkoutController.selectAddress.value =
                                      addressData!;
                                  Get.back();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(addressData?.chrType ?? '',
                                            style: AppTextStyle.lableLarge),
                                      ),
                                      if (!getAddressListController
                                          .isLoading.value) ...[
                                        InkWell(
                                          onTap: () => Get.toNamed(
                                              AppRoutes.addAddress,
                                              arguments: addressData),
                                          child: SvgPicture.asset(
                                              AppImages.icEdit),
                                        ),
                                        const SizedBox(width: 10),
                                        InkWell(
                                          onTap: () => getAddressListController
                                              .deleteAdderssAPI(
                                                  addressData?.intGlcode),
                                          child: SvgPicture.asset(
                                            AppImages.icDelete,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${addressData?.varHouseNo}, "
                                    "${addressData?.varAppName}, "
                                    "${addressData?.varLandmark}, "
                                    "${addressData?.varCity}, "
                                    "${addressData?.varState}, "
                                    "${addressData?.varCountry}, "
                                    "${addressData?.varPincode}",
                                    style: AppTextStyle.bodyTextGray,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
