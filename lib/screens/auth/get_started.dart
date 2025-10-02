import 'package:market_place_app/screens/business_profile/merchant_registration.dart';
import 'package:market_place_app/utils/exports.dart';
import 'package:slider_button/slider_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});


  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  List dataLiat = [
    {
      "title": "Become a Vendor",
      "value": "List your business, manage orders & grow sales",
      'role': "vendor"
    },
    {
      "title": "Become a Salesperson",
      "value": "Manage leads, close deals & earn commission",
      'role': "salesperson"
    }
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(Assets.gegStarted))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // 1st Line
              Text(
                "Grow Your Business the Easy Way",
                style: AppStyle.bold_28(AppColors.whiteColor),
              ).animate().fadeIn(duration: 800.ms, delay: 0.ms),

              SizedBox(height: 5),

              // 2nd Line
              Text(
                "Create deals, reach more customers, and manage everything in one place. Start today — it’s quick and free.",
                style: AppStyle.normal_14(AppColors.whiteColor),
              ).animate().fadeIn(duration: 600.ms, delay: 900.ms),

              SizedBox(height: size.height * 0.03),

              // Role Selector List
              Column(
                children: List.generate(
                  dataLiat.length,
                  (index) {
                    final delay =
                        1500 + (index * 800); // 1.5s से start, हर item 0.8s gap
                    return roleSelector(
                      onTap: () => setState(() => selectedIndex = index),
                      title: dataLiat[index]['title'],
                      subTitle: dataLiat[index]['value'],
                      index: index,
                      selectedIndex: selectedIndex,
                      delay: delay.ms,
                    );
                  },
                ),
              ),
              SizedBox(height: size.height * 0.02),

              // Button
              Padding(
                padding: globalBottomPadding(context),
                child: SliderButton(
                    height: 60,
                    width: size.width,
                    buttonColor: AppColors.transparent,
                    action: () async {
                      if (selectedIndex != -1) {
                        AppRouter().navigateTo(context, LoginScreen(role: dataLiat[selectedIndex]['role']));
                      } else {
                        snackBar(
                          context,
                          "Kindly select your role to continue",
                          AppColors.redColor,
                        );
                      }
                      return false;
                    },
                    alignLabel: Alignment.center,
                    vibrationFlag: true,
                    baseColor: AppColors.whiteColor,
                    backgroundColor: AppColors.yellowColor,
                    label: Text("Get Started",
                        style: AppStyle.semiBold_16(AppColors.whiteColor)),
                    icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.whiteColor,
                        child: Icon(Icons.arrow_forward_rounded))),
              ).animate().fadeIn(duration: 600.ms, delay: 2500.ms),

              SizedBox(height: size.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}

Widget roleSelector({
  String? title,
  String? subTitle,
  int? selectedIndex,
  int? index,
  void Function()? onTap,
  Duration delay = Duration.zero,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: EdgeInsets.only(bottom: size.height * 0.01),
      decoration: BoxDecoration(
          color: AppColors.black30, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        dense: true,
        contentPadding:
            EdgeInsets.symmetric(horizontal: size.width * 0.03, vertical: 4),
        leading: Container(
          height: 22,
          width: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.whiteColor, width: 1.5),
            color: selectedIndex == index
                ? AppColors.yellowColor
                : Colors.transparent,
          ),
        ),
        title: Text(title ?? "", style: AppStyle.medium_16(AppColors.white80)),
        subtitle: subTitle != null
            ? Text(subTitle, style: AppStyle.normal_13(AppColors.white50))
            : null,
      ),
    ),
  ).animate().fadeIn(duration: 600.ms, delay: delay);
}
