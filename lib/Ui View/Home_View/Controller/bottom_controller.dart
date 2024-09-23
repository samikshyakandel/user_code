import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Current_User/current_user_controller.dart';
import '../../Categories_View/categories_screen.dart';
import '../../Order_View/order_list_screen.dart';
import '../../Profile_View/edit_profile_screen.dart';
import '../View/home_screen.dart';

class BottomController extends GetxController {
  final CurrentUserController currentUserController = Get.find();

  RxInt myIndex = 0.obs;
  final RxList<Widget> screenList = [
    HomeScreen(),
    CategoryScreen(),
    const OrderListView(),
    const EditProfileScreen(),
    // const ProfileScreen(),
  ].obs;
}
