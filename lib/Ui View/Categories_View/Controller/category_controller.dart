import 'package:get/get.dart';

import '../../../../Current_User/current_user_controller.dart';
import '../../../../Service/api_service.dart';
import '../Model/all_category_model.dart';
import '../Model/category_model.dart';

class CategoryController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  Rx<AllCategoryModel> allCategoryModel = AllCategoryModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    categoryApi(isLoadingShow: true);
    super.onInit();
  }

  void categoryApi({required bool isLoadingShow}) async {
    if (isLoadingShow) {
      isLoading.value = true;
    }

    if (isLoading.value) {
      allCategoryModel.value = AllCategoryModel(
        categoryData: List.filled(
          8,
          CategoryModel(
            varTitle: "name",
            varIcon: "",
          ),
        ),
      );
    }

    var categoryData = await ApiServices().allCategoryService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (categoryData.status == 1) {
      allCategoryModel.value = categoryData;
    }
  }
}
