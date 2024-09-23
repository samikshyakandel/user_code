import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Current_User/current_user_controller.dart';
import '../../../../Service/api_service.dart';
import '../../WishList_View/favorite_controller.dart';
import '../Model/all_products_model.dart';
import '../Model/product_model.dart';
import 'home_controller.dart';

class AllProductsController extends GetxController {
  final prodArg = Get.arguments as int;

  final CurrentUserController currentUserController = Get.find();

  ///All Products
  Rx<AllProductsModel> offerAllProductsModel = AllProductsModel().obs;
  RxBool isAllProductsLoading = false.obs;

  RxInt page = 1.obs;
  RxBool hasNextPage = true.obs;
  RxBool isLoadingMore = false.obs;

  late ScrollController controller;

  @override
  void onInit() {
    controller = ScrollController()
      ..addListener(prodArg == 0
          ? _loadMoreOfferAllProductsApi
          : _loadMoreHotAllProductsApi);

    if (prodArg == 0) {
      offerAllProductsApi(isLoadingShow: true);
    } else {
      hotAllProductsApi(isLoadingShow: true);
    }

    super.onInit();
  }

  void offerAllProductsApi({required bool isLoadingShow}) async {
    page.value = 1;
    hasNextPage.value = true;
    isLoadingMore.value = false;
    if (isLoadingShow) {
      isAllProductsLoading.value = true;
    }

    if (isAllProductsLoading.value) {
      offerAllProductsModel.value = AllProductsModel(
        productData: List.filled(
          8,
          ProductsModel(
            varTitle: "name",
            varImage: "",
            like: "N".obs,
            varOffer: "00",
            variantDetails: VariantDetails(sellingPrice: '00', varPrice: '00'),
          ),
        ).obs,
      );
    }

    var offerProductsData = await ApiServices().offerAllProductsService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        page: page.value);
    isAllProductsLoading.value = false;
    if (offerProductsData.status == 1) {
      offerAllProductsModel.value = offerProductsData;
    }
  }

  void _loadMoreOfferAllProductsApi() async {
    if (hasNextPage.value == true &&
        isAllProductsLoading.value == false &&
        isLoadingMore.value == false &&
        controller.position.extentAfter < 300) {
      isLoadingMore.value = true;

      page.value += 1;
      try {
        var offerProductsDataLoadMore = await ApiServices()
            .offerAllProductsService(
                userId:
                    currentUserController.currentUser.value.data?.userId ?? '',
                page: page.value);
        isAllProductsLoading.value = false;

        if (offerProductsDataLoadMore.productData!.isNotEmpty) {
          offerAllProductsModel.value.productData
              ?.addAll(offerProductsDataLoadMore.productData!);
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

  void hotAllProductsApi({required bool isLoadingShow}) async {
    page.value = 1;
    hasNextPage.value = true;
    isLoadingMore.value = false;
    if (isLoadingShow) {
      isAllProductsLoading.value = true;
    }

    if (isAllProductsLoading.value) {
      offerAllProductsModel.value = AllProductsModel(
        productData: List.filled(
          8,
          ProductsModel(
            varTitle: "name",
            varImage: "",
            like: "N".obs,
            varOffer: "00",
            variantDetails: VariantDetails(sellingPrice: '00', varPrice: '00'),
          ),
        ).obs,
      );
    }

    var offerProductsData = await ApiServices().hotAllProductsService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        page: page.value);
    isAllProductsLoading.value = false;
    if (offerProductsData.status == 1) {
      offerAllProductsModel.value = offerProductsData;
    }
  }

  void _loadMoreHotAllProductsApi() async {
    if (hasNextPage.value == true &&
        isAllProductsLoading.value == false &&
        isLoadingMore.value == false &&
        controller.position.extentAfter < 300) {
      isLoadingMore.value = true;

      page.value += 1;
      try {
        var offerProductsDataLoadMore = await ApiServices()
            .hotAllProductsService(
                userId:
                    currentUserController.currentUser.value.data?.userId ?? '',
                page: page.value);
        isAllProductsLoading.value = false;

        if (offerProductsDataLoadMore.productData!.isNotEmpty) {
          offerAllProductsModel.value.productData
              ?.addAll(offerProductsDataLoadMore.productData!);
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

  @override
  void onClose() {
    final HomeController homeController = Get.put(HomeController());
    homeController.homeApi(isLoadingShow: false);
    final FavoriteController favoriteController = Get.put(FavoriteController());
    favoriteController.favoriteApi(isLoadingShow: false);
    super.onClose();
  }
}
