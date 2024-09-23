import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/Address_Screen/add_address.dart';
import 'package:new_user_singlevendor/Ui%20View/Address_Screen/adress_list.dart';
import 'package:new_user_singlevendor/Ui%20View/Auth_View/View/forgot_password_view.dart';
import 'package:new_user_singlevendor/Ui%20View/Auth_View/View/otp_verification.dart';
import 'package:new_user_singlevendor/Ui%20View/Cart_View/cart_screen.dart';
import 'package:new_user_singlevendor/Ui%20View/Checkout_View/checkout_view.dart';
import 'package:new_user_singlevendor/Ui%20View/Checkout_View/order_success.dart';
import 'package:new_user_singlevendor/Ui%20View/Order_View/order_detail.dart';
import 'package:new_user_singlevendor/Ui%20View/Order_View/return_order.dart';
import 'package:new_user_singlevendor/Ui%20View/Product_Details_View/product_details.dart';
import 'package:new_user_singlevendor/Ui%20View/Product_Review_View/give_review.dart';
import 'package:new_user_singlevendor/Ui%20View/WishList_View/favorite_product.dart';

import '../../Ui View/Auth_View/View/login_view.dart';
import '../../Ui View/Auth_View/View/singup_view.dart';
import '../../Ui View/Categories_View/sub_categories_screen.dart';
import '../../Ui View/Home_View/View/all_products.dart';
import '../../Ui View/Home_View/View/main_bottom_view.dart';
import '../../Ui View/Policy_View/refund_policy.dart';
import '../../Ui View/Policy_View/shipping_policy.dart';
import '../../Ui View/Profile_View/change_password_view.dart';
import '../../Ui View/Search_View/search_view.dart';
import 'app_routes.dart';

class AppPages {
  static Transition transition = Transition.circularReveal;
  static Duration transitionDuration = const Duration();
  static Curve curve = Curves.easeInCirc;

  static final generateRoute = [
    GetPage(
        name: AppRoutes.productDetails,
        page: () => ProductDetailsView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.addAddress,
        page: () => const AddAddressView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.cartView,
        page: () => const CartView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.otpVerifyView,
        page: () => const OtpVerificationView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.forgotPassword,
        page: () => const ForgotPasswordView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.mainBottomView,
        page: () => MainBottomView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.singUp,
        page: () => const SignUpView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.loginView,
        page: () => const LoginView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.checkout,
        page: () => CheckoutView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.giveMeReview,
        page: () => GiveRatingView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.orderDetails,
        page: () => OrderDetailScreen(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.addressListView,
        page: () => AddressListView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.subCategory,
        page: () => const SubCategoryScreen(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.wishListView,
        page: () => FavoriteProduct(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.searchView,
        page: () => SearchView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.shippingPolicy,
        page: () => const ShippingPolicy(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.refundPolicy,
        page: () => const RefundPolicy(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.changePasswordView,
        page: () => const ChangePasswordView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.returnOrderView,
        page: () => ReturnOrderView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.orderSuccessView,
        page: () => const OrderSuccess(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
    GetPage(
        name: AppRoutes.allProductsView,
        page: () => const AllProductsView(),
        curve: curve,
        transitionDuration: transitionDuration,
        transition: transition),
  ];
}
