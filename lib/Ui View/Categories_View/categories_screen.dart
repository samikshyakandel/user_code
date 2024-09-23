import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../Utils/Routes/app_routes.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/categories_widget.dart';
import '../App_Widgets/drawer_menu.dart';
import '../App_Widgets/empty_widget.dart';
import 'Controller/category_controller.dart';
import 'Controller/sub_category_controller.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});

  final CategoryController categoryController = Get.put(CategoryController());
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
          AppbarWidget(
            title: 'Explore Categories',
            isDrawer: true,
            isFilter: false,
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async =>
                  categoryController.categoryApi(isLoadingShow: false),
              color: AppColors.orangeColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => Skeletonizer(
                    enabled: categoryController.isLoading.value,
                    child: categoryController
                                .allCategoryModel.value.categoryData?.isEmpty ??
                            true
                        ? const EmptyWidget()
                        : ResponsiveGridList(
                            listViewBuilderOptions: ListViewBuilderOptions(
                              shrinkWrap: true,
                            ),
                            minItemWidth: 50,
                            minItemsPerRow: 4,
                            maxItemsPerRow: 4,
                            verticalGridSpacing: 10,
                            children: List.generate(
                              categoryController.allCategoryModel.value
                                      .categoryData?.length ??
                                  0,
                              (index) {
                                var categoryData = categoryController
                                    .allCategoryModel
                                    .value
                                    .categoryData?[index];
                                return CategoryWidget(
                                  name: categoryData?.varTitle ?? '',
                                  imagePath: categoryData?.varIcon ?? '',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
