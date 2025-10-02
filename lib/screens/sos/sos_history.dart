import 'package:market_place_app/bloc/sos_bloc/sos_event.dart';
import 'package:market_place_app/bloc/sos_bloc/sos_state.dart';
import 'package:market_place_app/data/models/sos_history_model.dart';
import 'package:market_place_app/screens/settings/dialogs.dart';
import 'package:market_place_app/utils/exports.dart';

class SosHistoryPage extends StatefulWidget {
  const SosHistoryPage({super.key});

  @override
  State<SosHistoryPage> createState() => _SosHistoryPageState();
}

class _SosHistoryPageState extends State<SosHistoryPage> {
  int selectedIndex = 0;
  List labelList = [
    'All',
    "Generated",
    "Cancelled",
    "Acknowledged",
    "Dropped",
    "Resolved"
  ];
  List valueList = [
    'all',
    'generated',
    'cancelled',
    'acknowledged',
    'dropped',
    'resolved'
  ];
  @override
  void initState() {
    super.initState();

    onRefresh(valueList.first);
  }

  Future onRefresh(String type) async {
    context.read<SosBloc>().add(FetchSosEvent(type: type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SosCancelBloc, CancelSosState>(
      listener: (context, state) {
        EasyLoading.dismiss();
        if (state is CancelSosLoading) {
          EasyLoading.show(status: 'Loading...');
        } else if (state is CancelSosSuccess) {
          onRefresh(valueList.first);
          snackBar(context, state.successMsg.toString());
          EasyLoading.dismiss();
        } else if (state is CancelSosFailure) {
          EasyLoading.dismiss();
          snackBar(context, state.error.toString(), AppColors.redColor);
        } else if (state is InvalidCancelSosResult) {
          EasyLoading.dismiss();
        }
      },
      child: Scaffold(
        appBar: customAppbar(title: "SOS History"),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
                child: Row(
                  children: List.generate(
                      labelList.length,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() => selectedIndex = index);

                              onRefresh(valueList[selectedIndex]);
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: size.width * 0.03),
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05,
                                  vertical: size.height * 0.008),
                              decoration: BoxDecoration(
                                  color: selectedIndex == index
                                      ? AppColors.redColor
                                      : AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: AppColors.redColor, width: 0.5)),
                              child: Text(
                                labelList[index],
                                style: AppStyle.normal_14(selectedIndex == index
                                    ? AppColors.whiteColor
                                    : AppColors.blackColor),
                              ),
                            ),
                          )),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => onRefresh(valueList.first),
                child: BlocBuilder<SosBloc, SosState>(
                  builder: (context, state) {
                    if (state is IssueReportHistoryLoading) {
                      return Expanded(child: notificationShimmerLoading());
                    } else if (state is SosFailure) {
                      return Center(
                          child: Text(state.error.toString(),
                              style: AppStyle.medium_14(AppColors.redColor)));
                    } else if (state is SosHistorySuccess) {
                      List<Alert> sosHistory = state.sosHistoryModel.alerts!;

                      if (sosHistory.isEmpty) {
                        return Center(child: noDataWidget());
                      }

                      return ListView.builder(
                          itemCount: sosHistory.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (_, index) {
                            final item = sosHistory[index];
                            final sosLog = item.latestLog;
                            String? status = 'generated';
                            if (sosLog != null) {
                              status = sosLog.action.toString();
                            }

                            final color = status == 'generated'
                                ? AppColors.yellowColor
                                : status == 'acknowledged'
                                    ? AppColors.orange
                                    : status == 'dropped'
                                        ? AppColors.skyBlue
                                        : status == 'resolved'
                                            ? AppColors.green
                                            : AppColors.redColor;

                            return Padding(
                              padding: EdgeInsets.all(size.width * 0.03),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.white10,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.03,
                                            vertical: status == 'generated'
                                                ? 0
                                                : size.height * 0.015),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(item.reason ?? '',
                                                style: AppStyle.medium_16(
                                                    AppColors.skyBlue)),
                                            status == 'generated'
                                                ? CustomButton3(
                                                    onPressed: () {
                                                      {
                                                        completeDeliveryPermission(
                                                            context, () async {
                                                          Navigator.pop(
                                                              context, true);

                                                          context
                                                              .read<
                                                              SosCancelBloc>()
                                                              .add(CancelSosEvent(
                                                              uuid: item.uuid
                                                                  .toString(),
                                                              context:
                                                              context));
                                                        }, forSos: true);
                                                      }
                                                    },
                                                    txt: "CLOSE",
                                                    bgColor: AppColors.redColor,
                                                  )
                                                : SizedBox()
                                          ],
                                        )),
                                    customDivider(),
                                    ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        title: Text("Current Location",
                                            style: AppStyle.medium_14(
                                                AppColors.blackColor)),
                                        subtitle: Text(
                                            sosHistory[index].location ?? '',
                                            style: AppStyle.normal_12(
                                                AppColors.greyColor))),
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: ListTile(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              title: Text("Date",
                                                  style: AppStyle.medium_14(
                                                      AppColors.blackColor)),
                                              subtitle: Text(
                                                  formatDate(sosHistory[index]
                                                      .alertedAt!),
                                                  style: AppStyle.normal_12(
                                                      AppColors.greyColor)),
                                            ),
                                          ),
                                          Flexible(
                                            child: ListTile(
                                              dense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              title: Text("Status",
                                                  style: AppStyle.medium_14(
                                                      AppColors.blackColor)),
                                              subtitle: Text(
                                                  capitalizeFirstLetter(
                                                      status.toString()),
                                                  style: AppStyle.normal_16(
                                                      color)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // ListTile(
                                    //   dense: true,
                                    //   contentPadding:
                                    //       EdgeInsets.symmetric(horizontal: 10),
                                    //   title: Text("Admin Notes",
                                    //       style: AppStyle.medium_14(
                                    //           AppColors.blackColor)),
                                    //   subtitle: Text(
                                    //       "यहाँ एक प्रैक्टिकल और आसान भाषा में SOS सिस्टम से जुड़ी ज़रूरी जानकारी दी गई है जिसे आप खुद के प्रोजेक्ट या सिस्टम में लागू कर सकते हैं:",
                                    //       style: AppStyle.normal_12(
                                    //           AppColors.green)),
                                    // )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return notificationShimmerLoading();
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget tripsData({String? title, IconData? icon}) => Container(
      decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        dense: true,
        leading: Icon(icon, color: AppColors.themeColor),
        title: Text(title.toString(),
            style: AppStyle.normal_12(AppColors.themeColor)),
      ),
    );
