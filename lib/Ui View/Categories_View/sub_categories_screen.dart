import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Categories_View/Controller/sub_category_controller.dart';
import 'package:new_user_singlevendor/Utils/app_textstyle.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_constant.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/categories_widget.dart';
import '../App_Widgets/empty_widget.dart';
import '../App_Widgets/loading_widget.dart';
import '../App_Widgets/product_widget.dart';
import '../Product_Filter/filter_controller.dart';
import '../Product_Filter/filter_view.dart';
import 'Model/category_model.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({super.key});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  final CategoryModel categoryArg = Get.arguments as CategoryModel;

  @override
  void initState() {
    subCategoryController.subCategoryApi(isLoadingShow: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidget(
              title: subCategoryController.selectCategory.value.varTitle ?? "",
              isFilter: true,
              onTapFilter: () => showModalBottomSheet(
                isScrollControlled: true,
                constraints: BoxConstraints.loose(Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height * 0.77)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13)),
                backgroundColor: Colors.white,
                context: context,
                builder: (context) => const ProductFilterView(),
              ).then(
                (value) => Get.delete<FilterController>(),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 14, bottom: 6),
              child: Obx(
                () => Skeletonizer(
                  enabled: subCategoryController.isLoading.value,
                  child: Row(
                    children: [
                      Obx(
                        () => Visibility(
                          visible: subCategoryController.subCategoryModel.value
                                  .data?.productList?.isNotEmpty ??
                              false,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: CategoryWidget(
                              isSelected: categoryArg.intGlcode ==
                                      subCategoryController
                                          .selectCategory.value.intGlcode
                                  ? true
                                  : false,
                              size: 50,
                              name: categoryArg.varTitle ?? "",
                              imagePath: categoryArg.varIcon ?? "",
                              onTap: () => {
                                subCategoryController.selectCategory.value =
                                    categoryArg,
                                subCategoryController.subCategoryApi(
                                    isLoadingShow: false),
                              },
                            ),
                          ),
                        ),
                      ),
                      ...List.generate(
                        subCategoryController.subCategoryModel.value.data
                                ?.subCategory?.length ??
                            0,
                        (ind) {
                          var categoryData = subCategoryController
                              .subCategoryModel.value.data?.subCategory?[ind];
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: CategoryWidget(
                              isSelected: categoryData?.intGlcode ==
                                      subCategoryController
                                          .selectCategory.value.intGlcode
                                  ? true
                                  : false,
                              size: 50,
                              name: categoryData?.varTitle,
                              imagePath: categoryData?.varIcon,
                              onTap: () => {
                                subCategoryController.selectCategory.value =
                                    categoryData!,
                                subCategoryController.subCategoryApi(
                                    isLoadingShow: false),
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => subCategoryController.selectProducts.isEmpty &&
                        !subCategoryController.isLoading.value
                    ? const EmptyWidget()
                    : SingleChildScrollView(
                        controller: subCategoryController.controller,
                        child: Column(
                          children: [
                            Obx(
                              () => Skeletonizer(
                                enabled:
                                    subCategoryController.isSelectLoading.value,
                                child: ResponsiveGridList(
                                  listViewBuilderOptions: ListViewBuilderOptions(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics()),
                                  minItemWidth: 150,
                                  minItemsPerRow: 2,
                                  maxItemsPerRow: 5,
                                  horizontalGridMargin: 8,
                                  horizontalGridSpacing: 2,
                                  children: List.generate(
                                    subCategoryController.selectProducts.length,
                                    (index) {
                                      var hotProductData = subCategoryController
                                          .selectProducts[index];
                                      return ProductWidget(
                                        fkProduct:
                                            hotProductData.intGlcode ?? '',
                                        imagePath: hotProductData.varImage,
                                        name: hotProductData.varTitle,
                                        varPrice: hotProductData
                                            .variantDetails?.varPrice,
                                        sellingPrice: hotProductData
                                            .variantDetails?.sellingPrice,
                                        isFavorite: hotProductData.like?.value,
                                        onTapFavorite: () => {
                                          if (hotProductData.like?.value == "Y")
                                            {
                                              hotProductData.like?.value = "N",
                                            }
                                          else
                                            {
                                              hotProductData.like?.value = "Y",
                                            },
                                          subCategoryController
                                              .currentUserController
                                              .favoriteAddRemoveApi(
                                                  fkProduct: hotProductData
                                                          .intGlcode ??
                                                      '')
                                        },
                                        offer: int.parse(
                                            hotProductData.varOffer ?? '0'),
                                        cartItem:
                                            hotProductData.cartItem?.value ?? 0,
                                        onTapIncrement: () => {
                                          if (hotProductData.cartItem!.value <
                                              int.parse(hotProductData
                                                      .variantDetails
                                                      ?.varStock ??
                                                  '0'))
                                            {
                                              hotProductData.cartItem?.value++,
                                              subCategoryController
                                                  .currentUserController
                                                  .cartAddUpdateApi(
                                                      fkProduct: hotProductData
                                                              .intGlcode ??
                                                          '',
                                                      fkVariant: hotProductData
                                                              .variantDetails
                                                              ?.variantId ??
                                                          '',
                                                      qty: hotProductData
                                                              .cartItem?.value
                                                              .toString() ??
                                                          '0'),
                                            }
                                          else
                                            {
                                              AppConstant().snackbars("Info",
                                                  "Currently we have only ${hotProductData.variantDetails?.varStock} In Stock."),
                                            }
                                        },
                                        onTapDecrement: () => {
                                          hotProductData.cartItem?.value--,
                                          if (hotProductData.cartItem!.value <
                                                  int.parse(hotProductData
                                                          .variantDetails
                                                          ?.varStock ??
                                                      '0')
                                              //          &&
                                              // hotProductData.cartItem!.value >
                                              //     0
                                              )
                                            {
                                              subCategoryController
                                                  .currentUserController
                                                  .cartAddUpdateApi(
                                                      fkProduct: hotProductData
                                                              .intGlcode ??
                                                          '',
                                                      fkVariant: hotProductData
                                                              .variantDetails
                                                              ?.variantId ??
                                                          '',
                                                      qty: hotProductData
                                                              .cartItem?.value
                                                              .toString() ??
                                                          '0'),
                                            }
                                          else
                                            {
                                              if (hotProductData
                                                      .cartItem!.value >
                                                  0)
                                                {
                                                  AppConstant().snackbars(
                                                      "Info",
                                                      "Currently we have only ${hotProductData.variantDetails?.varStock} In Stock."),
                                                }
                                            },
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible:
                                    subCategoryController.isLoadingMore.value ==
                                        true,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.h, bottom: 40.h),
                                  child: Center(
                                    child: LoadingWidget(width: 50.w),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => Visibility(
                                visible:
                                    subCategoryController.hasNextPage.value ==
                                        false,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 20.w, bottom: 20.w),
                                  child: Center(
                                    child: Text(
                                        'You have fetched all of the products',
                                        style: AppTextStyle.bodyLargeDarkGray),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    subCategoryController.selectFilterList.clear();
    subCategoryController.selectPriceRange.value = const RangeValues(0, 999999);
    subCategoryController.selectSortBy.value = "latest";
    super.dispose();
  }
}
