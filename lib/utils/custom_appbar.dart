import 'package:flutter/material.dart';
import 'package:market_place_app/main.dart';
import 'package:market_place_app/utils/app_styles.dart';
import 'package:market_place_app/utils/app_colors.dart';
import 'package:market_place_app/utils/exports.dart';

AppBar customAppbar(
        {BuildContext? context, String? title, List<Widget>? actions}) =>
    AppBar(backgroundColor: AppColors.whiteColor,
      centerTitle: false,
      leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new,
              size: 20, color: AppColors.themeColor),
          onPressed: () => Navigator.pop(context!)),
      title: Text(title.toString(),
          style: AppStyle.medium_19(AppColors.themeColor)),
      actions: actions,
    );

/// CUSTOM SLIVER APP BAR

SliverAppBar customSliverAppbar({Widget? title, Widget? flexibleSpace,double? expandedHeight}) =>
    SliverAppBar(
      foregroundColor: AppColors.whiteColor,
        backgroundColor: AppColors.whiteColor,
        expandedHeight: expandedHeight,
        floating: true,
        pinned: true,
        stretch: true,
        automaticallyImplyLeading: false,
        title:  title,
        flexibleSpace: flexibleSpace);

/// image picker

Future<File?> pickImageSheet(BuildContext context) async {
  final picker = ImagePicker();
  File? selectedImage;

  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
    builder: (_) => Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
      child: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("SELECT OPTION",
                    style: AppStyle.medium_16(AppColors.blackColor)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.blackColor,
                    ))
              ],
            ),
            customDivider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  bgColor: AppColors.themeColor,
                  txtColor: AppColors.whiteColor,
                  onPressed: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      selectedImage = File(pickedFile.path);
                    }
                    Navigator.pop(context); // close sheet
                  },
                  txt: "Pick From Camera",
                ),
                CustomButton(
                  bgColor: AppColors.themeColor,
                  txtColor: AppColors.whiteColor,
                  onPressed: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      selectedImage = File(pickedFile.path);
                    }
                    Navigator.pop(context); // close sheet
                  },
                  txt: "Pick From Gallery",
                ),
                // CustomButton(
                //   onPressed: () => Navigator.pop(context),
                //   txt: "Cancel",
                // ),
              ],
            ),
          ],
        ),
      ),
    ),
  );

  return selectedImage;
}

/// img url
Widget profilePickImage(String url) => FadeInImage(
      placeholder: AssetImage(Assets.dummy),
      image: NetworkImage(url ?? ''),
      imageErrorBuilder: (_, child, stack) => Image.asset(Assets.dummy,
          width: size.height * 0.1,
          height: size.height * 0.1,
          fit: BoxFit.cover),
      width: size.height * 0.1,
      height: size.height * 0.1,
      fit: BoxFit.cover,
    );

/// exit page dialog
Future exitPageDialog(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
    builder: (_) => Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
      child: SizedBox(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("EXIT PAGE CONFIRMATION",
                    style: AppStyle.medium_16(AppColors.blackColor)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.clear,
                      color: AppColors.blackColor,
                    ))
              ],
            ),
            customDivider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  bgColor: AppColors.themeColor,
                  txtColor: AppColors.whiteColor,
                  onPressed: () => Navigator.pop(context),
                  txt: "CANCEL",
                ),
                CustomButton(
                  bgColor: AppColors.themeColor,
                  txtColor: AppColors.whiteColor,
                  onPressed: () async {},
                  txt: "EXIT",
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
// utils/validators.dart

String? validateEmail(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Please provide the owner's or business email address";
  }

  // Simple email regex
  String pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  RegExp regex = RegExp(pattern);

  if (!regex.hasMatch(value.trim())) {
    return "Please enter a valid email address";
  }

  return null; // valid
}
