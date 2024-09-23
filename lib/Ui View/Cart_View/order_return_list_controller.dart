import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Cart_View/cart_model.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Service/api_service.dart';

class OrderReturnListController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  Rx<CartModel> cartListModel = CartModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    cartListApi(isLoadingShow: true);
    super.onInit();
  }

  void cartListApi({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }
    var categoryData = await ApiServices().cartListService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (categoryData.status == 1) {
      cartListModel.value = categoryData;
    }
  }
}
