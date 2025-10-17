import 'dart:ui';

import 'package:market_place_app/data/storage/sharedpreferenc.dart';
import 'package:market_place_app/utils/exports.dart';

/// LOG OUT DIALOG
void logOutPermissionDialog(BuildContext context, {bool forDelete = false}) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              forDelete
                                  ? "Delete Account Confirmation"
                                  : 'Logout Confirmation',
                              style: AppStyle.normal_16(AppColors.whiteColor)),
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.clear,
                                  color: AppColors.whiteColor))
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      forDelete
                          ? "Are you sure you want to delete your account!"
                          : 'Are you sure you want to logout this app!',
                      style: AppStyle.normal_14(AppColors.blackColor))),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('CANCEL',
                            style: AppStyle.medium_14(AppColors.redColor))),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: () {
                          EasyLoading.show();
                          Navigator.pop(context);
                          Future.delayed(Duration(seconds: 2), () {
                            EasyLoading.dismiss();
                            LocalStorage.clear(context);
                          });
                        },
                        child: Text(
                          forDelete ? "DELETE" : 'LOGOUT',
                          style: AppStyle.medium_14(AppColors.green),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );

/// delete

/// LOG OUT DIALOG
void deleteOffersDialog(
    {required BuildContext context,
        void Function()? onPressed,
        String? deleteText}) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: size.width,
                  decoration: BoxDecoration(
                      color: AppColors.themeColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delete $deleteText Confirmation",
                              style: AppStyle.normal_16(AppColors.whiteColor)),
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(Icons.clear,
                                  color: AppColors.whiteColor))
                        ],
                      ))),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                      "Are you sure you want to delete this $deleteText",
                      style: AppStyle.normal_14(AppColors.blackColor))),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('CANCEL',
                            style: AppStyle.medium_14(AppColors.redColor))),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed: onPressed,
                        child: Text(
                          "DELETE",
                          style: AppStyle.medium_14(AppColors.green),
                        ))
                  ],
                ),
              )
            ],
          ),
        );
      },
    );

/// session expire dialog


void sessionExpiredDialog(BuildContext context) {
  showGeneralDialog(
    barrierDismissible: false,
    barrierLabel: "Session Expired",
    context: context,
    pageBuilder: (ctx, anim1, anim2) {
      return const SizedBox.shrink(); // actual widget built in transitionBuilder
    },
    transitionBuilder: (ctx, anim1, anim2, child) {
      return Transform.scale(
        scale: anim1.value,
        child: Opacity(
          opacity: anim1.value,
          child: Dialog(
            backgroundColor: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.themeColor),
                  const SizedBox(height: 20),
                  Text(
                    'Your session has expired. Please login again.',
                    style: AppStyle.medium_16(AppColors.blackColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionDuration: const Duration(milliseconds: 500),
  );

  // Auto redirect after 3 seconds
  Timer(const Duration(seconds: 3), () {
    // Navigator.of(context, rootNavigator: true).pop(); // close dialog
    // LocalStorage.clearAll(); // clear all stored data
    //
    // AppRouter().navigateToAndRemoveAll(context, LoginScreen());
  });
}


