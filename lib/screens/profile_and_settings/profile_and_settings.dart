import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_bloc.dart';
import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_event.dart';
import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_state.dart';
import 'package:market_place_app/data/models/merchant_business_profile_model.dart';
import 'package:market_place_app/screens/business_profile/business_details.dart';
// import 'package:market_place_app/screens/business_profile/business_details.dart';
import 'package:market_place_app/screens/business_profile/business_gallery.dart';
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

  Future _reFetchData() async => context
      .read<FetchBusinessDetailsBloc>()
      .add(FetchBusinessDetailsDetailsEvent(context: context));

  @override
  Widget build(BuildContext context) {
    _reFetchData();
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
                    "icon": Icons.delete_forever_sharp
                  },
                  {"title": "Logout", "icon": Icons.logout},
                ];
                return RefreshIndicator(
                  onRefresh: _reFetchData,
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
                                                                .bold_11(AppColors
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
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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

class ShimmerScreen extends StatelessWidget {
  const ShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade900,
        highlightColor: Colors.grey.shade800,
        direction: ShimmerDirection.ttb,
        period: const Duration(milliseconds: 2000),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Placeholder
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[900],
                ),
              ),
              const SizedBox(height: 20),

              // Title line
              Container(
                height: 20,
                width: 220,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 10),

              // Subtitle line
              Container(
                height: 16,
                width: 120,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 10),

              // Long text
              Container(
                height: 16,
                width: double.infinity,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 10),
              // Small line
              Container(
                height: 16,
                width: 100,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 20),
              // 4 Rounded Buttons Row
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(4, (index) {
                  return Container(
                    height: 60,
                    width: (MediaQuery.of(context).size.width - 52) / 2,
                    decoration: BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),

              // Divider
              Container(
                  height: 1, width: double.infinity, color: Colors.grey[900]),
              const SizedBox(height: 20),

              // Small lines row
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Another text line
              Container(height: 20, width: 180, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 20),

              // Small lines row
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 20,
                    width: 40,
                    color: Colors.grey[900],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Another text line
              Container(height: 20, width: 180, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[900],
              ),
              const SizedBox(height: 20),

              // Small lines row
              Container(height: 20, width: 120, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(height: 20, width: 180, color: Colors.grey[900]),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: double.infinity,
                color: Colors.grey[900],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
