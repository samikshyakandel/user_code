import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Current_User/current_user_controller.dart';
import '../../../../Service/api_service.dart';
import '../../Home_View/Model/product_model.dart';
import '../Model/category_model.dart';
import '../Model/sub_category_model.dart';

class SubCategoryController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  Rx<SubCategoryModel> subCategoryModel = SubCategoryModel().obs;
  RxBool isLoading = false.obs;

  Rx<CategoryModel> selectCategory = CategoryModel().obs;
  RxList<ProductsModel> selectProducts = <ProductsModel>[].obs;
  RxBool isSelectLoading = false.obs;

  RxInt page = 1.obs;
  RxBool hasNextPage = true.obs;
  RxBool isLoadingMore = false.obs;

  late ScrollController controller;

  ///filter
  RxList<String> selectFilterList = <String>[].obs;
  RxString selectSortBy = "latest".obs;
  Rx<RangeValues> selectPriceRange = const RangeValues(0, 999999).obs;

  @override
  void onInit() {
    // categoryApi(isLoadingShow: true);
    controller = ScrollController()..addListener(_loadMoresubCategory);
    super.onInit();
  }

  void subCategoryApi({required bool isLoadingShow}) async {
    page.value = 1;
    hasNextPage.value = true;
    isLoadingMore.value = false;
    if (isLoadingShow) {
      isLoading.value = true;
    }
    isSelectLoading.value = true;

    if (isSelectLoading.value) {
      selectProducts.value = List.filled(
        8,
        ProductsModel(
          varTitle: "name",
          varImage: "",
          like: "N".obs,
          varOffer: "00",
          variantDetails: VariantDetails(sellingPrice: '00', varPrice: '00'),
        ),
      );
    }

    if (isLoading.value) {
      subCategoryModel.value = SubCategoryModel(
          data: SubCategoryData(
        subCategory: List.filled(
          8,
          CategoryModel(
            varTitle: "name",
            varIcon: "",
          ),
        ),
        productList: List.filled(
          8,
          ProductsModel(
            varTitle: "name",
            varImage: "",
            like: "N".obs,
            varOffer: "00",
            variantDetails: VariantDetails(sellingPrice: '00', varPrice: '00'),
          ),
        ),
      ));
    }

    var subCategoryData = await ApiServices().subCategoryService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        fkCategory: selectCategory.value.intGlcode ?? '',
        attributeList: selectFilterList,
        sortBy: selectSortBy.value,
        minPrice: selectPriceRange.value.start.toString(),
        maxPrice: selectPriceRange.value.end.toString(),
        page: page.value);
    isLoading.value = false;
    if (subCategoryData.status == 1) {
      if (isLoadingShow) {
        subCategoryModel.value = subCategoryData;
      }
      isSelectLoading.value = false;
      selectProducts.value = subCategoryData.data?.productList ?? [];
    }
  }

  void _loadMoresubCategory() async {
    if (hasNextPage.value == true &&
        isLoading.value == false &&
        isLoadingMore.value == false &&
        controller.position.extentAfter < 300) {
      isLoadingMore.value = true;

      page.value += 1;
      try {
        var subCategoryDataLoadMore = await ApiServices().subCategoryService(
            userId: currentUserController.currentUser.value.data?.userId ?? '',
            fkCategory: selectCategory.value.intGlcode ?? '',
            attributeList: selectFilterList,
            sortBy: selectSortBy.value,
            minPrice: selectPriceRange.value.start.toString(),
            maxPrice: selectPriceRange.value.end.toString(),
            page: page.value);

        if (subCategoryDataLoadMore.data!.productList!.isNotEmpty) {
          selectProducts.addAll(subCategoryDataLoadMore.data!.productList!);
        } else {
          hasNextPage.value = false;
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      isLoadingMore.value = false;
    }
  }
}
