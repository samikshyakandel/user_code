import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Cart_View/cart_model.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Service/api_service.dart';
import '../Home_View/Controller/home_controller.dart';
import '../Home_View/Model/product_model.dart';

class CartController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  Rx<CartModel> cartListModel = CartModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    cartListApi(isLoadingShow: true);
    currentUserController.currenyIconApi();
    super.onInit();
  }

  void cartListApi({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }

    if (isLoading.value) {
      cartListModel.value = CartModel(
        productData: List.filled(
          8,
          ProductsModel(
            varTitle: "name",
            varImage: "",
            like: "N".obs,
            varOffer: "00",
            cartItem: 0.obs,
            variantDetails: VariantDetails(sellingPrice: '00', varPrice: '00'),
          ),
        ),
        discountTotal: "000".obs,
        gstTotal: '000',
        subTotal: '000',
        grossTotal: '000'.obs,
      );
    }

    var categoryData = await ApiServices().cartListService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    // cartListModel.value = CartModel();
    if (categoryData.status == 1) {
      cartListModel.value = categoryData;
    }
  }

  void cartDeleteProductApi(
          {required String fkProduct, required String fkVariant}) async =>
      {
        await ApiServices().cartDeleteProductService(
          userId: currentUserController.currentUser.value.data?.userId ?? '',
          fkProduct: fkProduct,
          fkVariant: fkVariant,
        ),
        currentUserController.cartCountApi(),
      };

  @override
  void onClose() {
    final HomeController homeController = Get.put(HomeController());
    homeController.homeApi(isLoadingShow: false);
    super.onClose();
  }
}
