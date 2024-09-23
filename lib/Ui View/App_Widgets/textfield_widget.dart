import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../Utils/app_colors.dart';
import '../../Utils/app_textstyle.dart';

class TextFieldWidget extends StatelessWidget {
  final String? headerText;
  final TextEditingController? controller;
  final String? initialValue;
  final bool? enabled;
  final String? hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final double? borderRadius;
  final TextAlign? textAlign;
  final int? minLines;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final Color? borderColor;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;

  const TextFieldWidget(
      {super.key,
      this.headerText,
      this.controller,
      this.initialValue,
      this.enabled,
      this.hintText,
      this.validator,
      this.inputFormatters,
      this.keyboardType,
      this.textInputAction,
      this.borderRadius,
      this.textAlign,
      this.minLines,
      this.maxLines,
      this.contentPadding,
      this.onChanged,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText = false,
      this.readOnly = false,
      this.borderColor,
      this.onFieldSubmitted,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (headerText?.isNotEmpty ?? false) ...[
          Text(headerText ?? '', style: AppTextStyle.lableLarge),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          enabled: enabled,
          readOnly: readOnly,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          onTapOutside: (event) =>
              FocusManager.instance.primaryFocus?.unfocus(),
          cursorColor: AppColors.blackColor,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          textAlign: textAlign ?? TextAlign.start,
          minLines: minLines,
          maxLines: maxLines ?? 1,
          obscureText: obscureText,
          style: AppTextStyle.bodyLarge
              .copyWith(color: enabled == false ? AppColors.gray : null),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding ?? const EdgeInsets.all(12),
            hintText: hintText,
            hintStyle: AppTextStyle.bodyLarge.copyWith(color: AppColors.gray),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            prefixIconConstraints:
                const BoxConstraints(minWidth: 30, maxWidth: 30),
            filled: true,
            fillColor: AppColors.greyLightColor,

            // errorText: '',
            // errorStyle: TextStyle(height: 0),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              borderSide: BorderSide(
                  width: 1, color: borderColor ?? AppColors.blackColor),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              borderSide: BorderSide(
                  width: 1, color: borderColor ?? AppColors.greyColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              borderSide: BorderSide(
                  width: 1, color: borderColor ?? AppColors.greyColor),
            ),
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              borderSide: const BorderSide(width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              borderSide: BorderSide(
                  width: 1, color: borderColor ?? AppColors.orangeColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 10)),
              borderSide: BorderSide(
                  width: 1, color: borderColor ?? AppColors.orangeColor),
            ),
          ),
        ),
      ],
    );
  }
}
