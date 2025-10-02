
import 'package:market_place_app/utils/exports.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final drivingLicController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String imgUrl = '';

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    nameController.dispose();
    drivingLicController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final driverProfileState = context.read<DriverProfileBloc>().state;
    if (driverProfileState is DriverProfileSuccess) {
      final profile = driverProfileState.userProfileModel.data;
      nameController.text = profile!.name ?? "";
      emailController.text = profile.email ?? "";
      addressController.text = profile.userDetail!.address ?? "";
      drivingLicController.text =
          profile.userDetail!.drivingLicenseNumber.toString();
      imgUrl = profile.userDetail!.profilePhotoUrl.toString();
    }
  }

  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: "Edit Profile"),
      body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is UpdateProfileLoading) {
            EasyLoading.show();
          } else if (state is UpdateProfileSuccess) {
            snackBar(context, "Profile updated successfully");
            context
                .read<DriverProfileBloc>()
                .add(FetchDriverProfileEvent(context: context));
            Navigator.pop(context);
          } else if (state is UpdateProfileFailure) {
            snackBar(context, state.error.toString(), AppColors.redColor);
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.02),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          color: AppColors.redColor,
                          dashPattern: [25, 25, 25, 25],
                          padding: EdgeInsets.all(10),
                          radius: Radius.circular(100),
                          child: Container(
                            height: size.height * 0.15,
                            decoration: BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle),
                            child: Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                height: size.height * 0.15,
                                decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    shape: BoxShape.circle),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    height: size.height * 0.13,
                                    decoration: BoxDecoration(
                                        color: AppColors.themeColor,
                                        shape: BoxShape.circle),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: _pickedImage != null
                                            ? Image.file(
                                                File(_pickedImage!.path),
                                                width: size.height * 0.13,
                                                height: size.height * 0.13,
                                                fit: BoxFit.cover)
                                            : profilePickImage(imgUrl)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.1,
                        right: size.width * 0.3,
                        child: GestureDetector(
                          onTap: () async {
                            _pickedImage = await pickImageSheet(context);
                            setState(() {});
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColors.themeColor,
                            child: Icon(Icons.camera_alt_rounded,
                                color: AppColors.whiteColor),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.025),
                  Text("Name", style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(

                      controller: nameController,
                      hintText: 'Enter your name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.025),
                  Text("Email Address",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                    controller: emailController,

                    hintText: 'Enter your email address',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter your email address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.025),
                  Text("License Number",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                    controller: drivingLicController,

                    hintText: 'Enter license number',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter your license number";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.025),
                  Text("Address",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.01),
                  CustomTextField(
                    controller: addressController,
                    hintText: 'Enter your address',
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: size.height * 0.035),
                  CustomButton(
                    minWidth: size.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<UpdateProfileBloc>().add(
                            UpdateProfileSubmitted(
                                context: context,
                                email: emailController.text.toString(),
                                name: nameController.text.toString(),
                                address: addressController.text.toString(),
                                licenseNo: drivingLicController.text.toString(),
                                imageFile: _pickedImage ?? null));
                      }
                    },
                    txt: "Submit",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
