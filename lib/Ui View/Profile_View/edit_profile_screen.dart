import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/button_widget.dart';
import 'package:new_user_singlevendor/Ui%20View/Profile_View/Controller/profile_controller.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_outline_widget.dart';
import '../App_Widgets/drawer_menu.dart';
import '../App_Widgets/loading_widget.dart';
import '../App_Widgets/textfield_widget.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _State();
}

class _State extends State<EditProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerMenu(),
      body: Obx(
        () => AbsorbPointer(
          absorbing: profileController.isLoading.value,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppbarWidget(
                      title: 'Profile', isDrawer: true, isSearch: false),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: profileController.profileFormGlobalKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SizedBox(height: 20.h),
                                TextFieldWidget(
                                  controller: profileController.name,
                                  headerText: "Name",
                                  hintText: "Enter You Name",
                                  validator: (nameValue) {
                                    if (nameValue!.isEmpty) {
                                      return "Enter Name";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                TextFieldWidget(
                                  enabled: false,
                                  controller: profileController.email,
                                  headerText: "E-mail",
                                  hintText: "demo@demo.com",
                                  // validator: (nameValue) {
                                  //   if (nameValue!.isEmpty) {
                                  //     return "Enter E-mail";
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(height: 14),
                                TextFieldWidget(
                                  enabled: false,
                                  controller: profileController.phone,
                                  headerText: "Phone",
                                  hintText: "Enter Your Number",
                                  // validator: (nameValue) {
                                  //   if (nameValue!.isEmpty) {
                                  //     return "Enter Phone Number";
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                const SizedBox(height: 14),
                                TextFieldWidget(
                                  controller: profileController.dob,
                                  // enabled: false,
                                  readOnly: true,
                                  onTap: () => _selectDate(context),
                                  headerText: "DOB",
                                  hintText: "yyyy-MM-dd",
                                  validator: (nameValue) {
                                    if (nameValue!.isEmpty) {
                                      return "Enter DOB";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 14),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child: Text("Gender",
                                      style: AppTextStyle.lableLarge),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text('Male'),
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: const VisualDensity(
                                            vertical:
                                                VisualDensity.minimumDensity,
                                            horizontal:
                                                VisualDensity.minimumDensity),
                                        value: 'Male',
                                        groupValue:
                                            profileController.vartypeCont,
                                        onChanged: (value) {
                                          setState(() {
                                            profileController.vartypeCont =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text('Female'),
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        value: "Female",
                                        visualDensity: const VisualDensity(
                                            vertical:
                                                VisualDensity.minimumDensity,
                                            horizontal:
                                                VisualDensity.minimumDensity),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        groupValue:
                                            profileController.vartypeCont,
                                        onChanged: (value) {
                                          setState(() {
                                            profileController.vartypeCont =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text('Other'),
                                        dense: true,
                                        contentPadding: EdgeInsets.zero,
                                        value: "Other",
                                        groupValue:
                                            profileController.vartypeCont,
                                        visualDensity: const VisualDensity(
                                            vertical:
                                                VisualDensity.minimumDensity,
                                            horizontal:
                                                VisualDensity.minimumDensity),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onChanged: (value) {
                                          setState(() {
                                            profileController.vartypeCont =
                                                value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                ButtonOutlineWidget(
                                  title: "UPDATE",
                                  onTap: () {
                                    if (profileController
                                        .profileFormGlobalKey.currentState!
                                        .validate()) {
                                      profileController.updateProfileApi();
                                    }
                                  },
                                ),

                                const SizedBox(height: 30),
                                ButtonWidget(
                                  title: "DELETE ACCOUNT",
                                  onTap: () => Get.defaultDialog(
                                    title: 'Delete Account',
                                    titleStyle: AppTextStyle.headingLarge,
                                    backgroundColor: AppColors.whiteColor,
                                    content: Column(
                                      children: [
                                        Text(
                                          'Are you sure you want to Delete Account?',
                                          style: AppTextStyle.bodyLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ButtonOutlineWidget(
                                              width: 60,
                                              title: "No",
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              onTap: () => Get.back(),
                                            ),
                                            ButtonWidget(
                                              width: 60,
                                              title: "Yes",
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              onTap: () => {
                                                Get.back(),
                                                profileController
                                                    .deleteAccountApi(),
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: profileController.isLoading.value,
                child: const Positioned(
                  child: Center(
                    child: LoadingWidget(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      profileController.dob.text =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
    }
  }
}
