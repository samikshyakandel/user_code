import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/WishList_View/favorite_model.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../Home_View/Controller/home_controller.dart';
import '../Home_View/Model/product_model.dart';

class FavoriteController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  Rx<FavoriteModel> favoriteModel = FavoriteModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    favoriteApi(isLoadingShow: true);
    super.onInit();
  }

  void favoriteApi({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }

    if (isLoading.value) {
      favoriteModel.value = FavoriteModel(
        data: List.filled(
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

    var favoriteData = await ApiServices().favoriteListService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (favoriteData.status == 1) {
      favoriteModel.value = favoriteData;
    }
  }

  @override
  void onClose() {
    final HomeController homeController = Get.put(HomeController());
    homeController.homeApi(isLoadingShow: false);
    super.onClose();
  }
}
