import 'package:get/get.dart';

import '../../../../Current_User/current_user_controller.dart';
import '../../../../Service/api_service.dart';
import '../../Categories_View/Model/category_model.dart';
import '../Model/home_model.dart';
import '../Model/product_model.dart';

class HomeController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  Rx<HomeModel> homeModel = HomeModel().obs;
  RxBool isLoading = false.obs;

  RxInt selectBannerIndex = 0.obs;

  @override
  void onInit() {
    homeApi(isLoadingShow: true);
    currentUserController.currenyIconApi();
    super.onInit();
  }

  void homeApi({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }

    if (isLoading.value) {
      homeModel.value = HomeModel(
        homeBanner: List.filled(
          2,
          HomeBanner(
            varImage: "",

            ///https://picsum.photos/250?image=9
          ),
        ),
        homeCategory: List.filled(
          8,
          CategoryModel(
            varTitle: "name",
            varIcon: "",
          ),
        ),
        offerProducts: List.filled(
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

    var homeData = await ApiServices().homeService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (homeData.status == 1) {
      homeModel.value = homeData;
    }
  }
}
