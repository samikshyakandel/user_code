import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_constant.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/empty_widget.dart';
import '../App_Widgets/product_widget.dart';
import 'favorite_controller.dart';

class FavoriteProduct extends StatelessWidget {
  FavoriteProduct({super.key});

  final FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidget(title: 'Wishlist', isSearch: false),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    favoriteController.favoriteApi(isLoadingShow: false),
                color: AppColors.orangeColor,
                child: Obx(
                  () => Skeletonizer(
                    enabled: favoriteController.isLoading.value,
                    child: favoriteController
                                .favoriteModel.value.data?.isEmpty ??
                            true
                        ? const EmptyWidget()
                        : ResponsiveGridList(
                            listViewBuilderOptions: ListViewBuilderOptions(
                              shrinkWrap: true,
                            ),
                            minItemWidth: 150,
                            minItemsPerRow: 2,
                            maxItemsPerRow: 2,
                            horizontalGridMargin: 10,
                            horizontalGridSpacing: 2,
                            children: List.generate(
                              favoriteController
                                      .favoriteModel.value.data?.length ??
                                  0,
                              (index) {
                                var favoriteData = favoriteController
                                    .favoriteModel.value.data?[index];
                                return ProductWidget(
                                  fkProduct: favoriteData?.intGlcode ?? '',
                                  imagePath: favoriteData?.varImage,
                                  name: favoriteData?.varTitle,
                                  varPrice:
                                      favoriteData?.variantDetails?.varPrice,
                                  sellingPrice: favoriteData
                                      ?.variantDetails?.sellingPrice,
                                  isFavorite: favoriteData?.like?.value,
                                  onTapFavorite: () => {
                                    if (favoriteData?.like?.value == "Y")
                                      {
                                        favoriteData?.like?.value = "N",
                                        favoriteController
                                            .favoriteModel.value.data
                                            ?.remove(favoriteData),
                                      }
                                    else
                                      {
                                        favoriteData?.like?.value = "Y",
                                      },
                                    favoriteController.currentUserController
                                        .favoriteAddRemoveApi(
                                            fkProduct:
                                                favoriteData?.intGlcode ?? ''),
                                  },
                                  offer:
                                      int.parse(favoriteData?.varOffer ?? '0'),
                                  cartItem: favoriteData?.cartItem?.value ?? 0,
                                  onTapIncrement: () => {
                                    if (favoriteData!.cartItem!.value <
                                        int.parse(favoriteData
                                                .variantDetails?.varStock ??
                                            '0'))
                                      {
                                        favoriteData.cartItem?.value++,
                                        favoriteController.currentUserController
                                            .cartAddUpdateApi(
                                                fkProduct:
                                                    favoriteData.intGlcode ??
                                                        '',
                                                fkVariant: favoriteData
                                                        .variantDetails
                                                        ?.variantId ??
                                                    '',
                                                qty: favoriteData
                                                        .cartItem?.value
                                                        .toString() ??
                                                    '0'),
                                      }
                                    else
                                      {
                                        AppConstant().snackbars("Info",
                                            "Currently we have only ${favoriteData.variantDetails?.varStock} In Stock."),
                                      }
                                  },
                                  onTapDecrement: () => {
                                    favoriteData?.cartItem?.value--,
                                    if (favoriteData!.cartItem!.value <
                                            int.parse(favoriteData
                                                    .variantDetails?.varStock ??
                                                '0')
                                        //         &&
                                        // favoriteData.cartItem!.value > 0
                                        )
                                      {
                                        favoriteController.currentUserController
                                            .cartAddUpdateApi(
                                                fkProduct:
                                                    favoriteData.intGlcode ??
                                                        '',
                                                fkVariant: favoriteData
                                                        .variantDetails
                                                        ?.variantId ??
                                                    '',
                                                qty: favoriteData
                                                        .cartItem?.value
                                                        .toString() ??
                                                    '0'),
                                      }
                                    else
                                      {
                                        if (favoriteData.cartItem!.value > 0)
                                          {
                                            AppConstant().snackbars("Info",
                                                "Currently we have only ${favoriteData.variantDetails?.varStock} In Stock."),
                                          }
                                      },
                                  },
                                );
                              },
                            ),
                          ),
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
