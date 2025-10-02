

import 'package:market_place_app/utils/exports.dart';

Widget backOrNextBtn({
  required BuildContext context,
  bool hideOnBack = false,
  double? minWidth,
  required void Function()? onBack,
  required void Function()? onNext,
  String? text2 = 'Next',
  String? text1 = 'Back',
}) =>
    Padding(
      padding: globalBottomPadding(context),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            hideOnBack
                ? SizedBox()
                : CustomButton3(
                onPressed: onBack,
                txt: text1,
                height: size.height * 0.05,
                minWidth:  size.width * 0.4,
                bgColor: AppColors.black20.withOpacity(0.5)),
            CustomButton3(
                onPressed: onNext,
                txt: text2,
                height: size.height * 0.05,
                minWidth: minWidth ?? size.width * 0.4),
          ],
        ),
      ),
    );
