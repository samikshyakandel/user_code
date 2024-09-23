import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';
import 'package:new_user_singlevendor/Utils/app_images.dart';

import '../../../Utils/app_constant.dart';
import '../Controller/bottom_controller.dart';

class MainBottomView extends StatelessWidget {
  MainBottomView({super.key});

  final BottomController bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      child: SafeArea(
        child: Obx(
          () => PopScope(
            canPop: bottomController.myIndex.value == 0 ? true : false,
            onPopInvoked: (didPop) {
              if (bottomController.myIndex.value == 1 ||
                  bottomController.myIndex.value == 2 ||
                  bottomController.myIndex.value == 3) {
                bottomController.myIndex.value = 0;
                return;
              }
            },
            child: Scaffold(
              backgroundColor: const Color(0xFFFFFFFF),
              body: Obx(() =>
                  bottomController.screenList[bottomController.myIndex.value]),
              bottomNavigationBar: Obx(
                () => BottomNavigationBar(
                  onTap: (index) => bottomController.currentUserController
                                  .currentUser.value.data ==
                              null &&
                          index == 2
                      ? AppConstant().loginDialog()
                      : bottomController.currentUserController.currentUser.value
                                      .data ==
                                  null &&
                              index == 3
                          ? AppConstant().loginDialog()
                          : bottomController.myIndex.value = index,
                  currentIndex: bottomController.myIndex.value,
                  items: [
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            bottomController.myIndex.value == 0
                                ? AppImages.icHome
                                : AppImages.icHomeUnfilled),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            bottomController.myIndex.value == 1
                                ? AppImages.icCatfilled
                                : AppImages.icCat),
                        label: 'Categories'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            bottomController.myIndex.value == 2
                                ? AppImages.icOrderFilled
                                : AppImages.icOrder),
                        label: 'Orders'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                            bottomController.myIndex.value == 3
                                ? AppImages.icProfileFilled
                                : AppImages.icProfile),
                        label: 'Profile'),
                  ],
                  iconSize: 24,
                  // Adjust the icon size
                  selectedItemColor: AppColors.orangeColor,
                  // Customize the selected label color
                  unselectedItemColor: AppColors.darkGrayColor,
                  // Customize the unselected label color
                  selectedLabelStyle:
                      const TextStyle(fontSize: 12, color: Color(0xFF212529)),
                  // Customize the label style
                  unselectedLabelStyle:
                      TextStyle(fontSize: 12, color: AppColors.darkGrayColor),
                  // Customize the label style
                  showSelectedLabels: true,
                  // Show labels for selected items
                  showUnselectedLabels: true,
                  // Show labels for unselected items
                  type: BottomNavigationBarType.fixed,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      // ..color = Colors.black
      ..color = const Color(0xFF0D6EFD).withOpacity(0.1)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    const double dashWidth = 5;
    const double dashSpace = 5;
    double currentX = 0;

    while (currentX < size.width) {
      canvas.drawLine(
          Offset(currentX, 0), Offset(currentX + dashWidth, 0), paint);
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ProgressIndicatorDemo extends StatefulWidget {
  const ProgressIndicatorDemo({super.key});

  @override
  State<ProgressIndicatorDemo> createState() => _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 4000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.repeat();
  }

  @override
  void dispose() {
    controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LinearProgressIndicator(
      color: Color(AppColors.orangeColor as int),
      backgroundColor: Color(Colors.white as int),
      value: animation.value,
    ));
  }
}
