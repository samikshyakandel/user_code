import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Search_View/model/search_model.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Service/api_service.dart';
import '../Categories_View/Model/category_model.dart';
import '../Home_View/Controller/home_controller.dart';
import '../Home_View/Model/product_model.dart';
import '../WishList_View/favorite_controller.dart';
import 'model/search_suggetion_model.dart';

class SearchProdController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  // RxList<String> suggestList = <String>["Book", "Mobile", "Folding Mobile"].obs;

  RxBool isSearch = false.obs;
  var searchCont = TextEditingController();
  Rx<SearchModel> searchModel = SearchModel().obs;
  RxBool isLoading = false.obs;

  Rx<SearchSuggetionModel> searchSuggetionModel = SearchSuggetionModel().obs;
  RxBool isLoadingSugg = false.obs;

  @override
  void onInit() {
    // searchCont.addListener(listener);
    searchApi();
    super.onInit();
  }

  // void listener() {
  //   if (searchCont.value.text.isEmpty) {
  //     isSearch.value = false;
  //     searchApi();
  //   } else {
  //     isSearch.value = true;
  //     searchApi();
  //   }
  // }

  void searchApi() async {
    // if (isLoadingShow) {
    isLoading.value = true;
    // }

    if (isLoading.value) {
      searchModel.value = SearchModel(
        category: List.filled(
          8,
          CategoryModel(
            varTitle: "name",
            varIcon: "",
          ),
        ),
        products: List.filled(
          8,
          ProductsModel(
            varTitle: "name",
            varImage: "",
            like: "N".obs,
            varOffer: "00",
            variantDetails: VariantDetails(sellingPrice: '00', varPrice: '00'),
          ),
        ),
      );
    }

    var searchData = await ApiServices().searchService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        keywords: searchCont.text);
    isLoading.value = false;
    if (searchData.status == 1) {
      searchModel.value = searchData;
    }
  }

  void searchSuggetionApi({required String keyWord}) async {
    // if (isLoadingShow) {
    isLoadingSugg.value = true;
    // }

    if (isLoadingSugg.value) {
      searchSuggetionModel.value = SearchSuggetionModel(
        data: List.filled(
          8,
          'search suggetion list',
        ),
      );
    }

    var searchSugData = await ApiServices().searchSuggetionService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        keywords: searchCont.text);
    isLoadingSugg.value = false;
    if (searchSugData.status == 1) {
      searchSuggetionModel.value = searchSugData;
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
