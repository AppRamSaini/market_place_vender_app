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
void deleteOffersDialog(BuildContext context, void Function()? onPressed) =>
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
                              "Delete Offer Confirmation",

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

                           "Are you sure you want to delete this offer!",

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





/// LOG OUT DIALOG
void completeDeliveryPermission(BuildContext context, void Function()? onPressed,
    {bool forSos = false}) =>
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
                              forSos?"Cancel Sos Confirmation":   'Delivery Confirmation',
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
                      forSos?'Are you sure you want to cancel this sos!': 'Are you sure you want to complete this delivery!',
                      style: AppStyle.normal_14(AppColors.blackColor))),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(forSos?'NO':'CANCEL',
                            style: AppStyle.medium_14(AppColors.redColor))),
                    const SizedBox(width: 20),
                    TextButton(
                        onPressed:onPressed,
                        child: Text(forSos?'YES':'COMPLETE',
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
