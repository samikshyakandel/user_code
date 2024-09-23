import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../Model/get_order_list_model.dart';

class GetOrderListController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  RxBool isLoading = false.obs;
  Rx<GetOrderListModel> getOrderListModel = GetOrderListModel().obs;

  @override
  void onInit() {
    getOrderListAPI(isLoadingShow: true);
    currentUserController.currenyIconApi();
    super.onInit();
  }

  Future<void> getOrderListAPI({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }
    if (isLoading.value) {
      getOrderListModel.value = GetOrderListModel(
        data: List.filled(
          8,
          OrderData(
            orderId: "000000",
            chrStatus: "acept",
            dtCreateddate: "2023-12-05 01:25:13",
            totalProducts: 1,
            varPayableAmount: "111",
          ),
        ),
      );
    }
    var orderListData = await ApiServices().getOrderListService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (orderListData.status == 1) {
      getOrderListModel.value = orderListData;
    }
  }
}
