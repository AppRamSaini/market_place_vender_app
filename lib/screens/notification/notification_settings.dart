import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:market_place_app/bloc/notification_bloc/notifications_bloc.dart';
import 'package:market_place_app/bloc/notification_bloc/notifications_event.dart';
import 'package:market_place_app/bloc/notification_bloc/notifications_state.dart';
import 'package:market_place_app/data/models/notification_types_model.dart';
import 'package:market_place_app/utils/exports.dart';

class NotificationsSettingsType extends StatefulWidget {
  const NotificationsSettingsType({super.key});

  @override
  State<NotificationsSettingsType> createState() =>
      _NotificationsSettingsTypeState();
}

class _NotificationsSettingsTypeState extends State<NotificationsSettingsType> {
  Map<String, bool> toggleStates = {};
  String updatingId = '';
  String updateValue = '';

  @override
  void initState() {
    super.initState();
    onRefresh();
  }

  Future<void> onRefresh() async {
    context.read<NotificationsBloc>().add(
          FetchNotificationsTypesEvent(context: context),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: 'Notifications Settings'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<NotificationsUpdateBloc, UpdateNotificationsState>(
            listener: (context, state) {
              if (state is NotificationsUpdateLoading) {
              } else if (state is UpdateNotificationsSuccess) {
                EasyLoading.dismiss();
                if (state.notificationUpdateModel.status == true &&
                    updatingId.isNotEmpty) {
                  setState(() {
                    toggleStates[updatingId] = updateValue == '1';
                    updatingId = ''; // reset
                  });
                }
              } else if (state is UpdateNotificationsFailure) {
                EasyLoading.dismiss();
                snackBar(context, state.error.toString(), AppColors.redColor);
              }
            },
          ),
        ],
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: BlocBuilder<NotificationsBloc, NotificationsState>(
            builder: (context, state) {
              if (state is NotificationsLoading) {
                return notificationShimmerLoading();
              } else if (state is NotificationsTypesSuccess) {
                List<NotificationType> data =
                    state.notificationTypesModel.data ?? [];

                return ListView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    final id = item.id ?? '';
                    final value =
                        toggleStates[id] ?? (item.status == 1 ? true : false);

                    return _buildSwitchRow(
                      item.name ?? '',
                      value,
                      (newValue) {
                        updatingId = id;
                        updateValue = newValue ? '1' : '0';

                        context.read<NotificationsUpdateBloc>().add(
                              UpdateNotificationSubmitted(
                                context: context,
                                status: updateValue,
                                notificationId: id,
                              ),
                            );
                      },
                    );
                  },
                );
              } else if (state is NotificationsFailure) {
                return Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    noDataWidget(),
                    Text(
                      state.error.toString(),
                      style: AppStyle.normal_14(AppColors.redColor),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchRow(
      String title, bool switchValue, ValueChanged<bool> onChanged) {
    return Card(
      color: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppStyle.medium_14(AppColors.blackColor)),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: AppColors.themeColor,
                value: switchValue,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
