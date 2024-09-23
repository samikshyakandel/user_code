import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'Current_User/current_user_controller.dart';
import 'Ui View/Home_View/View/main_bottom_view.dart';
import 'Utils/app_colors.dart';
import 'Utils/Routes/app_pages.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  FlutterNativeSplash.remove();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final CurrentUserController currentUserController =
      Get.put(CurrentUserController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child:
            // Obx(
            //   () => currentUserController.currentUser.value.message == null ||
            //           currentUserController.currentUser.value.message!.isEmpty
            //       ? const LoginView()
            //       :
            MainBottomView(),
        // ),
        builder: (_, child) {
          return GetMaterialApp(
            title: 'ESC - SingleVendor',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.whiteColor),
              scaffoldBackgroundColor: AppColors.whiteColor,
              useMaterial3: true,
            ),
            getPages: AppPages.generateRoute,
            home: child,
          );
        });
  }
}
