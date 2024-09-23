import 'package:get/get.dart';

import '../Service/api_service.dart';
import '../Utils/local_storage.dart';
import 'user_model.dart';

class CurrentUserController extends GetxController {
  Rx<UserModel> currentUser = UserModel().obs;
  RxString cartCount = "".obs;
  RxString currency = "".obs;

  @override
  void onInit() {
    currentUserDetailsGet();
    super.onInit();
  }

  void currentUserDetailsGet({bool? onlyUserDetailsGet}) async => {
        currentUser.value = await LocalStorage().currentUserGet(),
        if (onlyUserDetailsGet != true)
          {
            cartCountApi(),
            currenyIconApi(),
          }
      };

  void currenyIconApi() async => currency.value = await ApiServices()
      .currenyIconService(userId: currentUser.value.data?.userId ?? '');

  void favoriteAddRemoveApi({required String fkProduct}) async {
    // isLoading.value = true;
    // var homeData =
    await ApiServices().favoriteAddRemoveService(
        userId: currentUser.value.data?.userId ?? '', fkProduct: fkProduct);

    // isLoading.value = false;
    // if (homeData.status == 1) {
    //   homeModel.value = homeData;
    // }
  }

  void cartAddUpdateApi(
      {required String fkProduct,
      required String fkVariant,
      required String qty}) async {
    await ApiServices().cartAddUpdateService(
        userId: currentUser.value.data?.userId ?? '',
        fkProduct: fkProduct,
        fkVariant: fkVariant,
        qty: qty);
    cartCountApi();
  }

  void clearCartApi() async {
    await ApiServices().cartDeleteProductService(
      userId: currentUser.value.data?.userId ?? '',
      fkProduct: '',
      fkVariant: '',
    );
    cartCountApi();
  }

  void cartCountApi() async {
    cartCount.value = await ApiServices()
            .cartCountService(userId: currentUser.value.data?.userId ?? '') ??
        '';

    // cartCount.value = cartCountData ?? '';
  }
}
