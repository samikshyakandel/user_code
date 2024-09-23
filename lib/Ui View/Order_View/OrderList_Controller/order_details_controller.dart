import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../Model/get_order_list_model.dart';
import '../Model/order_details_model.dart';
import 'get_order_list_controller.dart';

class OrderDetailsController extends GetxController {
  final CurrentUserController currentUserController = Get.find();
  final OrderData orderId = Get.arguments as OrderData;

  RxBool isLoading = false.obs;
  Rx<OrderDetailsModel> getOrderListModel = OrderDetailsModel().obs;

  @override
  void onInit() {
    orderDetailsAPI();
    currentUserController.currenyIconApi();
    super.onInit();
  }

  void orderDetailsAPI() async {
    isLoading.value = true;

    if (isLoading.value) {
      getOrderListModel.value = OrderDetailsModel(
        data: OrderDetailsData(),
      );
    }

    var orderListData = await ApiServices().orderDetailsService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        fkOrder: orderId.intGlcode ?? '');
    isLoading.value = false;
    if (orderListData.status == 1) {
      getOrderListModel.value = orderListData;
    }
  }

  void cancelOrderAPI() async {
    isLoading.value = true;
    var orderListData = await ApiServices()
        .cancelOrderService(fkOrder: orderId.intGlcode ?? '');
    isLoading.value = false;
    if (orderListData.status == 1) {
      Get.back();
      final GetOrderListController getOrderListController =
          Get.put(GetOrderListController());

      getOrderListController.getOrderListAPI(isLoadingShow: false);
    }
  }
}
