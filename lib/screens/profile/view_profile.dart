import 'package:market_place_app/utils/exports.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  @override
  void initState() {
    super.initState();
    context
        .read<DriverProfileBloc>()
        .add(FetchDriverProfileEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Profile"),
      body: BlocBuilder<DriverProfileBloc, GetDriverState>(
        builder: (context, state) {
          if (state is DriverProfileLoading) {
            return profileSimmerLoading();
          } else if (state is DriverProfileFailure) {
            return Center(
                child: Text(state.error.toString(),
                    style: AppStyle.medium_14(AppColors.redColor)));
          } else if (state is DriverProfileSuccess) {
            final user = state.userProfileModel.data;

            return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<DriverProfileBloc>()
                      .add(FetchDriverProfileEvent(context: context));


                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      AppColors.themeColor.withOpacity(0.3))),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Container(
                                  height: size.height * 0.10,
                                  width: size.height * 0.10,
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: profilePickImage(user!
                                          .userDetail!.profilePhotoUrl
                                          .toString())),
                                ),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        capitalizeFirstLetter(
                                            user!.name.toString()),
                                        style: AppStyle.medium_16(
                                            AppColors.green)),
                                    Text(
                                        capitalizeFirstLetter(
                                            user!.mobileNumber.toString()),
                                        style: AppStyle.medium_14(
                                            AppColors.blackColor)),
                                    Text(
                                        capitalizeFirstLetter(
                                            user!.email.toString()),
                                        style: AppStyle.medium_14(
                                            AppColors.blackColor)),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      AppColors.themeColor.withOpacity(0.3))),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text("Vehicle Type : ",
                                          style: AppStyle.medium_14(
                                              AppColors.blackColor))),
                                  Expanded(
                                    child: Text(
                                        capitalizeFirstLetter(user!
                                            .userDetail!.vehicleType
                                            .toString()),
                                        style: AppStyle.medium_14(
                                            AppColors.blackColor)),
                                  ),
                                ],
                              ),
                              Divider(
                                  color: AppColors.greyColor.withOpacity(.2),
                                  thickness: 0.5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text("Vehicle Number : ",
                                          style: AppStyle.medium_14(
                                              AppColors.blackColor))),
                                  Expanded(
                                    child: Text(
                                        capitalizeFirstLetter(user!
                                            .userDetail!.vehicleNumber
                                            .toString()),
                                        style: AppStyle.medium_14(
                                            AppColors.blackColor)),
                                  ),
                                ],
                              ),
                              Divider(
                                  color: AppColors.greyColor.withOpacity(.2),
                                  thickness: 0.5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text("Licence Number : ",
                                          style: AppStyle.medium_14(
                                              AppColors.blackColor))),
                                  Expanded(
                                    child: Text(
                                        capitalizeFirstLetter(user!
                                            .userDetail!.drivingLicenseNumber
                                            .toString()),
                                        style: AppStyle.medium_14(
                                            AppColors.blackColor)),
                                  ),
                                ],
                              ),
                              Divider(
                                  color: AppColors.greyColor.withOpacity(.2),
                                  thickness: 0.5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Text("Address : ",
                                          style: AppStyle.medium_14(
                                              AppColors.blackColor))),
                                  Expanded(
                                    child: Text(
                                        capitalizeFirstLetter(user!
                                            .userDetail!.address
                                            .toString()),
                                        style: AppStyle.medium_14(
                                            AppColors.blackColor)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Vehicle Photo",
                            style: AppStyle.medium_14(AppColors.blackColor)),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      AppColors.themeColor.withOpacity(0.3))),
                          child: GestureDetector(
                            // onTap: ()=>AppRouter().navigateTo(context, FullImageView(imageUrl: user!.userDetail!.vehiclePhotoUrl.toString())),

                            child: Container(
                              height: size.height * 0.15,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: profilePickImage(user!
                                      .userDetail!.vehiclePhotoUrl
                                      .toString())),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Licence Photo",
                            style: AppStyle.medium_14(AppColors.blackColor)),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      AppColors.themeColor.withOpacity(0.3))),
                          child: GestureDetector(
                            // onTap: ()=>AppRouter().navigateTo(context, FullImageView(imageUrl: user!.userDetail!.drivingLicenseDocUrl.toString())),

                            child: Container(
                              height: size.height * 0.15,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: profilePickImage(user!
                                      .userDetail!.drivingLicenseDocUrl
                                      .toString())),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Driver Aadhaar Card Photo",
                            style: AppStyle.medium_14(AppColors.blackColor)),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color:
                                      AppColors.themeColor.withOpacity(0.3))),
                          child: GestureDetector(
                            // onTap: ()=>AppRouter().navigateTo(context, FullImageView(imageUrl: user!.userDetail!.aadharDocUrl.toString())),
                            child: Container(
                              height: size.height * 0.15,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: ClipRRect(

                                  borderRadius: BorderRadius.circular(10),
                                  child: profilePickImage(
                                      user!.userDetail!.aadharDocUrl.toString())),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
