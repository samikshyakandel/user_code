import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_outline_widget.dart';
import 'filter_controller.dart';

class ProductFilterView extends StatefulWidget {
  const ProductFilterView({super.key});

  @override
  State<ProductFilterView> createState() => _ProductFilterViewState();
}

class _ProductFilterViewState extends State<ProductFilterView> {
  final FilterController filterController = Get.put(FilterController());

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 650.h,
      color: AppColors.whiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppbarWidget(
            title: 'Filter',
            isCart: false,
            isSearch: false,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => RadioListTile<String>(
                        title: Text(
                          'Recent',
                          style: AppTextStyle.priceTextBlack,
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: "latest",
                        groupValue: filterController
                            .subCategoryController.selectSortBy.value,
                        activeColor: AppColors.orangeColor,
                        visualDensity: const VisualDensity(
                            vertical: VisualDensity.minimumDensity,
                            horizontal: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) => filterController
                            .subCategoryController.selectSortBy.value = value!,
                      ),
                    ),
                    Obx(
                      () => RadioListTile<String>(
                        title: Text(
                          'Popular',
                          style: AppTextStyle.priceTextBlack,
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: "popular",
                        groupValue: filterController
                            .subCategoryController.selectSortBy.value,
                        activeColor: AppColors.orangeColor,
                        visualDensity: const VisualDensity(
                            vertical: VisualDensity.minimumDensity,
                            horizontal: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) => filterController
                            .subCategoryController.selectSortBy.value = value!,
                      ),
                    ),
                    Obx(
                      () => RadioListTile<String>(
                        title: Text(
                          'Price Low to High',
                          style: AppTextStyle.priceTextBlack,
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: const VisualDensity(
                            vertical: VisualDensity.minimumDensity,
                            horizontal: VisualDensity.minimumDensity),
                        value: "low",
                        groupValue: filterController
                            .subCategoryController.selectSortBy.value,
                        activeColor: AppColors.orangeColor,
                        onChanged: (value) => filterController
                            .subCategoryController.selectSortBy.value = value!,
                      ),
                    ),
                    Obx(
                      () => RadioListTile<String>(
                        title: Text(
                          'Price High to Low',
                          style: AppTextStyle.priceTextBlack,
                        ),
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        value: "high",
                        visualDensity: const VisualDensity(
                            vertical: VisualDensity.minimumDensity,
                            horizontal: VisualDensity.minimumDensity),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        groupValue: filterController
                            .subCategoryController.selectSortBy.value,
                        activeColor: AppColors.orangeColor,
                        onChanged: (value) => filterController
                            .subCategoryController.selectSortBy.value = value!,
                      ),
                    ),
                    const SizedBox(height: 6),
                    priceListWidget(),
                    const SizedBox(height: 8),
                    filterListWidget(),
                    const SizedBox(height: 6),
                    // productListWidget(),
                    // const SizedBox(height: 6),
                    // typeListWidget(),
                    // const SizedBox(height: 6),
                    // styleListWidget(),
                    // const SizedBox(height: 6),
                    // sizeListWidget(),
                    // const SizedBox(height: 6),
                    // qualityListWidget(),
                    // const SizedBox(height: 6),
                    // ratingsListWidget(),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonOutlineWidget(
              title: "APPLY",
              onTap: () => {
                Get.back(),
                filterController.subCategoryController
                    .subCategoryApi(isLoadingShow: false),
              },
            ),
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget filterListWidget() {
    return Obx(
      () => Skeletonizer(
        enabled: filterController.isLoading.value,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                filterController.filterAttributeModel.value.data?.length ?? 0,
            itemBuilder: (context, ind) {
              var filterData =
                  filterController.filterAttributeModel.value.data?[ind];
              return Container(
                color: AppColors.greyLightColor,
                margin: const EdgeInsets.symmetric(vertical: 2),
                child: ExpansionTile(
                  dense: true,
                  iconColor: AppColors.gray,
                  collapsedIconColor: AppColors.gray,
                  title: Text(
                    filterData?.title ?? '',
                    style: AppTextStyle.bodyLargeW600,
                  ),
                  children: List.generate(
                    filterData?.attributeList?.length ?? 0,
                    (index) {
                      var attributeData = filterData?.attributeList?[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 2),
                        child: Row(
                          children: [
                            // Checkbox(
                            //     activeColor: AppColors.orangeColor,
                            //     value: false,
                            //     onChanged: (val) => filterController
                            //         .categoryList[index].isSelect.value = val!
                            //         ),
                            InkWell(
                              onTap: () => filterController
                                      .subCategoryController.selectFilterList
                                      .contains(attributeData?.id ?? '')
                                  ? filterController
                                      .subCategoryController.selectFilterList
                                      .remove(attributeData?.id ?? '')
                                  : filterController
                                      .subCategoryController.selectFilterList
                                      .addAll([attributeData?.id ?? '']),
                              child: Obx(
                                () => Icon(
                                    filterController.subCategoryController
                                            .selectFilterList
                                            .contains(attributeData?.id ?? '')
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    color: filterController
                                            .subCategoryController
                                            .selectFilterList
                                            .contains(attributeData?.id ?? '')
                                        ? AppColors.orangeColor
                                        : AppColors.blackColor),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                attributeData?.value ?? '',
                                style: AppTextStyle.priceTextBlack,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget priceListWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            'BY PRICE',
            style: AppTextStyle.bodyLargeW600,
          ),
        ),
        Obx(
          () => RangeSlider(
            activeColor: AppColors.orangeColor,
            values:
                filterController.subCategoryController.selectPriceRange.value,
            min: 0,
            max: 999999,
            divisions: 50,
            labels: RangeLabels(
              filterController
                  .subCategoryController.selectPriceRange.value.start
                  .round()
                  .toString(),
              filterController.subCategoryController.selectPriceRange.value.end
                  .round()
                  .toString(),
            ),
            onChanged: (RangeValues values) {
              // setState(() {
              filterController.subCategoryController.selectPriceRange.value =
                  values;
              // });
            },
          ),
        ),
        Center(
          child: Obx(
            () => Text(
              'Price Range: ${filterController.subCategoryController.selectPriceRange.value.start.round()} - ${filterController.subCategoryController.selectPriceRange.value.end.round()}',
              style: AppTextStyle.priceTextBlack,
            ),
          ),
        ),
      ],
    );
  }

  // Widget productListWidget() {
  //   return Obx(
  //     () => Container(
  //       color: AppColors.greyLightColor,
  //       child: ExpansionTile(
  //         dense: true,
  //         iconColor: AppColors.gray,
  //         collapsedIconColor: AppColors.gray,
  //         title: Text(
  //           'BRANDS',
  //           style: AppTextStyle.bodyLargeW600,
  //         ),
  //         children: List.generate(
  //           filterController.brandList.length,
  //           (index) => Row(
  //             children: [
  //               Checkbox(
  //                   activeColor: AppColors.orangeColor,
  //                   value: filterController.brandList[index].isSelect.value,
  //                   onChanged: (val) => filterController
  //                       .brandList[index].isSelect.value = val!),
  //               Expanded(
  //                 child: Text(
  //                   filterController.brandList[index].title,
  //                   style: AppTextStyle.priceTextBlack,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget typeListWidget() {
  //   return Obx(
  //     () => Container(
  //       color: AppColors.greyLightColor,
  //       child: ExpansionTile(
  //         dense: true,
  //         iconColor: AppColors.gray,
  //         collapsedIconColor: AppColors.gray,
  //         title: Text(
  //           'BY TYPE',
  //           style: AppTextStyle.bodyLargeW600,
  //         ),
  //         children: List.generate(
  //           filterController.typeList.length,
  //           (index) => Row(
  //             children: [
  //               Checkbox(
  //                   activeColor: AppColors.orangeColor,
  //                   value: filterController.typeList[index].isSelect.value,
  //                   onChanged: (val) =>
  //                       filterController.typeList[index].isSelect.value = val!),
  //               Expanded(
  //                 child: Text(
  //                   filterController.typeList[index].title,
  //                   style: AppTextStyle.priceTextBlack,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget styleListWidget() {
  //   return Obx(
  //     () => Container(
  //       color: AppColors.greyLightColor,
  //       child: ExpansionTile(
  //         dense: true,
  //         iconColor: AppColors.gray,
  //         collapsedIconColor: AppColors.gray,
  //         title: Text(
  //           'BY Style',
  //           style: AppTextStyle.bodyLargeW600,
  //         ),
  //         children: List.generate(
  //           filterController.styleList.length,
  //           (index) => Row(
  //             children: [
  //               Checkbox(
  //                   activeColor: AppColors.orangeColor,
  //                   value: filterController.styleList[index].isSelect.value,
  //                   onChanged: (val) => filterController
  //                       .styleList[index].isSelect.value = val!),
  //               Expanded(
  //                 child: Text(
  //                   filterController.styleList[index].title,
  //                   style: AppTextStyle.priceTextBlack,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget sizeListWidget() {
  //   return Obx(
  //     () => Container(
  //       color: AppColors.greyLightColor,
  //       child: ExpansionTile(
  //         dense: true,
  //         iconColor: AppColors.gray,
  //         collapsedIconColor: AppColors.gray,
  //         title: Text(
  //           'BY Size',
  //           style: AppTextStyle.bodyLargeW600,
  //         ),
  //         children: List.generate(
  //           filterController.sizeList.length,
  //           (index) => Row(
  //             children: [
  //               Checkbox(
  //                   activeColor: AppColors.orangeColor,
  //                   value: filterController.sizeList[index].isSelect.value,
  //                   onChanged: (val) =>
  //                       filterController.sizeList[index].isSelect.value = val!),
  //               Expanded(
  //                 child: Text(
  //                   filterController.sizeList[index].title,
  //                   style: AppTextStyle.priceTextBlack,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget qualityListWidget() {
  //   return Obx(
  //     () => Container(
  //       color: AppColors.greyLightColor,
  //       child: ExpansionTile(
  //         dense: true,
  //         iconColor: AppColors.gray,
  //         collapsedIconColor: AppColors.gray,
  //         title: Text(
  //           'BY Quality',
  //           style: AppTextStyle.bodyLargeW600,
  //         ),
  //         children: List.generate(
  //           filterController.qualityList.length,
  //           (index) => Row(
  //             children: [
  //               Checkbox(
  //                   activeColor: AppColors.orangeColor,
  //                   value: filterController.qualityList[index].isSelect.value,
  //                   onChanged: (val) => filterController
  //                       .qualityList[index].isSelect.value = val!),
  //               Expanded(
  //                 child: Text(
  //                   filterController.qualityList[index].title,
  //                   style: AppTextStyle.priceTextBlack,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget ratingsListWidget() {
  //   return Obx(
  //     () => Container(
  //       color: AppColors.greyLightColor,
  //       child: ExpansionTile(
  //         dense: true,
  //         iconColor: AppColors.gray,
  //         collapsedIconColor: AppColors.gray,
  //         title: Text(
  //           'BY Ratings',
  //           style: AppTextStyle.bodyLargeW600,
  //         ),
  //         children: List.generate(
  //           filterController.ratingsList.length,
  //           (index) => Row(
  //             children: [
  //               Checkbox(
  //                   activeColor: AppColors.orangeColor,
  //                   value: filterController.ratingsList[index].isSelect.value,
  //                   onChanged: (val) => filterController
  //                       .ratingsList[index].isSelect.value = val!),
  //               Expanded(
  //                 child: Text(
  //                   filterController.ratingsList[index].title,
  //                   style: AppTextStyle.priceTextBlack,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
