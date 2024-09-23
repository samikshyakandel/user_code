// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Address_Screen/Model/country_pojo.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../../Service/api_service.dart';
import '../Model/get_address_model.dart';
import '../Model/state_list_pojo.dart';
import 'country_controller.dart';
import 'get_address_list_controller.dart';

class AddEditAddressController extends GetxController {
  final addressDataArg = Get.arguments as AddressData;
  final CurrentUserController currentUserController = Get.find();

  final CountryController countryController = Get.put(CountryController());

  RxBool isLoading = false.obs;
  final addEditAddressFormGlobalKey = GlobalKey<FormState>();
  var varhousenoCont = TextEditingController();
  var varapartmentCont = TextEditingController();
  var varlandmarkCont = TextEditingController();
  var varcityCont = TextEditingController();
  var varpincodeCont = TextEditingController();
  var vartypeCont = "Home";
  RxString dType = "Y".obs;
  RxBool defaultType = true.obs;

  @override
  void onInit() async {
    isLoading.value = true;
    await countryController.countryListDrop();
    if (addressDataArg.intGlcode != null) {
      editAddAddress();
    }
    isLoading.value = false;
    super.onInit();
  }

  void editAddAddress() {
    countryController.selectCountry.value = CountryListData(
        name: addressDataArg.varCountry ?? '', code: '0', intGlcode: '0');
    countryController.selectState.value = StateListData(
      stateName: addressDataArg.varState ?? '',
      countryCode: '0',
      id: '0',
      stateCode: '0',
    );
    varhousenoCont.text = addressDataArg.varHouseNo ?? '';
    varapartmentCont.text = addressDataArg.varAppName ?? '';
    varlandmarkCont.text = addressDataArg.varLandmark ?? '';
    varpincodeCont.text = addressDataArg.varPincode ?? '';
    varcityCont.text = addressDataArg.varCity ?? '';

    vartypeCont = addressDataArg.chrType ?? '';
    defaultType.value = addressDataArg.defaultStatus == "Y" ? true : false;
  }

  void addUpdateAddressAPI() async {
    if (defaultType == true) {
      dType.value = "Y";
    } else {
      dType.value = "N";
    }
    isLoading.value = true;
    var addressData = await ApiServices().addUpdateAddressService(
      userId: currentUserController.currentUser.value.data?.userId ?? '',
      varhouseno: varhousenoCont.text,
      varapartment: varapartmentCont.text,
      varlandmark: varlandmarkCont.text,
      varcountry: countryController.selectCountry.value.name ?? '',
      varstate: countryController.selectState.value.stateName ?? '',
      varcity: varcityCont.text,
      varpincode: varpincodeCont.text,
      vartype: vartypeCont.toString(),
      defaultstatus: dType.value,
      fkaddress: addressDataArg.intGlcode ?? '',
    );
    isLoading.value = false;
    if (addressData.status == 1) {
      Get.back();
      final GetAddressListController getAddressListController = Get.find();
      getAddressListController.getAddressAPI(showLoading: false);
    }
  }
}
