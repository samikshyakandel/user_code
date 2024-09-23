import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../Current_User/current_user_controller.dart';
import '../../Service/api_service.dart';
import '../../Utils/Routes/app_routes.dart';
import '../Address_Screen/Address_Controller/get_address_list_controller.dart';
import '../Address_Screen/Model/get_address_model.dart';
import '../Cart_View/cart_controller.dart';
import '../Order_View/OrderList_Controller/get_order_list_controller.dart';
import 'promocode_model.dart';

class CheckoutController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  final CartController cartController = Get.put(CartController());
  RxBool isLoading = false.obs;

  RxList paymentOption = List.filled(2, false, growable: true).obs;
  RxBool isPrivacy = false.obs;
  var promocodeCont = TextEditingController();

  Rx<PromocodeModel> promocodeModel = PromocodeModel().obs;

  Rx<AddressData> selectAddress = AddressData().obs;
  final GetAddressListController getAddressListController =
      Get.put(GetAddressListController());

  @override
  void onInit() {
    paymentOption[1] = true;
    cartController.cartListApi(isLoadingShow: false);
    getAddressListController.getAddressAPI(showLoading: false);
    super.onInit();
  }

  void placeOrderApi() async {
    isLoading.value = true;

    var placeData = await ApiServices().placeOrderService(
      userId: currentUserController.currentUser.value.data?.userId ?? '',
      adressId: selectAddress.value.intGlcode ?? '',
      cashback: '',
      paymentId: '',
      paymentMode: paymentOption[0] == true ? "O" : "C",
      phone: currentUserController.currentUser.value.data?.varMobileNo ?? '',
      promocode: promocodeModel.value.promocode ?? '',
      shippingCharge: '0',
    );
    isLoading.value = false;
    if (placeData == 1) {
      Get.offAllNamed(AppRoutes.orderSuccessView);
      final GetOrderListController getOrderListController =
          Get.put(GetOrderListController());

      getOrderListController.getOrderListAPI(isLoadingShow: false);
      currentUserController.cartCountApi();
    }
  }

  void promocodeApi() async {
    isLoading.value = true;

    var promoData = await ApiServices().promocodeService(
      userId: currentUserController.currentUser.value.data?.userId ?? '',
      couponCode: promocodeCont.text,
      totalAmount: cartController.cartListModel.value.subTotal ?? '',
      totalDiscount:
          cartController.cartListModel.value.discountTotal?.value ?? '',
      totalTax: cartController.cartListModel.value.gstTotal ?? '',
    );
    isLoading.value = false;
    promocodeModel.value = promoData;
    if (promoData.status == "1") {
      cartController.cartListModel.value.discountTotal?.value =
          promoData.discountPrice.toString();
      cartController.cartListModel.value.grossTotal?.value =
          promoData.paybleAmount.toString();
    } else {
      cartController.cartListApi(isLoadingShow: false);
      // promocodeCont.clear();
    }
  }
}
