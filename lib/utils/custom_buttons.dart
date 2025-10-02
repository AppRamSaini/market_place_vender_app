import 'package:flutter/material.dart';
import 'package:market_place_app/main.dart';
import 'package:market_place_app/utils/app_styles.dart';
import 'package:market_place_app/utils/app_colors.dart';

Widget CustomButton(
        {required void Function()? onPressed,
        Color bgColor = AppColors.themeColor,
        Color txtColor = AppColors.whiteColor,
        String? txt,
        double? minWidth}) =>
    MaterialButton(
      minWidth: minWidth,
      height: size.height * 0.055,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Text(
        txt.toString(),
        style: AppStyle.medium_16(txtColor),
      ),
    );

Widget CustomButton2(
        {required void Function()? onPressed,
        Color bgColor = AppColors.themeColor,
        Color txtColor = AppColors.whiteColor,
        String? txt,
        double? minWidth,
        double? height}) =>
    MaterialButton(
      padding: EdgeInsets.symmetric(horizontal: 5),
      minWidth: minWidth,
      height: height,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Text(
        txt.toString(),
        style: AppStyle.normal_10(txtColor),
      ),
    );

Widget CustomButton3(
    {required void Function()? onPressed,
      Color bgColor = AppColors.themeColor,
      Color txtColor = AppColors.whiteColor,
      String? txt,
      double? minWidth,
      double? height}) =>
    MaterialButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(horizontal: 3),
      minWidth: minWidth,
      height: height,
      onPressed: onPressed,
      color: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: Text(
        txt.toString(),
        style: AppStyle.normal_14(txtColor),
      ),
    );