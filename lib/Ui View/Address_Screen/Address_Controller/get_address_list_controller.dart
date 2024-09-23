import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../../Checkout_View/checkout_controller.dart';
import '../Model/get_address_model.dart';

class GetAddressListController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  RxBool isLoading = false.obs;
  Rx<GetAddressModel> getAddressModel = GetAddressModel().obs;

  @override
  void onInit() {
    getAddressAPI(showLoading: true);
    super.onInit();
  }

  void getAddressAPI({required bool showLoading}) async {
    if (showLoading) {
      isLoading.value = true;
    }

    if (isLoading.value) {
      getAddressModel.value = GetAddressModel(
        data: List.filled(
          15,
          AddressData(
            chrType: "name",
            varAppName: "name",
            varCity: "name",
            varCountry: "name",
            varHouseNo: "name",
            varLandmark: "name",
            varPincode: "name",
            varState: "name",
          ),
        ),
      );
    }

    var addressData = await ApiServices().getAddressService(
        userId: currentUserController.currentUser.value.data?.userId ?? '');
    isLoading.value = false;
    if (addressData.status == 1) {
      getAddressModel.value = addressData;
      addressData.data?.forEach((element) {
        if (element.defaultStatus == 'Y') {
          final CheckoutController checkoutController =
              Get.put(CheckoutController());
          checkoutController.selectAddress.value = element;
        }
      });
    }
  }

  void deleteAdderssAPI(String? fkAddress) async {
    isLoading.value = true;
    var addressData =
        await ApiServices().deleteAdderssService(fkAddress: fkAddress ?? '');
    isLoading.value = false;
    if (addressData.status == 1) {
      getAddressAPI(showLoading: false);
    }
  }
}
