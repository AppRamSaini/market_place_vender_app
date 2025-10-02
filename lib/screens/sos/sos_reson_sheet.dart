import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_app/bloc/sos_bloc/sos_bloc.dart';
import 'package:market_place_app/bloc/sos_bloc/sos_event.dart';
import 'package:market_place_app/main.dart';
import 'package:market_place_app/screens/auth/login.dart';
import 'package:market_place_app/utils/app_colors.dart';
import 'package:market_place_app/utils/custom_buttons.dart';

sosReasonSheet(BuildContext context,String lat,String lng,String location) {
  List<String> actionList = [
    "Accident / Breakdown",
    "Medical Emergency",
    "Threat / Harassment",
    "Lost / Misdirected"
  ];

  ValueNotifier<String> actionValue = ValueNotifier('');
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // full height
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16),
        child: ValueListenableBuilder<String>(
          valueListenable: actionValue,
          builder: (context, value, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: 20),
                Text("Select the specific reason",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Column(
                    children: List.generate(
                        actionList.length,
                        (index) => Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: myRadioButton(
                                showBtn: false,
                                onClear: () {},
                                title: actionList[index].toString(),
                                value: actionList[index].toString(),
                                onChanged: (newValue) =>
                                    actionValue.value = newValue!,
                                groupValue: actionValue.value)))),
                SizedBox(height: 20),
                CustomButton(
                    bgColor: actionValue.value.isNotEmpty
                        ? AppColors.themeColor
                        : AppColors.greyColor,
                    minWidth: size.width,
                    onPressed: () async {
                      if (actionValue.value != null &&
                          actionValue.value.isNotEmpty) {
                        context.read<SosBloc>().add(SubmitSosEvent(
                            context: context,
                            lat: lat.toString(),
                            lng: lng.toString(),
                            location: location.toString(),
                            reason: actionValue.value.toString()));
                        Navigator.pop(context);
                      }
                    },
                    txt: "Create Request"),
              ],
            );
          },

        ),
      );
    },
  );
}
