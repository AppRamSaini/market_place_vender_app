import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:market_place_app/utils/app_styles.dart';
import 'package:market_place_app/utils/app_colors.dart';

Widget customTextField(
        {String? hintText,
        bool readOnly = false,
          bool showPrefix = false,
        TextEditingController? controller,
        Widget? suffix,
        int? maxLength,
        Widget? prefix,
        void Function(String)? onChanged,
        TextInputType? keyboardType,
        int? maxLines = 1,int? minLines = 1,
        List<TextInputFormatter>? inputFormatters,
        String? Function(String?)? validator,void Function()? onTap}) =>
    TextFormField(
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      style: AppStyle.medium_14(AppColors.blackColor),
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          counter: SizedBox(),
          filled: true,
          prefixIcon: prefix,
          fillColor: AppColors.theme5,
          hintText: hintText,
          hintStyle: AppStyle.normal_16(AppColors.greyColor),
          suffixIcon: suffix,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme5, width: 0.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme5, width: 0.5)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme5, width: 0.5)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme5, width: 0.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme5, width: 0.5)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.theme5, width: 0.5))),
    );
