import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../../../Utils/app_constant.dart';
import '../../Order_View/Model/order_details_model.dart';

class ReviewController extends GetxController {
  final productIdArg = Get.arguments[0] as FkProductArr;
  final orderIdArg = Get.arguments[1] as String;

  final CurrentUserController currentUserController = Get.find();

  final reviewFormGlobalKey = GlobalKey<FormState>();
  var titleReviewCont = TextEditingController();
  var descReviewCont = TextEditingController();
  RxDouble rating = 3.5.obs;

  RxBool isLoading = false.obs;

  void addReviewApi() async {
    isLoading.value = true;
    var loginData = await ApiServices().addReviewService(
      userId: currentUserController.currentUser.value.data!.userId!,
      fkProduct: productIdArg.fkProduct ?? '',
      rating: rating.value.toString(),
      reviewText: descReviewCont.text,
      fkOrder: orderIdArg,
      fkVariant: productIdArg.fkVariant ?? '',
    );
    isLoading.value = false;
    if (loginData == 1) {
      Get.back();
      AppConstant().snackbars("Success", "Review added successfully.");
    }
  }
}
