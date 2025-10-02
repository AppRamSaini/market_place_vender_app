import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_bloc.dart';
import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_event.dart';
import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_state.dart';
import 'package:market_place_app/screens/business_profile/business_details.dart';
import 'package:market_place_app/screens/business_profile/merchant_registration.dart';
import 'package:market_place_app/screens/business_profile/upload_documents.dart';
import 'package:market_place_app/screens/settings/dialogs.dart';
import 'package:market_place_app/utils/exports.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await exitPageDialog(context);
        return shouldExit;
      },
      child: Scaffold(
        body: BlocBuilder<FetchBusinessDetailsBloc, FetchBusinessDetailsState>(
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
                  email: '',
                  businessName:
                      businessProfile.businessDetails?.businessName ?? '',
                  businessRegistrationNo:
                      businessProfile.businessDetails?.businessRegister ?? '',
                  gstNumber: businessProfile.document?.gstCertificate ?? '',
                  state: businessProfile.businessDetails?.state ?? '',
                  city: businessProfile.businessDetails?.city ?? '',
                  pinCode:
                      businessProfile.businessDetails?.pincode?.toString() ??
                          '',
                  landMark: businessProfile.businessDetails?.area ?? '',
                  category:
                      businessProfile.businessDetails?.subcategory?.categoryId.toString() ?? '',
                  subCategory:

                      businessProfile.businessDetails?.subcategory?.subcategoryId.toString() ?? '',
                  lat: businessProfile.businessDetails?.lat?.toString() ?? '',
                  long: businessProfile.businessDetails?.long?.toString() ?? '',
                  address: businessProfile.businessDetails?.address ?? '',
                  aadhaarFront: businessProfile.document?.adharFront ?? '',
                  aadhaarBack: businessProfile.document?.adharBack ?? '',
                  panImage: businessProfile.document?.panCardImage ?? '',
                  gstCertificate:
                      businessProfile.document?.gstCertificate ?? '',
                  businessLogo: businessProfile.document?.businessLogo ?? '',
                  weekOffDay:
                      businessProfile.timing?.weeklyOffDay?.toIso8601String() ??
                          '',
                  // openingHours: businessProfile.timing.openingHours!
                  //     ? {
                  //   "Mon": businessProfile.timing!.openingHours!.mon,
                  //   "Tue": businessProfile.timing!.openingHours!.tue,
                  //   "Wed": businessProfile.timing!.openingHours!.wed,
                  //   "Thu": businessProfile.timing!.openingHours!.thu,
                  //   "Fri": businessProfile.timing!.openingHours!.fri,
                  //   "Sat": businessProfile.timing!.openingHours!.sat,
                  //   "Sun": businessProfile.timing!.openingHours!.sun,
                  // }
                  //     : null,
                  businessImages: [],
                );
              }

              settingTitles = [
                {
                  "title": "Update Basic Detail",
                  "icon": Icons.person_add_alt_1_outlined,
                  "page": MerchantRegistration(
                      mobile: businessProfile!.vendor!.phone.toString(),
                      forUpdate: true,
                      merchantData: merchantRegistrationModel)
                },
                {
                  "title": "Update Your Business ",
                  "icon": Icons.business_center,
                  "page": BusinessDetails(
                    category: businessProfile.businessDetails?.category?.name,
                      subCategory: businessProfile.businessDetails?.subcategory?.name,
                      forUpdate: true, merchantData: merchantRegistrationModel!)
                },
                {
                  "title": "Update Documents",
                  "icon": Icons.document_scanner_rounded,
                  "page": UpdateDocuments(
                      forUpdate: true, merchantData: merchantRegistrationModel!)
                },
                {
                  "title": "Business Hours & Special Days",
                  "icon": Icons.timer_outlined,
                  "page": UpdateBusinessHours(
                      merchantData: merchantRegistrationModel!)
                },
                {
                  "title": "Help & Support",
                  "icon": Icons.help_outline_outlined
                },
                {"title": "Privacy Policy", "icon": Icons.privacy_tip_outlined},
                {"title": "Delete Account", "icon": Icons.delete_forever_sharp},
                {"title": "Logout", "icon": Icons.logout},
              ];
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<FetchBusinessDetailsBloc>()
                      .add(FetchBusinessDetailsDetailsEvent(context: context));
                },
                child: CustomScrollView(
                  slivers: [
                    customSliverAppbar(
                      expandedHeight: size.height * 0.2,
                      title: Text("Profile Settings",
                          style: AppStyle.medium_18(AppColors.themeColor)),
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
                                                    businessProfile!.document!
                                                            .businessLogo ??
                                                        '')),
                                          ),
                                          SizedBox(width: 6),
                                          // Text section
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
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
                                                              .medium_12(AppColors
                                                                  .blackColor),
                                                          overflow: TextOverflow
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
                                if (index != 7) {
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
    );
  }
}

Widget settingsWidget(
        {IconData? icon,
        Widget? trailingIcon,
        String? title,
        void Function()? onTap}) =>
    Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      color: AppColors.theme5,
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: AppColors.theme5.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5)),
            child: Icon(icon, color: AppColors.theme5.withOpacity(0.6))),
        title: Text(title.toString(),
            style: AppStyle.normal_16(AppColors.black20)),
        trailing: Icon(Icons.arrow_forward_ios_sharp,
            color: AppColors.theme5.withOpacity(0.5), size: 20),
      ),
    );
