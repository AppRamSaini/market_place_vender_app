
import 'package:market_place_app/bloc/merchant_offers/fetch_offers/fetch_offers_event.dart';
import 'package:market_place_app/screens/payment_approval_request/payment_approval_request.dart';
import 'package:market_place_app/screens/profile_and_settings/profile_and_settings.dart';
import 'package:market_place_app/utils/exports.dart';
// import 'package:upgrader/upgrader.dart';
import '../my_offers/my_offers_list.dart';

class MerchantDashboard extends StatefulWidget {
  const MerchantDashboard({super.key});

  @override
  State<MerchantDashboard> createState() => MerchantDashboardState();
}

class MerchantDashboardState extends State<MerchantDashboard> {
  int currentIndex = 0;
  List pagesList = [
    HomePage(),
    MyOffersList(),
    ViewPaymentApprovalRequest(),
    SettingsPage(),
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() {
    context.read<FetchOffersBloc>().add(GetOffersEvent(context: context));
    context.read<FetchBusinessDetailsBloc>().add(FetchBusinessDetailsDetailsEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return

      // UpgradeAlert(
      // dialogStyle: UpgradeDialogStyle.cupertino,
      // child:

      Scaffold(
        body: pagesList[currentIndex],
        bottomNavigationBar: Padding(
          padding: globalBottomPadding(context),
          child: Container(
            width: size.width,
            height: size.height * 0.065,
            decoration: BoxDecoration(color: AppColors.theme5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                dataList.length,
                (index) => _tabWidget(index),
              ),
            ),
          ),
        ),
      // ),
    );
  }

  List dataList = [
    {"icon": Icons.home, "value": "Home"},
    {"icon": Icons.local_offer_rounded, "value": "Offers"},
    {"icon": Icons.history_rounded, "value": "Oder History"},
    {"icon": Icons.person, "value": "Profile"}
  ];

  Widget _tabWidget(int index) => GestureDetector(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: currentIndex == index
                  ? AppColors.theme20
                  : AppColors.transparent),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Row(
            children: [
              Icon(dataList[index]['icon'],
                  color: currentIndex == index
                      ? AppColors.themeColor
                      : AppColors.blackColor,
                  size: 22),
              SizedBox(width: 8),
              currentIndex == index
                  ? Text(dataList[index]['value'].toString().toUpperCase(),
                      style: AppStyle.medium_12(currentIndex == index
                          ? AppColors.themeColor
                          : AppColors.blackColor))
                  : const SizedBox()
            ],
          ),
        ),
      );
}
