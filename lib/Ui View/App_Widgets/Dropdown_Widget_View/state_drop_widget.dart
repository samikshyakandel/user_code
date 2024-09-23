import 'dart:math' as math;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_user_singlevendor/Utils/app_colors.dart';

import '../../Address_Screen/Model/state_list_pojo.dart';

class StateDropDownWidget extends StatelessWidget {
  final String lable;
  final String hint;
  final StateListData? value;
  final bool showSearchBox;
  final bool isOpen;
  final List<StateListData> items;
  final void Function(StateListData?)? onChanged;
  final void Function()? onDismissed;
  final Future<bool?> Function(StateListData?)? onBeforePopupOpening;

  const StateDropDownWidget(
      {super.key,
        required this.lable,
        required this.hint,
        required this.value,
        required this.showSearchBox,
        required this.isOpen,
        required this.items,
        this.onChanged,
        this.onDismissed,
        required this.onBeforePopupOpening});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (lable.isNotEmpty) ...[
          Text(
            lable,
            maxLines: 1,
            style: textTheme.bodyLarge,
          ),
          SizedBox(height: 10.h),
        ],
        Theme(
          data: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.greyColor),
          ),
          child: DropdownSearch<StateListData>(
            onBeforePopupOpening: onBeforePopupOpening,
            autoValidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null) {
                return 'Select State';
              }
              return null;
            },
            popupProps: PopupProps.menu(
                onDismissed: onDismissed,
                showSearchBox: showSearchBox,
                showSelectedItems: false,
                searchFieldProps: searchFieldProps(textTheme),
                fit: FlexFit.loose
            ),
            items: items,
            // asyncItems: asyncItems,
            itemAsString: (StateListData u) => u.stateName ?? '',

            dropdownButtonProps: dropdownButtonProps(),
            dropdownDecoratorProps: decorationWidget(textTheme),
            onChanged: onChanged,
            selectedItem: value,
          ),
        ),
      ],
    );
  }

  TextFieldProps searchFieldProps(TextTheme textTheme) {
    return TextFieldProps(
      decoration: InputDecoration(
        fillColor: AppColors.greyLightColor,
        isDense: true,
        contentPadding: EdgeInsets.all(12.w),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.blackColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.greyColor),
        ),
        border: const OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.orangeColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.orangeColor),
        ),
      ),
    );
  }

  DropDownDecoratorProps decorationWidget(TextTheme textTheme) {
    return DropDownDecoratorProps(
      dropdownSearchDecoration: InputDecoration(
        fillColor: AppColors.greyLightColor,
        isDense: true,
        contentPadding: EdgeInsets.all(12.w),
        hintText: hint,
        focusedBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.blackColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.greyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.greyColor),
        ),
        border: const OutlineInputBorder(
          borderRadius:
          BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.orangeColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
          const BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
              width: 1, color: AppColors.orangeColor),
        ),
      ),
    );
  }

  DropdownButtonProps dropdownButtonProps() {
    return DropdownButtonProps(
      // isSelected: true,
      icon: Transform.rotate(
        angle: isOpen ? 180 * math.pi / 72 : 180 * math.pi / 90,
        child: Icon(
          Icons.arrow_drop_down,
          color: isOpen ? AppColors.blackColor : AppColors.greyColor,
        ),
      ),
      iconSize: 16.w,
    );
  }
}
