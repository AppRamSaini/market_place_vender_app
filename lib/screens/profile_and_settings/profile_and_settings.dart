import 'package:market_place_app/bloc/notification_bloc/notifications_state.dart';
import 'package:market_place_app/screens/profile_and_settings/delete_account.dart';

import '../../utils/exports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  MerchantRegistrationModel? merchantRegistrationModel;
  late List settingTitles;

  @override
  void initState() {
    super.initState();
    _reFetchData();
  }

  Future _reFetchData() async => context
      .read<FetchBusinessDetailsBloc>()
      .add(FetchBusinessDetailsDetailsEvent(context: context));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await exitPageDialog(context);
        return shouldExit;
      },
      child:
          BlocListener<UpdateMerchantBusinessBloc, UpdateMerchantBusinessState>(
        listener: (context, state) async {
          EasyLoading.dismiss();
          if (state is UpdateMerchantBusinessSuccess) {
            _reFetchData();
          }
        },
        child: Scaffold(
          body:
              BlocBuilder<FetchBusinessDetailsBloc, FetchBusinessDetailsState>(
            builder: (context, state) {
              if (state is FetchBusinessDetailsLoading) {
                return SingleChildScrollView(child: profileSimmerLoading());
              } else if (state is FetchBusinessDetailsFailure) {
                return Center(
                    child: Text(state.error.toString(),
                        style: AppStyle.medium_14(AppColors.redColor)));
              } else if (state is FetchBusinessDetailsSuccess) {
                final businessProfile = state.profileModel.data;
                if (businessProfile != null) {
                  merchantRegistrationModel = MerchantRegistrationModel(
                      name: businessProfile.vendor?.name ?? '',
                      mobile: businessProfile.vendor?.phone?.toString() ?? '',
                      email: businessProfile.vendor?.email?.toString() ?? '',
                      country: businessProfile.businessDetails?.country ?? '',
                      businessName:
                          businessProfile.businessDetails?.businessName ?? '',
                      businessRegistrationNo:
                          businessProfile.businessDetails?.businessRegister ??
                              '',
                      gstNumber:
                          businessProfile.businessDetails?.gstNumber ?? '',
                      state: businessProfile.businessDetails?.state ?? '',
                      city: businessProfile.businessDetails?.city ?? '',
                      pinCode:
                          businessProfile.businessDetails?.pincode?.toString() ??
                              '',
                      landMark: businessProfile.businessDetails?.area ?? '',
                      category: businessProfile.businessDetails?.category?.id
                              .toString() ??
                          '',
                      subCategory: businessProfile
                              .businessDetails?.subcategory?.id
                              .toString() ??
                          '',
                      lat: businessProfile.businessDetails?.lat?.toString() ??
                          '',
                      long: businessProfile.businessDetails?.long?.toString() ??
                          '',
                      address: businessProfile.businessDetails?.address ?? '',
                      aadhaarFront:
                          businessProfile.document?.aadhaarFront ?? '',
                      aadhaarBack: businessProfile.document?.aadhaarBack ?? '',
                      panImage: businessProfile.document?.panCardImage ?? '',
                      gstCertificate:
                          businessProfile.document?.gstCertificate ?? '',
                      businessLogo:
                          businessProfile.document?.businessLogo ?? '',
                      weekOffDay:
                          businessProfile.timing?.weeklyOffDay?.toIso8601String() ??
                              '',
                      openingHours: mapOpeningHours(businessProfile.timing?.openingHours),
                      businessImages: businessProfile.businessDetails!.businessImage ?? []);
                }

                settingTitles = [
                  {
                    "title": "Manage Basic Detail",
                    "icon": Icons.person_add_alt_1_outlined,
                    "page": MerchantRegistration(
                        mobile: businessProfile!.vendor!.phone.toString(),
                        forUpdate: true,
                        merchantData: merchantRegistrationModel)
                  },
                  {
                    "title": "Manage Your Business ",
                    "icon": Icons.business_center,
                    "page": BusinessDetailsPage(
                        category:
                            businessProfile.businessDetails?.category?.name,
                        subCategory:
                            businessProfile.businessDetails?.subcategory?.name,
                        categoryID: businessProfile
                            .businessDetails?.category?.categoryId
                            .toString(),
                        forUpdate: true,
                        merchantData: merchantRegistrationModel!)
                  },
                  {
                    "title": "Manage Documents",
                    "icon": Icons.document_scanner_rounded,
                    "page": UpdateDocuments(
                        forUpdate: true,
                        merchantData: merchantRegistrationModel!)
                  },
                  {
                    "title": "Business Hours & Special Days",
                    "icon": Icons.timer_outlined,
                    "page": UpdateBusinessHours(
                        forUpdate: true,
                        merchantData: merchantRegistrationModel!)
                  },
                  {
                    "title": "Manage Business Gallery",
                    "icon": Icons.image,
                    "page": BusinessGallery(
                        forUpdate: true,
                        merchantData: merchantRegistrationModel!)
                  },
                  {
                    "title": "Help & Support",
                    "icon": Icons.help_outline_outlined
                  },
                  {
                    "title": "Privacy Policy",
                    "icon": Icons.privacy_tip_outlined
                  },
                  {
                    "title": "Delete Account",
                    "icon": Icons.delete_forever_sharp,
                    "page": DeleteUserAccount()
                  },
                  {"title": "Logout", "icon": Icons.logout},

                ];
                return RefreshIndicator(
                  onRefresh: _reFetchData,
                  child: CustomScrollView(
                    slivers: [
                      customSliverAppbar(
                        expandedHeight: size.height * 0.2,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Profile Settings",
                                style:
                                    AppStyle.medium_18(AppColors.themeColor)),
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 15, right: 5),
                                  child: GestureDetector(
                                    onTap: () => AppRouter().navigateTo(
                                        context, NotificationScreen()),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.theme10,
                                      child: Icon(
                                        Icons.notifications,
                                        color: AppColors.themeColor,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                // BlocBuilder<NotificationsBloc, NotificationsState>(
                                //     builder: (context, state) {
                                //       if (state is NotificationsSuccess) {
                                //         final user = state.getNotificationModel.data;
                                //         return user!.unread ==0
                                //             ? SizedBox()
                                //             :

                                CircleAvatar(
                                  radius: 10,
                                  backgroundColor: AppColors.redColor,
                                  child: Text(
                                    '12+',
                                    style: AppStyle.normal_10(
                                        AppColors.whiteColor),
                                  ),
                                )

                                // ;
                                //   } else {
                                //     return SizedBox();
                                //   }
                                // })
                              ],
                            )
                          ],
                        ),
                        flexibleSpace: LayoutBuilder(
                          builder: (context, constraints) {
                            var percent =
                                ((constraints.maxHeight - kToolbarHeight) /
                                        (size.height * 0.2 - kToolbarHeight))
                                    .clamp(0.0, 1.0);

                            return FlexibleSpaceBar(
                              collapseMode: CollapseMode.parallax,
                              background: Container(color: AppColors.theme5),
                              titlePadding: EdgeInsets.zero,
                              title: percent > 0.5
                                  ? Opacity(
                                      opacity: percent,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.02),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: size.width * 0.01,
                                            vertical: size.height * 0.014),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.theme5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child: profilePickImage(
                                                        businessProfile!
                                                                .document!
                                                                .businessLogo ??
                                                            ''))),
                                            SizedBox(width: 2),
                                            // Text section
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Flexible(
                                                          child: Text(
                                                            businessProfile!
                                                                    .businessDetails!
                                                                    .businessName ??
                                                                '',
                                                            style: AppStyle
                                                                .semiBold_12(
                                                                    AppColors
                                                                        .blackColor),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        SizedBox(width: 5),
                                                        Icon(Icons.verified,
                                                            color:
                                                                AppColors.green,
                                                            size: 15),
                                                      ],
                                                    ),
                                                    Text(
                                                      (businessProfile!
                                                                  .businessDetails!
                                                                  .businessRegister ??
                                                              '')
                                                          .toUpperCase(),
                                                      style: AppStyle.normal_10(
                                                          AppColors.black20),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            // Circular Progress
                                            SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: CircularPercentIndicator(
                                                radius: 16.0,
                                                lineWidth: 4.0,
                                                percent: 0.25,
                                                center: Text(
                                                  "25%",
                                                  style: AppStyle.normal_10(
                                                      AppColors.themeColor),
                                                ),
                                                progressColor:
                                                    AppColors.themeColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            );
                          },
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => Align(
                            alignment: Alignment.center,
                            child: settingsWidget(
                                onTap: () {
                                  if (index != 8) {
                                    AppRouter().navigateTo(
                                        context, settingTitles[index]['page']);
                                  } else {
                                    logOutPermissionDialog(context);
                                  }
                                },
                                title: settingTitles[index]['title'],
                                icon: settingTitles[index]['icon']),
                          ),
                          childCount: settingTitles.length,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
