import 'package:carousel_slider/carousel_slider.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_dashbaord_offers/dashboard_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_offers/fetch_offers_event.dart';
import 'package:market_place_app/screens/my_offers/my_offers_list.dart';
import 'package:market_place_app/utils/exports.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../bloc/merchant_offers/fetch_dashbaord_offers/dashboard_offers_bloc.dart';
import '../../data/models/merchant_business_model.dart';

// List images = [
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
//   {
//     "url":
//         "https://b.zmtcdn.com/data/pictures/5/21332495/1afdd5c5611a0c3edb71ed6652742874.jpeg",
//     "filename": "img1.jpg"
//   },
//   {
//     "url":
//         "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSWvg9OpnRv_b3ZkRpCZNCwLtzlDQRJXGivzA&s",
//     "filename": "img2.jpg"
//   },
// ];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  double _appBarOpacity = 0.0;
  double _flexTitleOpacity = 1.0;
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      double maxOffset = size.height * 0.3;

      double opacity = (offset / maxOffset).clamp(0.0, 1.0);
      setState(() {
        _appBarOpacity = opacity; // appbar title opacity
        _flexTitleOpacity = 1.0 - opacity; // flexible title opacity
      });
    });
    refreshData();
  }

  refreshData() {
    context.read<FetchOffersBloc>().add(GetOffersEvent(context: context));
    context
        .read<FetchDashboardOffersBloc>()
        .add(DashboardOffersEvent(context: context));
  }

  late BuildContext dialogContext;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          bool shouldExit = await exitPageDialog(context);
          return shouldExit;
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteOffersBloc, DeleteOffersState>(
              listener: (context, state) {
                EasyLoading.dismiss();
                if (state is DeleteOffersLoading) {
                  EasyLoading.show();
                } else if (state is DeleteOffersSuccess) {
                  final data = state.offersData;
                  snackBar(
                      context, data['message'].toString(), AppColors.green);
                  refreshData();
                } else if (state is DeleteOffersFailure) {
                  snackBar(context, state.error.toString(), AppColors.redColor);
                  refreshData();
                } else if (state is DeleteOffersInvalidResult) {
                  EasyLoading.dismiss();
                } else {
                  EasyLoading.dismiss();
                }
              },
            ),
            BlocListener<DisableOffersBloc, DisableOffersState>(
              listener: (context, state) {
                EasyLoading.dismiss();
                if (state is DisableOffersLoading) {
                  EasyLoading.show();
                } else if (state is DisableOffersSuccess) {
                  final message = state.disableOffersModel.message.toString();
                  snackBar(context, message, AppColors.green);
                  refreshData();
                } else if (state is DisableOffersFailure) {
                  snackBar(context, state.error.toString(), AppColors.redColor);
                }
              },
            ),
            BlocListener<AddOffersBloc, AddOffersState>(
              listener: (context, state) {
                if (state is AddOffersSuccess) {
                  refreshData();
                }
              },
            ),
            BlocListener<UpdateOffersBloc, UpdateOffersState>(
              listener: (context, state) {
                if (state is UpdateOffersSuccess) {
                  refreshData();
                }
              },
            ),
          ],
          child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                backgroundColor: AppColors.themeColor,
                onPressed: () => refreshData(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(Icons.add, color: AppColors.whiteColor)),
            body: BlocBuilder<FetchDashboardOffersBloc,
                FetchDashboardOffersState>(builder: (context, state) {
              if (state is FetchDashboardOffersLoading) {
                return Center(child: BurgerKingShimmer());
              } else if (state is FetchDashboardOffersFailure) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Text(
                      state.error.toString(),
                      textAlign: TextAlign.center,
                      style: AppStyle.medium_14(AppColors.redColor),
                    ),
                  ),
                );
              } else if (state is FetchDashboardOffersSuccess) {
                final offersData = state.merchantDashboardModel.data;

                var stats = offersData!.stats;
                List businessImages = [];

                if (offersData.vendors != null) {
                  businessImages = offersData.vendors!.businessImage!;
                }

                List dataList = [
                  {
                    "icon": Assets.totalSales,
                    "title": "Total Sales",
                    "stats": stats!.totalSales ?? 0
                  },
                  {
                    "icon": Assets.redeemOffers,
                    "title": "Redeem Offers",
                    "stats": stats!.redeemedOfferes ?? 0
                  },
                  {
                    "icon": Assets.pendingOffers,
                    "title": "Pending offers",
                    "stats": stats!.pendingOffers ?? 0
                  },
                  {
                    "icon": Assets.totalCustomers,
                    "title": "Total Customers",
                    "stats": stats!.totalCustomers ?? 0
                  },
                ];
                return RefreshIndicator(
                  onRefresh: () async => refreshData(),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      SliverAppBar(
                        expandedHeight: size.height * 0.3,
                        floating: false,
                        pinned: true,
                        snap: false,
                        stretch: true,
                        backgroundColor: AppColors.themeColor,
                        title: Opacity(
                            opacity: _appBarOpacity,
                            child: Text(offersData.vendors!.businessName ?? '',
                                style:
                                    AppStyle.medium_22(AppColors.whiteColor))),
                        flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            titlePadding:
                                const EdgeInsets.only(left: 10, bottom: 10),
                            title: Opacity(
                                opacity: _flexTitleOpacity,
                                child: Text(
                                    offersData.vendors!.businessName ?? '',
                                    style: AppStyle.medium_15(
                                        AppColors.whiteColor))),
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                // Image Stack with fade animation
                                ...List.generate(businessImages!.length,
                                    (index) {
                                  bool isActive = index == _currentIndex;
                                  return AnimatedOpacity(
                                    duration: Duration(
                                        milliseconds: 2000), // Fade duration
                                    opacity: isActive ? 1.0 : 0.0,
                                    curve: Curves.easeInOut,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      placeholder: AssetImage(Assets.dummy),
                                      image: NetworkImage(
                                          businessImages![index].url ?? ''),
                                      imageErrorBuilder: (_, child, st) =>
                                          Image.asset(Assets.dummy,
                                              fit: BoxFit.cover),
                                    ),
                                  );
                                }),

                                // CarouselSlider for controlling the page index
                                CarouselSlider.builder(
                                  itemCount: businessImages!.length,
                                  itemBuilder: (context, index, realIndex) {
                                    // Empty container, images are already in Stack
                                    return SizedBox.shrink();
                                  },
                                  carouselController: _carouselController,
                                  options: CarouselOptions(
                                    height: double.infinity,
                                    viewportFraction: 1.0,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 5),
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                      });
                                    },
                                  ),
                                ),

                                // Indicator + Overlay box
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        AnimatedSmoothIndicator(
                                          activeIndex: _currentIndex,
                                          count: businessImages.length,
                                          duration:
                                              Duration(milliseconds: 1800),
                                          effect: ScrollingDotsEffect(
                                            activeDotColor: Colors.white,
                                            dotColor: Colors.white54,
                                            dotHeight: 4,
                                            dotWidth: 20,
                                            spacing: 8,
                                            radius: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),

                      // flexibleSpace: FlexibleSpaceBar(
                      //   collapseMode: CollapseMode.parallax,
                      //   titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                      //   background: Image.network(
                      //     "https://picsum.photos/400/200",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      /*  flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      expandedTitleScale: 1.1,
                      titlePadding: EdgeInsets.only(
                          left: size.width * 0.03, right: size.width * 0.03),
                      title: LayoutBuilder(
                        builder: (context, constraints) {
                          var percent =
                              ((constraints.maxHeight - kToolbarHeight) /
                                      (200 - kToolbarHeight))
                                  .clamp(0.0, 1.0);

                          return Opacity(
                              opacity: percent,
                              child: customTextField(
                                prefix: Icon(Icons.search, size: 20),
                                hintText: "Search here...",
                              ));
                        },
                      ),
                    ),*/

                      SliverToBoxAdapter(
                          child: SizedBox(height: size.height * 0.02)),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 6,
                                    crossAxisSpacing: 6,
                                    childAspectRatio: 2.4),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics:
                                NeverScrollableScrollPhysics(), // Important
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.theme5,
                                    border:
                                        Border.all(color: AppColors.theme10)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5),
                                    Image.asset(dataList[index]['icon'],
                                        height: 45,
                                        width: 45,
                                        fit: BoxFit.fill),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.013),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                dataList[index]['title']
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: AppStyle.medium_16(
                                                    AppColors.blackColor)),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  dataList[index]['stats']
                                                      .toString(),
                                                  style: AppStyle.medium_18(
                                                      AppColors.black20)),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(child: SizedBox(height: 12)),

                      offersData.offers!.isNotEmpty
                          ? SliverToBoxAdapter(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.034),
                                  child: Text("Featured Offers",
                                      style: AppStyle.medium_18(
                                          AppColors.themeColor))))
                          : SliverToBoxAdapter(child: SizedBox()),

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
                                  height: size.height * 0.16,
                                  color: AppColors.theme5,
                                  isCornerRounded: false,
                                  padding: EdgeInsets.only(
                                      top: size.height * 0.02,
                                      right: size.width * 0.03,
                                      left: size.width * 0.03),
                                  child: TicketData(
                                      data: offersData.offers![index]),
                                ),
                              ),
                            ),
                          ),
                          childCount: offersData!.offers!.length,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
          ),
        ));
  }
}
