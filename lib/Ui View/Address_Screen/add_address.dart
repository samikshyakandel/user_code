import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_user_singlevendor/Ui%20View/App_Widgets/Dropdown_Widget_View/state_drop_widget.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_textstyle.dart';
import '../App_Widgets/Dropdown_Widget_View/country_drop_widget.dart';
import '../App_Widgets/appbar_widget.dart';
import '../App_Widgets/button_widget.dart';
import '../App_Widgets/loading_widget.dart';
import '../App_Widgets/textfield_widget.dart';
import 'Address_Controller/add_edit_address_controller.dart';
import 'Address_Controller/country_controller.dart';

class AddAddressView extends StatefulWidget {
  const AddAddressView({super.key});

  @override
  State<AddAddressView> createState() => _AddAddressViewState();
}

class _AddAddressViewState extends State<AddAddressView> {
  final AddEditAddressController addEditAddressController =
      Get.put(AddEditAddressController());
  final CountryController countryController = Get.put(CountryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidget(
              title: addEditAddressController.addressDataArg.intGlcode == null
                  ? "Add Address"
                  : "Edit Address",
              isCart: false,
              isSearch: false,
            ),
            Expanded(
              child: Obx(
                () => AbsorbPointer(
                  absorbing: addEditAddressController.isLoading.value,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Form(
                          key: addEditAddressController
                              .addEditAddressFormGlobalKey,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*TextFieldWidget(
                                      controller: addEditAddressController.varcountryCont,
                                      hintText: "India",
                                      suffixIcon: const InkWell(
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      validator: (nameValue) {
                                        if (nameValue!.isEmpty) {
                                          return "Enter Country";
                                        }
                                        return null;
                                      },
                                    ),*/
                                  // CountryDropDownWidget(items: addEditAddressController.countryModel.value),
                                  SizedBox(height: 10.h),
                                  TextFieldWidget(
                                    controller:
                                        addEditAddressController.varhousenoCont,
                                    headerText: "Flat, House No., Comapny",
                                    hintText: "Enter Your Name",
                                    validator: (nameValue) {
                                      if (nameValue!.isEmpty) {
                                        return "Enter House No.";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFieldWidget(
                                    controller: addEditAddressController
                                        .varapartmentCont,
                                    headerText: "Area, Street, Sector, Village",
                                    hintText: "Enter Your Address",
                                    validator: (nameValue) {
                                      if (nameValue!.isEmpty) {
                                        return "Enter Address";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFieldWidget(
                                    controller: addEditAddressController
                                        .varlandmarkCont,
                                    headerText: "Landmark",
                                    hintText: "Enter Your Landmark",
                                    validator: (nameValue) {
                                      if (nameValue!.isEmpty) {
                                        return "Enter Landmark";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFieldWidget(
                                    controller:
                                        addEditAddressController.varpincodeCont,
                                    headerText: "Pincode",
                                    hintText: "Enter Your Pincode",
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(8),
                                    ],
                                    validator: (nameValue) {
                                      if (nameValue!.isEmpty) {
                                        return "Enter Pincode";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  TextFieldWidget(
                                    controller:
                                        addEditAddressController.varcityCont,
                                    headerText: "Town/City",
                                    hintText: "Enter Your Town/City",
                                    validator: (nameValue) {
                                      if (nameValue!.isEmpty) {
                                        return "Enter City";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 10.h),
                                  Obx(
                                    () => CountryDropDownWidget(
                                      showSearchBox: true,
                                      onBeforePopupOpening:
                                          (selectedItem) async {
                                        countryController
                                            .isOpenDropCountry.value = true;
                                        return true;
                                      },
                                      onDismissed: () => countryController
                                          .isOpenDropCountry.value = false,
                                      lable: "Country",
                                      hint: 'Search Country',
                                      value: countryController
                                                  .selectCountry.value.name ==
                                              null
                                          ? null
                                          : countryController
                                              .selectCountry.value,
                                      items: countryController
                                              .countryList.value.data ??
                                          [],
                                      onChanged: (value) {
                                        // addEditAddressController.varcountryCont =
                                        //     countryController.selectCountry.value.name!;
                                        countryController.selectCountry.value =
                                            value!;
                                        countryController.stateListDrop(
                                            countryController
                                                .selectCountry.value.code);
                                      },
                                      isOpen: countryController
                                          .isOpenDropCountry.value,
                                    ),
                                  ),
                                  /* TextFieldWidget(
                                      controller: addEditAddressController.varstateCont,
                                      headerText: "State",
                                      hintText: "Select",
                                      suffixIcon: const InkWell(
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      validator: (nameValue) {
                                        if (nameValue!.isEmpty) {
                                          return "Enter State";
                                        }
                                        return null;
                                      },
                                    ),*/
                                  SizedBox(height: 10.h),
                                  StateDropDownWidget(
                                    showSearchBox: true,
                                    onBeforePopupOpening: (selectedItem) async {
                                      countryController.isOpenDropState.value =
                                          true;
                                      return true;
                                    },
                                    onDismissed: () => countryController
                                        .isOpenDropState.value = false,
                                    lable: "State",
                                    hint: 'Search State',
                                    value: countryController
                                                .selectState.value.stateName ==
                                            null
                                        ? null
                                        : countryController.selectState.value,
                                    items: countryController
                                            .stateList.value.data ??
                                        [],
                                    onChanged: (value) {
                                      // addEditAddressController.varstateCont =
                                      //     countryController
                                      //         .selectState.value.stateName!;
                                      countryController.selectState.value =
                                          value!;
                                      // countryController.stateList.value = value! as StateListModel;
                                    },
                                    isOpen: countryController
                                        .isOpenDropCountry.value,
                                  ),
                                  SizedBox(height: 10.h),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    child: Text("Address Type",
                                        style: AppTextStyle.lableLarge),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: RadioListTile<String>(
                                          title: const Text('Home'),
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: const VisualDensity(
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                              horizontal:
                                                  VisualDensity.minimumDensity),
                                          value: 'Home',
                                          activeColor: AppColors.orangeColor,
                                          groupValue: addEditAddressController
                                              .vartypeCont,
                                          onChanged: (value) {
                                            setState(() {
                                              addEditAddressController
                                                  .vartypeCont = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<String>(
                                          title: const Text('Office'),
                                          dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          value: "Office",
                                          activeColor: AppColors.orangeColor,
                                          visualDensity: const VisualDensity(
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                              horizontal:
                                                  VisualDensity.minimumDensity),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          groupValue: addEditAddressController
                                              .vartypeCont,
                                          onChanged: (value) {
                                            setState(() {
                                              addEditAddressController
                                                  .vartypeCont = value!;
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
                                          activeColor: AppColors.orangeColor,
                                          groupValue: addEditAddressController
                                              .vartypeCont,
                                          visualDensity: const VisualDensity(
                                              vertical:
                                                  VisualDensity.minimumDensity,
                                              horizontal:
                                                  VisualDensity.minimumDensity),
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          onChanged: (value) {
                                            setState(() {
                                              addEditAddressController
                                                  .vartypeCont = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Obx(
                                          () => Checkbox(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            visualDensity: const VisualDensity(
                                                horizontal: VisualDensity
                                                    .minimumDensity,
                                                vertical: VisualDensity
                                                    .minimumDensity),
                                            activeColor: AppColors.greenColor,
                                            value: addEditAddressController
                                                .defaultType.value,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                addEditAddressController
                                                    .defaultType.value = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Set Default",
                                          style: AppTextStyle.bodyTextGray,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ]),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: addEditAddressController.isLoading.value,
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
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10.w, left: 20, right: 20),
              child: ButtonWidget(
                title: addEditAddressController.addressDataArg.intGlcode == null
                    ? "ADD ADDRESS"
                    : "UPDATE ADDRESS",
                onTap: () {
                  if (addEditAddressController
                      .addEditAddressFormGlobalKey.currentState!
                      .validate()) {
                    addEditAddressController.addUpdateAddressAPI();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
