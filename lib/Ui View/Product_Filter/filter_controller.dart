import 'package:get/get.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Service/api_service.dart';
import '../Categories_View/Controller/sub_category_controller.dart';
import 'filter_attribute_model.dart';

class FilterController extends GetxController {
  // RxList<FilterItemModel> categoryList = <FilterItemModel>[
  //   FilterItemModel(title: "Fresh Vegetables", isSelect: false.obs),
  //   FilterItemModel(title: "Test 1", isSelect: false.obs),
  //   FilterItemModel(title: "Smartphone", isSelect: false.obs),
  //   FilterItemModel(title: "test2", isSelect: false.obs),
  //   FilterItemModel(title: "Fridge", isSelect: false.obs),
  //   FilterItemModel(title: "LP shirt", isSelect: false.obs),
  // ].obs;

  // RxList<FilterItemModel> brandList = <FilterItemModel>[
  //   FilterItemModel(title: "Showdown", isSelect: false.obs),
  //   FilterItemModel(title: "Skechers", isSelect: false.obs),
  //   FilterItemModel(title: "PuMa", isSelect: false.obs),
  //   FilterItemModel(title: "Nike", isSelect: false.obs),
  //   FilterItemModel(title: "Nokia", isSelect: false.obs),
  //   FilterItemModel(title: "Real Me", isSelect: false.obs),
  //   FilterItemModel(title: "Xiomi", isSelect: false.obs),
  //   FilterItemModel(title: "Louis Philipe", isSelect: false.obs),
  //   FilterItemModel(title: "Stringc", isSelect: false.obs),
  //   FilterItemModel(title: "maacza", isSelect: false.obs),
  //   FilterItemModel(title: "cococola", isSelect: false.obs),
  // ].obs;

  // RxList<FilterItemModel> typeList = <FilterItemModel>[
  //   FilterItemModel(title: "200 BUDS", isSelect: false.obs),
  //   FilterItemModel(title: "100 BUDS", isSelect: false.obs),
  //   FilterItemModel(title: "Type1", isSelect: false.obs),
  // ].obs;

  // RxList<FilterItemModel> styleList = <FilterItemModel>[
  //   FilterItemModel(title: "Style1", isSelect: false.obs),
  //   FilterItemModel(title: "Round", isSelect: false.obs),
  // ].obs;

  // RxList<FilterItemModel> sizeList = <FilterItemModel>[
  //   FilterItemModel(title: "Pack of 2", isSelect: false.obs),
  //   FilterItemModel(title: "Pack of 4", isSelect: false.obs),
  //   FilterItemModel(title: "Pack of 80", isSelect: false.obs),
  //   FilterItemModel(title: "Pack of 200", isSelect: false.obs),
  //   FilterItemModel(title: "set of 1", isSelect: false.obs),
  //   FilterItemModel(title: "Large", isSelect: false.obs),
  //   FilterItemModel(title: "M", isSelect: false.obs),
  //   FilterItemModel(title: "EUR 39", isSelect: false.obs),
  //   FilterItemModel(title: "Set of 4", isSelect: false.obs),
  // ].obs;

  // RxList<FilterItemModel> qualityList = <FilterItemModel>[
  //   FilterItemModel(title: "Soft", isSelect: false.obs),
  //   FilterItemModel(title: "Medium", isSelect: false.obs),
  //   FilterItemModel(title: "Hard", isSelect: false.obs),
  // ].obs;

  // RxList<FilterItemModel> ratingsList = <FilterItemModel>[
  //   FilterItemModel(title: "3", isSelect: false.obs),
  //   FilterItemModel(title: "4", isSelect: false.obs),
  //   FilterItemModel(title: "5", isSelect: false.obs),
  // ].obs;

  final CurrentUserController currentUserController = Get.find();
  final SubCategoryController subCategoryController = Get.find();

  Rx<FilterAttributeModel> filterAttributeModel = FilterAttributeModel().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    filterAttributeApi();
    super.onInit();
  }

  void filterAttributeApi() async {
    isLoading.value = true;

    if (isLoading.value) {
      filterAttributeModel.value = FilterAttributeModel(
        data: List.filled(
          8,
          AttributeData(
            title: "name",
            attributeList: List.filled(
              8,
              AttributeList(value: "name"),
            ),
          ),
        ),
      );
    }

    var filterData = await ApiServices().filterAttributeService(
        userId: currentUserController.currentUser.value.data?.userId ?? '',
        fkCategory: subCategoryController.selectCategory.value.intGlcode ?? '');
    isLoading.value = false;
    if (filterData.status == 1) {
      filterAttributeModel.value = filterData;
    }
  }
}
