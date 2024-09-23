import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/WishList_View/favorite_controller.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Service/api_service.dart';
import '../Home_View/Controller/home_controller.dart';
import 'Model/product_details_model.dart';

class ProductDetailsController extends GetxController {
  final fkProductArg = Get.arguments[0] as String;
  final nameProductArg = Get.arguments[1] as String;

  final CurrentUserController currentUserController = Get.find();

  Rx<ProductDetailsModel> productDetailsModel = ProductDetailsModel().obs;
  RxBool isLoading = false.obs;
  RxInt selectBannerIndex = 0.obs;

  Rx<VariantDataModel> selectVariantModel = VariantDataModel().obs;

  // RxInt selectSize = 0.obs;
  // RxInt selectColor = 0.obs;
  // RxInt qty = 1.obs;

  @override
  void onInit() {
    productDetailsApi(isLoadingShow: true);
    super.onInit();
  }

  void productDetailsApi({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }

    if (isLoading.value) {
      productDetailsModel.value = ProductDetailsModel(
        data: DetailsData(
          varTitle: "product title",
          varShortDescription: "product Short Description",
          imgs: List.filled(8, ''),
          ratting: 0,
          like: "N".obs,
        ),
      );
    }

    var productDetailsData = await ApiServices().productDetailsService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        fkProduct: fkProductArg);
    isLoading.value = false;
    if (productDetailsData.status == 1) {
      productDetailsModel.value = productDetailsData;
      if (productDetailsData.data?.variant?.isNotEmpty ?? false) {
        selectVariantModel.value = productDetailsData.data!.variant![0];
      }
    }
  }

  void changeVariantApi({required String attributeId}) async {
    // if (isLoadingShow) {
    //   isLoading.value = true;
    // }

    // if (isLoading.value) {
    //   productDetailsModel.value = ProductDetailsModel(
    //     data: DetailsData(
    //       varTitle: "product title",
    //       varShortDescription: "product Short Description",
    //       imgs: List.filled(8, ''),
    //       ratting: 0,
    //       like: "N".obs,
    //     ),
    //   );
    // }

    var variantData = await ApiServices().changeVariantService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        productId: fkProductArg,
        attributeId: attributeId);
    isLoading.value = false;
    if (variantData.status == 1) {
      selectVariantModel.value = variantData.data!;
      // productDetailsApi(isLoadingShow: false);
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
