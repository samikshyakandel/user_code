import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:new_user_singlevendor/Current_User/user_model.dart';
import 'package:new_user_singlevendor/Service/api_url.dart';
import 'package:new_user_singlevendor/Ui%20View/Cart_View/cart_model.dart';
import 'package:new_user_singlevendor/Ui%20View/Categories_View/Model/all_category_model.dart';
import 'package:new_user_singlevendor/Ui%20View/Categories_View/Model/sub_category_model.dart';
import 'package:new_user_singlevendor/Ui%20View/WishList_View/favorite_model.dart';

import '../Ui View/Address_Screen/Model/country_pojo.dart';
import '../Ui View/Address_Screen/Model/state_list_pojo.dart';
import '../Ui View/Checkout_View/promocode_model.dart';
import '../Ui View/Home_View/Model/home_model.dart';
import '../Ui View/Address_Screen/Model/add_edit_address_model.dart';
import '../Ui View/Address_Screen/Model/get_address_model.dart';
import '../Ui View/Home_View/Model/all_products_model.dart';
import '../Ui View/Order_View/Model/get_order_list_model.dart';
import '../Ui View/Order_View/Model/order_details_model.dart';
import '../Ui View/Product_Details_View/Model/product_details_model.dart';
import '../Ui View/Product_Details_View/Model/variant_model.dart';
import '../Ui View/Product_Filter/filter_attribute_model.dart';
import '../Ui View/Search_View/model/search_model.dart';
import '../Ui View/Search_View/model/search_suggetion_model.dart';
import '../Utils/app_constant.dart';

class ApiServices {
  final Dio _dio = Dio();
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<UserModel> logInService({
    required String email,
    required String password,
  }) async {
    String fcmToken = '';
    // if (Platform.isAndroid) {
    //   fcmToken = await messaging.getToken() ?? '';
    //   if (kDebugMode) {
    //     print(fcmToken);
    //   }
    // }

    // if (Platform.isIOS) {
    //   fcmToken = await messaging.getAPNSToken() ?? '';
    //   if (kDebugMode) {
    //     print(fcmToken);
    //   }
    // }

    var formData = FormData.fromMap({
      "var_email": email,
      "var_password": password,
      "var_device_token": fcmToken
    });

    try {
      Response response = await _dio.request(ApiUrl.baseUrl + ApiUrl.loginUrl,
          options: Options(
            method: 'POST',
          ),
          data: formData);
      if (response.data['status'] != 0) {
        return UserModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return UserModel();
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        if (kDebugMode) {
          print(e.response?.data);
          print(e.response?.headers);
          print(e.response?.requestOptions);
        }
      } else {
        if (kDebugMode) {
          print(e.requestOptions);
          print(e.message);
        }
      }
      return UserModel();
    }
  }

  Future<UserModel> signUpService({
    required String email,
    required String varMobileNo,
    required String varName,
    required String varPassword,
  }) async {
    var fcmToken = "";
    //await messaging.getToken() ?? '';
    // if (kDebugMode) {
    //   print(fcmToken);
    // }
    var formData = FormData.fromMap({
      "var_email": email,
      "var_mobile_no": varMobileNo,
      "var_name": varName,
      "var_password": varPassword,
      "var_device_token": fcmToken
    });

    try {
      Response response = await _dio.request(ApiUrl.baseUrl + ApiUrl.signupUrl,
          options: Options(
            method: 'POST',
          ),
          data: formData);

      if (response.data['status'] != 0) {
        return UserModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return UserModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return UserModel();
    }
  }

  Future<HomeModel> homeService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response = await _dio.request(ApiUrl.baseUrl + ApiUrl.homeUrl,
          options: Options(
            method: 'POST',
          ),
          data: formData);

      if (response.data['status'] != 0) {
        return HomeModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return HomeModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return HomeModel();
    }
  }

