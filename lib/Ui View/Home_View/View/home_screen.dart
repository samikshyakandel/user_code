import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../Utils/app_textstyle.dart';
import '../../../Utils/Routes/app_routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/app_constant.dart';
import '../../../Utils/app_images.dart';
import '../../App_Widgets/appbar_widget.dart';
import '../../App_Widgets/categories_widget.dart';
import '../../App_Widgets/drawer_menu.dart';
import '../../App_Widgets/product_widget.dart';
import '../../Categories_View/Controller/sub_category_controller.dart';
import '../Controller/bottom_controller.dart';
import '../Controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController homeController = Get.put(HomeController());
  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      drawer: DrawerMenu(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppbarWidget(title: '', isDrawer: true),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async =>
                  homeController.homeApi(isLoadingShow: false),
              color: AppColors.orangeColor,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 115.h,
                        child: Obx(
                          () => Skeletonizer(
                            enabled: homeController.isLoading.value,
                            child: PageView.builder(
                              itemCount: homeController
                                      .homeModel.value.homeBanner?.length ??
                                  0,
                              onPageChanged: (val) =>
                                  homeController.selectBannerIndex.value = val,
                              itemBuilder: (context, i) => Padding(
                                padding: EdgeInsets.only(
                                    left: i == 0 ? 6.0 : 0, right: 6.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: homeController
                                              .homeModel
                                              .value
                                              .homeBanner?[i]
                                              .varImage
                                              ?.isEmpty ??
                                          true
                                      ? Icon(
                                          Icons.image,
                                          color: AppColors.gray,
                                          size: 40,
                                        )
                                      : Image.network(
                                          homeController.homeModel.value
                                                  .homeBanner?[i].varImage ??
                                              '',
                                          height: 115.h,
                                          fit: BoxFit.fill,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Skeletonizer(
                                              enabled: true,
                                              child: Image.asset(
                                                AppImages.icHomeSliderImg,
                                                height: 115.h,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          homeController.homeModel.value.homeBanner?.length ??
                              0,
                          (index) => Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Obx(
                              () => Icon(Icons.circle,
                                  size: 10,
                                  color:
                                      homeController.selectBannerIndex.value ==
                                              index
                                          ? AppColors.orangeColor
                                          : AppColors.gray),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Explore Categories",
                                style: AppTextStyle.bodyLargeOrangeSixteen,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final BottomController bottomController =
                                    Get.put(BottomController());
                                bottomController.myIndex.value = 1;
                              },
                              child: Text(
                                "View All",
                                style: AppTextStyle.bodyLargeDarkGray.copyWith(
                                    color: AppColors.darkGrayColor
                                        .withOpacity(0.5)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Obx(
                            () => Skeletonizer(
                              enabled: homeController.isLoading.value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(
                                  homeController.homeModel.value.homeCategory
                                          ?.length ??
                                      0,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: CategoryWidget(
                                      size: 50,
                                      name: homeController.homeModel.value
                                          .homeCategory?[index].varTitle,
                                      imagePath: homeController.homeModel.value
                                          .homeCategory?[index].varIcon,
                                      onTap: () => {
                                        subCategoryController
                                                .selectCategory.value =
                                            homeController.homeModel.value
                                                .homeCategory![index],
                                        Get.toNamed(AppRoutes.subCategory,
                                            arguments: homeController.homeModel
                                                .value.homeCategory![index]),
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Offer Products",
                              style: AppTextStyle.bodyLargeW600,
                            )),
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                  AppRoutes.allProductsView,
                                  arguments: 0),
                              child: Text("View All",
                                  style: AppTextStyle.bodyLargeDarkGray
                                      .copyWith(
                                          color: AppColors.darkGrayColor
                                              .withOpacity(0.5))),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => Skeletonizer(
                            enabled: homeController.isLoading.value,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ...List.generate(
                                  homeController.homeModel.value.offerProducts
                                          ?.length ??
                                      0,
                                  (ind) {
                                    var productData = homeController
                                        .homeModel.value.offerProducts?[ind];
                                    return ProductWidget(
                                      fkProduct: productData?.intGlcode ?? '',
                                      imagePath: productData?.varImage,
                                      name: productData?.varTitle,
                                      varPrice:
                                          productData?.variantDetails?.varPrice,
                                      sellingPrice: productData
                                          ?.variantDetails?.sellingPrice,
                                      isFavorite: productData?.like?.value,
                                      onTapFavorite: () => {
                                        if (productData?.like?.value == "Y")
                                          {
                                            productData?.like?.value = "N",
                                          }
                                        else
                                          {
                                            productData?.like?.value = "Y",
                                          },
                                        homeController.currentUserController
                                            .favoriteAddRemoveApi(
                                                fkProduct:
                                                    productData?.intGlcode ??
                                                        ''),
                                      },
                                      offer: int.parse(
                                          productData?.varOffer ?? '0'),
                                      cartItem:
                                          productData?.cartItem?.value ?? 0,
                                      onTapIncrement: () => {
                                        if (productData!.cartItem!.value <
                                            int.parse(productData
                                                    .variantDetails?.varStock ??
                                                '0'))
                                          {
                                            productData.cartItem?.value++,
                                            homeController.currentUserController
                                                .cartAddUpdateApi(
                                                    fkProduct:
                                                        productData.intGlcode ??
                                                            '',
                                                    fkVariant: productData
                                                            .variantDetails
                                                            ?.variantId ??
                                                        '',
                                                    qty: productData
                                                            .cartItem?.value
                                                            .toString() ??
                                                        '0'),
                                          }
                                        else
                                          {
                                            AppConstant().snackbars("Info",
                                                "Currently we have only ${productData.variantDetails?.varStock} In Stock."),
                                          }
                                      },
                                      onTapDecrement: () => {
                                        productData?.cartItem?.value--,
                                        if (productData!.cartItem!.value <
                                                int.parse(productData
                                                        .variantDetails
                                                        ?.varStock ??
                                                    '0')
                                            //         &&
                                            // productData.cartItem!.value > 0
                                            )
                                          {
                                            homeController.currentUserController
                                                .cartAddUpdateApi(
                                                    fkProduct:
                                                        productData.intGlcode ??
                                                            '',
                                                    fkVariant: productData
                                                            .variantDetails
                                                            ?.variantId ??
                                                        '',
                                                    qty: productData
                                                            .cartItem?.value
                                                            .toString() ??
                                                        '0'),
                                          }
                                        else
                                          {
                                            if (productData.cartItem!.value > 0)
                                              {
                                                AppConstant().snackbars("Info",
                                                    "Currently we have only ${productData.variantDetails?.varStock} In Stock."),
                                              }
                                          },
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Hot Products",
                              style: AppTextStyle.bodyLargeW600,
                            )),
                            GestureDetector(
                              onTap: () => Get.toNamed(
                                  AppRoutes.allProductsView,
                                  arguments: 1),
                              child: Text(
                                "View All",
                                style: AppTextStyle.bodyLargeDarkGray.copyWith(
                                    color: AppColors.darkGrayColor
                                        .withOpacity(0.5)),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Obx(
                        () => Skeletonizer(
                          enabled: homeController.isLoading.value,
                          child: ResponsiveGridList(
                            listViewBuilderOptions: ListViewBuilderOptions(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                            ),
                            minItemWidth: 150,
                            minItemsPerRow: 2,
                            maxItemsPerRow: 5,
                            horizontalGridMargin: 2,
                            horizontalGridSpacing: 2,
                            children: List.generate(
                              homeController
                                      .homeModel.value.hotProducts?.length ??
                                  0,
                              (index) {
                                var hotProductData = homeController
                                    .homeModel.value.hotProducts?[index];
                                return ProductWidget(
                                  fkProduct: hotProductData?.intGlcode ?? '',
                                  imagePath: hotProductData?.varImage,
                                  name: hotProductData?.varTitle,
                                  varPrice:
                                      hotProductData?.variantDetails?.varPrice,
                                  sellingPrice: hotProductData
                                      ?.variantDetails?.sellingPrice,
                                  isFavorite: hotProductData?.like?.value,
                                  onTapFavorite: () => {
                                    if (hotProductData?.like?.value == "Y")
                                      {
                                        hotProductData?.like?.value = "N",
                                      }
                                    else
                                      {
                                        hotProductData?.like?.value = "Y",
                                      },
                                    homeController.currentUserController
                                        .favoriteAddRemoveApi(
                                            fkProduct:
                                                hotProductData?.intGlcode ?? '')
                                  },
                                  offer: int.parse(
                                      hotProductData?.varOffer ?? '0'),
                                  cartItem:
                                      hotProductData?.cartItem?.value ?? 0,
                                  onTapIncrement: () => {
                                    if (hotProductData!.cartItem!.value <
                                        int.parse(hotProductData
                                                .variantDetails?.varStock ??
                                            '0'))
                                      {
                                        hotProductData.cartItem?.value++,
                                        homeController.currentUserController
                                            .cartAddUpdateApi(
                                                fkProduct:
                                                    hotProductData.intGlcode ??
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
                                    hotProductData?.cartItem?.value--,
                                    if (hotProductData!.cartItem!.value <
                                            int.parse(hotProductData
                                                    .variantDetails?.varStock ??
                                                '0')
                                        //         &&
                                        // hotProductData.cartItem!.value > 0
                                        )
                                      {
                                        homeController.currentUserController
                                            .cartAddUpdateApi(
                                                fkProduct:
                                                    hotProductData.intGlcode ??
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
                                        if (hotProductData.cartItem!.value > 0)
                                          {
                                            AppConstant().snackbars("Info",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
