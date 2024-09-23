import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/Routes/app_routes.dart';
import '../../Utils/app_constant.dart';
import '../../Utils/app_images.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/categories_widget.dart';
import '../App_Widgets/empty_widget.dart';
import '../App_Widgets/product_widget.dart';
import '../App_Widgets/textfield_widget.dart';
import '../Categories_View/Controller/sub_category_controller.dart';
import 'search_controller.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final SearchProdController searchProdController =
      Get.put(SearchProdController());

  final SubCategoryController subCategoryController =
      Get.put(SubCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 6),
                InkWell(
                  onTap: () => Get.back(),
                  borderRadius: BorderRadius.circular(10),
                  child: SvgPicture.asset(AppImages.icBack),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFieldWidget(
                    controller: searchProdController.searchCont,
                    hintText: "Search...",
                    onChanged: (val) => {
                      if (val.isEmpty)
                        {
                          searchProdController.isSearch.value = false,
                          searchProdController.searchApi(),
                        }
                      else
                        {
                          searchProdController.isSearch.value = true,
                          searchProdController.searchSuggetionApi(keyWord: val),
                        }
                    },
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: (p0) => {
                      searchProdController.isSearch.value = false,
                      searchProdController.searchApi()
                    },
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.gray,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
            Expanded(
              child: Obx(
                () => searchProdController.isSearch.value
                    ? suggestList()
                    : categoryProductWidget(),
              ),
            ),
          ],
        ),
      )),
    );
  }

  Widget suggestList() {
    return Skeletonizer(
      enabled: searchProdController.isLoadingSugg.value,
      child: ListView.builder(
        itemCount:
            searchProdController.searchSuggetionModel.value.data?.length ?? 0,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(
            Icons.search,
            color: AppColors.gray,
          ),
          trailing: Icon(
            Icons.history_rounded,
            color: AppColors.gray,
          ),
          title: Text(
              searchProdController.searchSuggetionModel.value.data?[index] ??
                  '',
              style: AppTextStyle.lableLarge),
          onTap: () => {
            searchProdController.isSearch.value = false,
            searchProdController.searchCont.text =
                searchProdController.searchSuggetionModel.value.data?[index] ??
                    '',
            searchProdController.searchApi(),
          },
        ),
      ),
    );
  }

  Widget categoryProductWidget() {
    return Obx(
      () => (searchProdController.searchModel.value.category!.isEmpty &&
              searchProdController.searchModel.value.products!.isEmpty)
          ? const FittedBox(child: EmptyWidget())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    if (searchProdController
                            .searchModel.value.category?.isNotEmpty ??
                        false)
                      Text(
                        "Categories",
                        style: AppTextStyle.bodyLargeOrangeSixteen,
                      ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Skeletonizer(
                        enabled: searchProdController.isLoading.value,
                        child: ResponsiveGridList(
                          listViewBuilderOptions: ListViewBuilderOptions(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          minItemWidth: 50,
                          minItemsPerRow: 4,
                          maxItemsPerRow: 4,
                          verticalGridSpacing: 10,
                          horizontalGridMargin: 6,
                          children: List.generate(
                            searchProdController
                                    .searchModel.value.category?.length ??
                                0,
                            (index) {
                              var categoryData = searchProdController
                                  .searchModel.value.category?[index];
                              return CategoryWidget(
                                name: categoryData?.varTitle,
                                imagePath: categoryData?.varIcon,
                                onTap: () => {
                                  subCategoryController.selectCategory.value =
                                      categoryData!,
                                  Get.toNamed(AppRoutes.subCategory,
                                      arguments: categoryData),
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (searchProdController
                            .searchModel.value.products?.isNotEmpty ??
                        false)
                      Text(
                        "Products",
                        style: AppTextStyle.bodyLargeOrangeSixteen,
                      ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Skeletonizer(
                        enabled: searchProdController.isLoading.value,
                        child: ResponsiveGridList(
                          listViewBuilderOptions: ListViewBuilderOptions(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          minItemWidth: 150,
                          minItemsPerRow: 2,
                          maxItemsPerRow: 5,
                          horizontalGridMargin: 0,
                          horizontalGridSpacing: 2,
                          children: List.generate(
                            searchProdController
                                    .searchModel.value.products?.length ??
                                0,
                            (index) {
                              var hotProductData = searchProdController
                                  .searchModel.value.products?[index];
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
                                  searchProdController.currentUserController
                                      .favoriteAddRemoveApi(
                                          fkProduct:
                                              hotProductData?.intGlcode ?? '')
                                },
                                offer:
                                    int.parse(hotProductData?.varOffer ?? '0'),
                                cartItem: hotProductData?.cartItem?.value ?? 0,
                                onTapIncrement: () => {
                                  if (hotProductData!.cartItem!.value <
                                      int.parse(hotProductData
                                              .variantDetails?.varStock ??
                                          '0'))
                                    {
                                      hotProductData.cartItem?.value++,
                                      searchProdController.currentUserController
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
                                      searchProdController.currentUserController
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
    );
  }
}