  Future<void> favoriteAddRemoveService(
      {required String userId, required String fkProduct}) async {
    var formData =
        FormData.fromMap({"user_id": userId, "fk_product": fkProduct});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.addRemoveWishlistUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        if (kDebugMode) {
          print(response.data['message']);
        }
        // return HomeModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        // return HomeModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      // return HomeModel();
    }
  }

  Future<String?> cartCountService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.cartCountUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        return response.data['data'];
        // return HomeModel.fromJson(response.data);
      } else {
        // AppConstant().snackbars("Error", response.data['message']);
        return '';
        // HomeModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return '';
    }
  }

  Future<void> cartAddUpdateService(
      {required String userId,
      required String fkProduct,
      required String fkVariant,
      required String qty}) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "fk_product": fkProduct,
      "fk_variant": fkVariant,
      "var_qty": qty,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.addUpdateCartUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        if (kDebugMode) {
          print(response.data['message']);
        }
      } else {
        AppConstant().snackbars("Error", response.data['message']);
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
    }
  }

  Future<void> cartDeleteProductService(
      {required String userId,
      required String fkProduct,
      required String fkVariant}) async {
    var formData = FormData.fromMap(
        {"user_id": userId, "fk_product": fkProduct, "fk_variant": fkVariant});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.deleteCartProductUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        if (kDebugMode) {
          print(response.data['message']);
        }
        // return HomeModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        // return HomeModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      // return HomeModel();
    }
  }

  Future<GetOrderListModel> getOrderListService(
      {required String userId}) async {
    var formData = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.getOrderListUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return GetOrderListModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return GetOrderListModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return GetOrderListModel();
    }
  }

  Future<OrderDetailsModel> orderDetailsService(
      {required String userId, required String fkOrder}) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "fk_order": fkOrder,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.getOrderDetailUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return OrderDetailsModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return OrderDetailsModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return OrderDetailsModel();
    }
  }

  Future<CountryModel> getAllContryService() async {
    try {
      Response response = await _dio.request(
        ApiUrl.baseUrl + ApiUrl.getAllcontryUrl,
        options: Options(
          method: 'POST',
        ),
      );
      if (response.data['status'] != 0) {
        return CountryModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return CountryModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return CountryModel();
    }
  }

  Future<StateListModel> getAllStateService(
      {required String countryCode}) async {
    try {
      var formData = FormData.fromMap({
        "contry_code": countryCode,
      });

      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.getAllStateUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        return StateListModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return StateListModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return StateListModel();
    }
  }

  Future<GetAddressModel> getAddressService({required String userId}) async {
    var formData = FormData.fromMap({
      "user_id": userId,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.getAddressListUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        return GetAddressModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return GetAddressModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return GetAddressModel();
    }
  }

  Future<GetAddressModel> deleteAdderssService(
      {required String fkAddress}) async {
    var formData = FormData.fromMap({
      "fk_address": fkAddress,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.deleteAdderssUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        return GetAddressModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return GetAddressModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return GetAddressModel();
    }
  }

  Future<AddEditAddressModel> addUpdateAddressService({
    required String userId,
    required String varhouseno,
    required String varapartment,
    required String varlandmark,
    required String varcountry,
    required String varstate,
    required String varcity,
    required String varpincode,
    required String vartype,
    required String defaultstatus,
    required String fkaddress,
  }) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "var_house_no": varhouseno,
      "var_apartment": varapartment,
      "var_landmark": varlandmark,
      "var_country": varcountry,
      "var_state": varstate,
      "var_city": varcity,
      "var_pincode": varpincode,
      "var_type": vartype,
      "default_status": defaultstatus,
      "fk_address": fkaddress,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.addUpdateAddressUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return AddEditAddressModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return AddEditAddressModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return AddEditAddressModel();
    }
  }

  Future<AllCategoryModel> allCategoryService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.allCaterogyUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return AllCategoryModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return AllCategoryModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return AllCategoryModel();
    }
  }

  Future<SubCategoryModel> subCategoryService(
      {required String userId,
      required String fkCategory,
      required List<String> attributeList,
      required String sortBy,
      required String minPrice,
      required String maxPrice,
      required int page}) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "fk_category": fkCategory,
      "attrs": jsonEncode(attributeList),
      "sort_by": sortBy,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
      "page": page
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.subCaterogyUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return SubCategoryModel.fromJson(response.data);
      } else {
        // AppConstant().snackbars("Error", response.data['message']);
        return SubCategoryModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return SubCategoryModel();
    }
  }

  Future<FavoriteModel> favoriteListService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.favoriteListUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return FavoriteModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return FavoriteModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return FavoriteModel();
    }
  }

  Future<CartModel> cartListService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.cartListUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return CartModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return CartModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return CartModel();
    }
  }

  Future<ProductDetailsModel> productDetailsService(
      {required String userId, required String fkProduct}) async {
    var formData =
        FormData.fromMap({"user_id": userId, "fk_product": fkProduct});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.productDetailsUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return ProductDetailsModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return ProductDetailsModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return ProductDetailsModel();
    }
  }

  Future<VariantModel> changeVariantService(
      {required String userId,
      required String productId,
      required String attributeId}) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "product_id": productId,
      "attribute_id": attributeId
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.changeVarientUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return VariantModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return VariantModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return VariantModel();
    }
  }

  Future<int> placeOrderService({
    required String userId,
    required String paymentMode,
    required String paymentId,
    required String shippingCharge,
    required String promocode,
    required String cashback,
    required String adressId,
    required String phone,
  }) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "var_payment_mode": paymentMode,
      "var_payment_id": paymentId,
      "shipping_charge": shippingCharge,
      "var_promocode": promocode,
      "cashback": cashback,
      "var_adress_id": adressId,
      "var_phone": phone
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.placeOrderUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return response.data['status'];
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return 0;
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return 0;
    }
  }

  Future<UserModel> updateProfileService({
    required String userId,
    required String varName,
    required String chrGender,
    required String varDob,
  }) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "var_name": varName,
      "chr_gender": chrGender,
      "var_dob": varDob,
    });
    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.updateProfileUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        AppConstant().snackbars("Success", response.data['message']);
        return UserModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return UserModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return UserModel();
    }
  }

  Future<UserModel> changePasswordService({
    required String userId,
    required String varCpassword,
    required String varNpassword,
  }) async {
    var formData = FormData.fromMap({
      "fk_user": userId,
      "var_cpassword": varCpassword,
      "var_npassword": varNpassword,
    });
    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.changePasswordUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        AppConstant().snackbars("", response.data['message']);
        return UserModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return UserModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return UserModel();
    }
  }

  Future<UserModel> profileService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});
    try {
      Response response = await _dio.request(ApiUrl.baseUrl + ApiUrl.accountUrl,
          options: Options(
            method: 'POST',
          ),
          data: formData);

      if (response.data['status'] != 0) {
        return UserModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return UserModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return UserModel();
    }
  }

  Future<PromocodeModel> promocodeService({
    required String userId,
    required String couponCode,
    required String totalAmount,
    required String totalTax,
    required String totalDiscount,
  }) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "coupon_code": couponCode,
      "total_amount": totalAmount,
      "total_tax": totalTax,
      "total_discount": totalDiscount
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.promocodeUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      // if (response.data['status'] != 0) {
      return PromocodeModel.fromJson(response.data);
      // } else {
      //   AppConstant().snackbars("Error", response.data['message']);
      //   return PromocodeModel();
      // }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return PromocodeModel();
    }
  }

  Future<SearchModel> searchService(
      {required String userId, required String keywords}) async {
    var formData =
        FormData.fromMap({"user_id": userId, "var_keywords": keywords});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.searchAllUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return SearchModel.fromJson(response.data);
      } else {
        ///  AppConstant().snackbars("Error", response.data['message']);
        return SearchModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return SearchModel();
    }
  }

  Future<SearchSuggetionModel> searchSuggetionService(
      {required String userId, required String keywords}) async {
    var formData =
        FormData.fromMap({"user_id": userId, "var_keywords": keywords});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.searchSuggationsUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return SearchSuggetionModel.fromJson(response.data);
      } else {
        // AppConstant().snackbars("Error", response.data['message']);
        return SearchSuggetionModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return SearchSuggetionModel();
    }
  }

  Future<UserModel> orderReturnService({
    required String userId,
    required String fkProduct,
    required String fkVariant,
    required String returnText,
    required String orderId,
    required String qty,
  }) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "fk_product": fkProduct,
      "fk_variant": fkVariant,
      "return_text": returnText,
      "order_id": orderId,
      "qty": qty
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.orderReturnUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        AppConstant().snackbars("Success", response.data['message']);
        return UserModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return UserModel();
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
      } else {}
      return UserModel();
    }
  }

  Future<int> addReviewService({
    required String userId,
    required String fkProduct,
    required String rating,
    required String reviewText,
    required String fkVariant,
    required String fkOrder,
  }) async {
    var formData = FormData.fromMap({
      "user_id": userId,
      "fk_product": fkProduct,
      "rating": rating,
      "review_text": reviewText,
      "fk_variant": fkVariant,
      "fk_order": fkOrder
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.addReviewUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        return response.data['status'];
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return 0;
      }
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
      } else {}
      return 0;
    }
  }

  Future<OrderDetailsModel> cancelOrderService(
      {required String fkOrder}) async {
    var formData = FormData.fromMap({
      "order_id": fkOrder,
    });

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.cancelOrderUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        AppConstant().snackbars("", response.data['message']);
        return OrderDetailsModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return OrderDetailsModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return OrderDetailsModel();
    }
  }

  Future<AllProductsModel> offerAllProductsService(
      {required String userId, required int page}) async {
    var formData = FormData.fromMap({"user_id": userId, "page": page});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.offerAllProductsUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return AllProductsModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return AllProductsModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return AllProductsModel();
    }
  }

  Future<AllProductsModel> hotAllProductsService(
      {required String userId, required int page}) async {
    var formData = FormData.fromMap({"user_id": userId, "page": page});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.hotAllProductsUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return AllProductsModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return AllProductsModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return AllProductsModel();
    }
  }

  Future<FilterAttributeModel> filterAttributeService(
      {required String userId, required String fkCategory}) async {
    var formData =
        FormData.fromMap({"user_id": userId, "fk_category": fkCategory});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.filterAttributeUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);

      if (response.data['status'] != 0) {
        return FilterAttributeModel.fromJson(response.data);
      } else {
        AppConstant().snackbars("Error", response.data['message']);
        return FilterAttributeModel();
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return FilterAttributeModel();
    }
  }

  Future<String> currenyIconService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.currenyIconUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        return response.data['currency'];
      } else {
        // AppConstant().snackbars("Error", response.data['message']);
        return '';
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return '';
    }
  }

  Future<int> deleteAcountService({required String userId}) async {
    var formData = FormData.fromMap({"user_id": userId});

    try {
      Response response =
          await _dio.request(ApiUrl.baseUrl + ApiUrl.deleteAccountUrl,
              options: Options(
                method: 'POST',
              ),
              data: formData);
      if (response.data['status'] != 0) {
        AppConstant().snackbars("Success", response.data['message']);
        return response.data['status'];
      } else {
        // AppConstant().snackbars("Error", response.data['message']);
        return 0;
      }
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return 0;
    }
  }
}
