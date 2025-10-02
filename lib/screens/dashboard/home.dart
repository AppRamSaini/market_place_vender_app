import 'package:market_place_app/bloc/notification_bloc/notifications_bloc.dart';
import 'package:market_place_app/bloc/notification_bloc/notifications_state.dart';
import 'package:market_place_app/screens/my_offers/create_offers.dart';
import 'package:market_place_app/screens/my_offers/my_offers_list.dart';
import 'package:market_place_app/utils/exports.dart';
import 'package:ticket_widget/ticket_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List dataList = [
    {
      "icon": Assets.totalSales,
      "title": "Total Sales",
    },
    {"icon": Assets.redeemOffers, "title": "Redeem Offers"},
    {"icon": Assets.pendingOffers, "title": "Pending offers"},
    {"icon": Assets.totalCustomers, "title": "Total Customers"},
  ];

  @override
  void initState() {
    super.initState();
  }

  late BuildContext dialogContext;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await exitPageDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.themeColor,
            onPressed: () => AppRouter().navigateTo(context, CreateOffers()),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)),
            child: Icon(Icons.add, color: AppColors.whiteColor)),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.15,
              floating: false,
              pinned: true,
              snap: false,
              stretch: true,
              leading: Padding(
                padding: const EdgeInsets.only(top: 3, left: 3, bottom: 3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: AssetImage(Assets.dummy),
                    image: NetworkImage(''),
                    imageErrorBuilder: (_, child, state) => CircleAvatar(
                      backgroundImage: AssetImage(Assets.dummy),
                    ),
                  ),
                ),
              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Ramesh Sharma",
                        style: AppStyle.normal_16(AppColors.blackColor)),
                    SizedBox(height: 5),
                    Text("+91 893878473473",
                        style: AppStyle.normal_12(AppColors.blackColor))
                  ]),
              actions: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: GestureDetector(
                        onTap: () => AppRouter()
                            .navigateTo(context, NotificationScreen()),
                        child: CircleAvatar(
                          backgroundColor: AppColors.theme5,
                          child: Icon(
                            Icons.notifications,
                            color: AppColors.themeColor,
                          ),
                        ),
                      ),
                    ),
                    BlocBuilder<NotificationsBloc, NotificationsState>(
                        builder: (context, state) {
                      if (state is NotificationsSuccess) {
                        final user = state.getNotificationModel.data;
                        return user!.unread == 0
                            ? SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: AppColors.green,
                                  child: Text(
                                    user.unread.toString() ?? '0',
                                    style: AppStyle.normal_12(
                                        AppColors.whiteColor),
                                  ),
                                ),
                              );
                      } else {
                        return SizedBox();
                      }
                    })
                  ],
                )
              ],
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                expandedTitleScale: 1.1,
                titlePadding: EdgeInsets.only(
                    left: size.width * 0.03, right: size.width * 0.03),
                title: LayoutBuilder(
                  builder: (context, constraints) {
                    var percent = ((constraints.maxHeight - kToolbarHeight) /
                            (200 - kToolbarHeight))
                        .clamp(0.0, 1.0);

                    return Opacity(
                        opacity: percent,
                        child: CustomTextField(
                          prefix: Icon(Icons.search, size: 20),
                          hintText: "Search here...",
                        ));
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: size.height * 0.015)),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(), // Important
                  itemCount: dataList.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.theme5,
                            border: Border.all(color: AppColors.theme10)),
                        child: ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 5),
                          leading: Image.asset(dataList[index]['icon'],
                              height: 45, width: 45, fit: BoxFit.fill),
                          title: Text(dataList[index]['title'].toString(),
                              style: AppStyle.medium_14(AppColors.blackColor)),
                          subtitle: Text(dataList[index]['title'].toString(),
                              style: AppStyle.normal_12(AppColors.blackColor)),
                        ));
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.03,
                  right: size.width * 0.03,
                  top: size.height * 0.025,
                  bottom: size.height * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Featured Offer",
                      style: AppStyle.semiBold_18(AppColors.themeColor)),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.theme5,
                          border: Border.all(color: AppColors.theme10)),
                      child: Text("Vew All",
                          style: AppStyle.medium_14(AppColors.themeColor)),
                    ),
                  ),
                ],
              ),
            )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width * 0.03,
                        right: size.width * 0.03,
                        top: size.width * 0.03),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TicketWidget(
                        width: size.width,
                        height: size.height * 0.15,
                        color: AppColors.theme5,
                        isCornerRounded: false,
                        padding: EdgeInsets.all(12),
                        child: SizedBox(),
                      ),
                    ),
                  ),
                ),
                childCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
