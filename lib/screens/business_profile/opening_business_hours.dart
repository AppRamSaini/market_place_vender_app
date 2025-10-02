import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:market_place_app/bloc/business_registration/update_business/update_business_event.dart';
import 'package:market_place_app/screens/business_profile/upload_documents.dart';
import 'package:market_place_app/screens/business_profile/update_profile.dart';
import 'package:market_place_app/utils/exports.dart';

class UpdateBusinessHours extends StatefulWidget {
  final MerchantRegistrationModel merchantData;
  bool forUpdate;
  UpdateBusinessHours(
      {super.key, required this.merchantData, this.forUpdate = false});

  @override
  State<UpdateBusinessHours> createState() => _UpdateBusinessHoursState();
}

class _UpdateBusinessHoursState extends State<UpdateBusinessHours> {
  late Map<String, OpeningHour> openingHours;
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  DateTime selectedDate = DateTime.now();
  final TextEditingController extraHolidayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize opening hours either from existing merchantData or default
    openingHours = widget.merchantData.openingHours ??
        {
          for (var d in days)
            d: OpeningHour(open: "09:00 AM", close: "10:00 PM", active: false)
        };
  }

  String? weekDayOff;
  Future<void> updateDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        weekDayOff = DateFormat('yyyy-MM-dd').format(selectedDate);
        String formattedDate = DateFormat('dd MMMM yy').format(selectedDate);
        extraHolidayController.text = formattedDate;
      });
    }
  }

  Future<void> _selectTime(String dayKey, bool isStart) async {
    final initialTime = isStart
        ? _timeOfDayFromString(openingHours[dayKey]!.open!)
        : _timeOfDayFromString(openingHours[dayKey]!.close!);

    final picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          openingHours[dayKey]!.open = _formatTime(picked);
        } else {
          openingHours[dayKey]!.close = _formatTime(picked);
        }
      });
    }
  }

  TimeOfDay _timeOfDayFromString(String timeStr) {
    final format = DateFormat("hh:mm a");
    final date = format.parse(timeStr);
    return TimeOfDay(hour: date.hour, minute: date.minute);
  }

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat("hh:mm a").format(dt);
  }

  Future _onSaveData() async {
    widget.merchantData.weekOffDay = weekDayOff;

    // Convert openingHours into API format with 24-hour time
    final apiOpeningHours = openingHours.map((day, hour) {
      return MapEntry(day, {
        "open": hour.active ? convertTo24Hour(hour.open!) : null,
        "close": hour.active ? convertTo24Hour(hour.close!) : null,
        "active": hour.active,
      });
    });

    // Assign to your merchant model as Map<String, Map<String, dynamic>>
    widget.merchantData.openingHours = apiOpeningHours.map((key, value) =>
        MapEntry(
            key,
            OpeningHour(
                open: value['open'] as String?,
                close: value['close'] as String?,
                active: value['active'] as bool? ?? false)));

    print("Opening Hours API JSON ===>>> $apiOpeningHours");

    if (widget.forUpdate) {
      context
          .read<UpdateMerchantBusinessBloc>()
          .add(UpdateMerchantRegistrationEvent(widget.merchantData, context));
    } else {
      AppRouter().navigateTo(
          context, UpdateDocuments(merchantData: widget.merchantData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMerchantBusinessBloc,
        UpdateMerchantBusinessState>(
      listener: (context, state) async {
        EasyLoading.dismiss();
        if (state is UpdateMerchantBusinessLoading) {
          EasyLoading.show();
        } else if (state is UpdateMerchantBusinessSuccess) {
          final message = state.merchantBusinessModel.message.toString();
          snackBar(context, message, AppColors.green);
          Navigator.pop(context);
        } else if (state is UpdateMerchantBusinessFailure) {
          snackBar(context, state.error.toString(), AppColors.redColor);
          EasyLoading.dismiss();
        }
      },
      child: Scaffold(
        appBar:
            customAppbar(context: context, title: "Business Hours & Holidays"),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: backOrNextBtn(
          text1: "Skip",
          text2: widget.forUpdate ? 'Update' : 'Next',
          hideOnBack: widget.forUpdate,
          minWidth: widget.forUpdate ? size.width * 0.9 : null,
          context: context,
          onBack: _onSaveData,
          onNext: _onSaveData,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.01),
              Text("Opening Hours",
                  style: AppStyle.medium_16(AppColors.black20)),
              SizedBox(height: size.height * 0.01),
              ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: openingHours.keys.map((dayKey) {
                  final item = openingHours[dayKey]!;
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.black20.withOpacity(0.3))),
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          SizedBox(width: 2),
                          Text(dayKey,
                              style: AppStyle.medium_14(AppColors.black20)),
                          SizedBox(width: 6),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: item.active
                                      ? () => _selectTime(dayKey, true)
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 5),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6),
                                        color: item.active
                                            ? Colors.white
                                            : Colors.grey.shade200),
                                    child: Row(
                                      children: [
                                        Text(item.open ?? "",
                                            style: AppStyle.normal_13(
                                                AppColors.black20)),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: AppColors.black20)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 6),
                                Text("-"),
                                SizedBox(width: 6),
                                GestureDetector(
                                  onTap: item.active
                                      ? () => _selectTime(dayKey, false)
                                      : null,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(6),
                                        color: item.active
                                            ? Colors.white
                                            : Colors.grey.shade200),
                                    child: Row(
                                      children: [
                                        Text(item.close ?? "",
                                            style: AppStyle.normal_13(
                                                AppColors.black20)),
                                        Icon(Icons.keyboard_arrow_down,
                                            color: AppColors.black20)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: AppColors.themeColor,
                              value: item.active,
                              onChanged: (val) {
                                setState(() {
                                  openingHours[dayKey]!.active = val;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: size.height * 0.02),
              Text("Add Extra Holiday",
                  style: AppStyle.medium_16(AppColors.black20)),
              SizedBox(height: size.height * 0.01),
              CustomTextField(
                onTap: updateDate,
                readOnly: true,
                showPrefix: false,
                hintText: 'Select holiday date',
                controller: extraHolidayController,
                suffix: GestureDetector(
                  onTap: updateDate,
                  child: Icon(Icons.date_range),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter offers valid date';
                  }
                  return null;
                },
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
