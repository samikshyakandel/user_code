import 'dart:convert';

import 'package:new_user_singlevendor/Current_User/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const currentUser = "currentUser";
  Future<void> currentUserSet(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userdetails = jsonEncode(UserModel.fromJson(userModel.toJson()));

    await prefs.setString(currentUser, userdetails);
  }

  Future<UserModel> currentUserGet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel user = UserModel();
    if (prefs.getString(currentUser) != null) {
      Map<String, dynamic> userdetailsMap =
          jsonDecode(prefs.getString(currentUser)!);
      user = UserModel.fromJson(userdetailsMap);
    }
    return user;
  }

  Future<void> removeCurrentUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(currentUser);
  }
}
