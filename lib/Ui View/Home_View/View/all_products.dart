import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Utils/app_textstyle.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constant.dart';
import '../../App_Widgets/appbar_widget.dart';
import '../../App_Widgets/loading_widget.dart';
import '../../App_Widgets/product_widget.dart';
import '../Controller/all_products_controller.dart';

class AllProductsView extends StatefulWidget {
  const AllProductsView({super.key});

  @override
  State<AllProductsView> createState() => _AllProductsViewState();
}

class _AllProductsViewState extends State<AllProductsView> {
  final AllProductsController allProductsController =
      Get.put(AllProductsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Obx(
          () => Skeletonizer(
            enabled: allProductsController.isAllProductsLoading.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppbarWidget(
                  title: allProductsController.prodArg == 0
                      ? "Offer Products"
                      : "Hot Products",
                  // isFilter: true,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: allProductsController.controller,
                    child: Column(
                      children: [
                        ResponsiveGridList(
                          listViewBuilderOptions: ListViewBuilderOptions(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics()),
                          minItemWidth: 150,
                          minItemsPerRow: 2,
                          maxItemsPerRow: 5,
                          horizontalGridMargin: 8,
                          horizontalGridSpacing: 2,
                          children: List.generate(
                            allProductsController.offerAllProductsModel.value
                                    .productData?.length ??
                                0,
                            (index) {
                              var productsData = allProductsController
                                  .offerAllProductsModel
                                  .value
                                  .productData?[index];
                              return ProductWidget(
                                fkProduct: productsData?.intGlcode ?? '',
                                imagePath: productsData?.varImage,
                                name: productsData?.varTitle,
                                varPrice:
                                    productsData?.variantDetails?.varPrice,
                                sellingPrice:
                                    productsData?.variantDetails?.sellingPrice,
                                isFavorite: productsData?.like?.value,
                                onTapFavorite: () => {
                                  if (productsData?.like?.value == "Y")
                                    {
                                      productsData?.like?.value = "N",
                                    }
                                  else
                                    {
                                      productsData?.like?.value = "Y",
                                    },
                                  allProductsController.currentUserController
                                      .favoriteAddRemoveApi(
                                          fkProduct:
                                              productsData?.intGlcode ?? '')
                                },
                                offer: int.parse(productsData?.varOffer ?? '0'),
                                cartItem: productsData?.cartItem?.value ?? 0,
                                onTapIncrement: () => {
                                  if (productsData!.cartItem!.value <
                                      int.parse(productsData
                                              .variantDetails?.varStock ??
                                          '0'))
                                    {
                                      productsData.cartItem?.value++,
                                      allProductsController
                                          .currentUserController
                                          .cartAddUpdateApi(
                                              fkProduct:
                                                  productsData.intGlcode ?? '',
                                              fkVariant: productsData
                                                      .variantDetails
                                                      ?.variantId ??
                                                  '',
                                              qty: productsData.cartItem?.value
                                                      .toString() ??
                                                  '0'),
                                    }
                                  else
                                    {
                                      AppConstant().snackbars("Info",
                                          "Currently we have only ${productsData.variantDetails?.varStock} In Stock."),
                                    }
                                },
                                onTapDecrement: () => {
                                  productsData?.cartItem?.value--,
                                  if (productsData!.cartItem!.value <
                                          int.parse(productsData
                                                  .variantDetails?.varStock ??
                                              '0')
                                      //         &&
                                      // productsData.cartItem!.value > 0
                                      )
                                    {
                                      allProductsController
                                          .currentUserController
                                          .cartAddUpdateApi(
                                              fkProduct:
                                                  productsData.intGlcode ?? '',
                                              fkVariant: productsData
                                                      .variantDetails
                                                      ?.variantId ??
                                                  '',
                                              qty: productsData.cartItem?.value
                                                      .toString() ??
                                                  '0'),
                                    }
                                  else
                                    {
                                      if (productsData.cartItem!.value > 0)
                                        {
                                          AppConstant().snackbars("Info",
                                              "Currently we have only ${productsData.variantDetails?.varStock} In Stock."),
                                        }
                                    },
                                },
                              );
                            },
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible:
                                allProductsController.isLoadingMore.value ==
                                    true,
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h, bottom: 40.h),
                              child: Center(
                                child: LoadingWidget(width: 50.w),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: allProductsController.hasNextPage.value ==
                                false,
                            child: Container(
                              padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
