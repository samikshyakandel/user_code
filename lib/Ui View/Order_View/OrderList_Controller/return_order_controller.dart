import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../Model/order_details_model.dart';
import 'order_details_controller.dart';

class ReturnOrderController extends GetxController {
  final fkProductArrArg = Get.arguments[0] as FkProductArr;
  final orderIdArg = Get.arguments[1] as String;
  final orderIntGlCodeArg = Get.arguments[2] as String;

  final CurrentUserController currentUserController = Get.find();

  RxBool isLoading = false.obs;
  final returnOrderFormGlobalKey = GlobalKey<FormState>();
  var reasonTextCount = TextEditingController();

  RxInt selectQty = 1.obs;

  void orderReturnApi(fkProduct, fkVariant, orderId) async {
    isLoading.value = true;
    var loginData = await ApiServices().orderReturnService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        fkProduct: fkProduct ?? '',
        fkVariant: fkVariant ?? '',
        returnText: reasonTextCount.text,
        orderId: orderId ?? '',
        qty: selectQty.value.toString());
    isLoading.value = false;
    if (loginData.status == 1) {
      Get.back(closeOverlays: true);
      final OrderDetailsController orderDetailsController = Get.find();
      orderDetailsController.orderDetailsAPI();
      // Get.offAllNamed(AppRoutes.mainBottomView);
    }
  }
}
