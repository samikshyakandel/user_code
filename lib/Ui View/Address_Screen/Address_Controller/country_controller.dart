import 'package:get/get.dart';

import '../../../Service/api_service.dart';
import '../Model/country_pojo.dart';
import '../Model/state_list_pojo.dart';

class CountryController extends GetxController {
  ///Add Vendor
  Rx<CountryModel> countryList = CountryModel().obs;
  Rx<CountryListData> selectCountry = CountryListData().obs;
  RxBool isOpenDropCountry = false.obs;
  RxBool isLoading = false.obs;

  Rx<StateListModel> stateList = StateListModel().obs;
  Rx<StateListData> selectState = StateListData().obs;
  RxBool isOpenDropState = false.obs;

  /*  Rx<CityListModel> cityList = CityListModel().obs;
  Rx<CityData> selectCity = CityData().obs;
  RxBool isOpenDropCity = false.obs;*/

  @override
  void onInit() {
    // countryListDrop();
    super.onInit();
  }

  Future<void> countryListDrop() async {
    isLoading.value = true;
    var countryData = await ApiServices().getAllContryService();
    isLoading.value = false;
    if (countryData.status == 1) {
      countryList.value = countryData;
      if (countryList.value.data?.isNotEmpty ?? false) {
        selectCountry.value = countryList.value.data![0];
        await stateListDrop(selectCountry.value.code);
      }
    }
  }

  Future<void> stateListDrop(selectCountryId) async {
    isLoading.value = true;
    var stateData = await ApiServices()
        .getAllStateService(countryCode: selectCountry.value.code.toString());
    isLoading.value = false;
    if (stateData.status == 1) {
      stateList.value = stateData;
      if (stateList.value.data?.isNotEmpty ?? false) {
        selectState.value = stateList.value.data![0];
        cityListDrop(selectCountry.value.intGlcode);
      }
    }
  }

  void cityListDrop(selectStateId) async {
    // addUpdateLoading.value = true;
    // cityList.value = (await ApiServices().cityListService(selectStateId))!;
    // addUpdateLoading.value = false;
  }
}
