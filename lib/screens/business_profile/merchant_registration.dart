import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:market_place_app/bloc/business_registration/update_business/update_business_event.dart';
import 'package:market_place_app/screens/business_profile/business_details.dart';
import 'package:market_place_app/screens/location/search_location.dart';
import 'package:market_place_app/utils/exports.dart';

class MerchantRegistration extends StatefulWidget {
  final String? mobile;
  bool forUpdate;
  final MerchantRegistrationModel? merchantData;
  MerchantRegistration(
      {super.key, this.mobile, this.forUpdate = false, this.merchantData});
  @override
  State<MerchantRegistration> createState() => _MerchantRegistrationState();
}

class _MerchantRegistrationState extends State<MerchantRegistration> {
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedCategoryID;
  String? selectedSubCategoryID;

  @override
  void initState() {
    super.initState();
    setData();
  }


  setData() {
    mobileController.text = widget.mobile.toString();
    if (widget.forUpdate) {
      nameController.text = widget.merchantData!.name.toString();
      emailController.text = widget.merchantData!.email.toString();
      pinController.text = widget.merchantData!.pinCode.toString();
      areaController.text = widget.merchantData!.landMark.toString();
      country.text = widget.merchantData!.country.toString();
      state.text = widget.merchantData!.state.toString();
      city.text = widget.merchantData!.city.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(context: context, title: "Owner & Contact Details"),
      body:
          BlocListener<UpdateMerchantBusinessBloc, UpdateMerchantBusinessState>(
        listener: (context, state) async {
          EasyLoading.dismiss();
          if (state is UpdateMerchantBusinessLoading) {
            EasyLoading.show();
          } else if (state is UpdateMerchantBusinessSuccess) {
            final message = state.merchantBusinessModel.message.toString();
            snackBar(context, message, AppColors.green);
            Navigator.pop(context);
          } else if (state is UpdateMerchantBusinessFailure) {
            snackBar(context, state.error.toString(), AppColors.redColor);
            EasyLoading.dismiss();
          }
        },
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Owner Name",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      hintText: 'Enter business owner name',
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please provide the owner's name";
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.01),
                  Text("Mobile Number",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.02),
                  customTextField(
                      readOnly: true,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      suffix:
                          Icon(Icons.verified_sharp, color: AppColors.green),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: 'Enter mobile number',
                      controller: mobileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter valid number';
                        } else if (value.length < 9) {
                          return 'Please enter a valid 10-digit mobile number';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),

                  Text("Email Address (Optional)",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                    hintText: 'Enter email address',
                    controller: emailController,
                    validator: validateEmail,
                  ),
                  SizedBox(height: size.height * 0.02),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Business Location",
                          style: AppStyle.medium_16(AppColors.black20)),
                      CustomButton3(
                          minWidth: size.width * 0.35,
                          onPressed: () => AppRouter()
                              .navigateTo(context, SearchLocationPage()),
                          bgColor: AppColors.theme10,
                          txtColor: AppColors.themeColor,
                          txt: "Fetch Address")
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),

                  CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,
                      dialogColor: Colors.grey.shade200,
                      textFieldDecoration: InputDecoration(
                          fillColor: AppColors.theme5,
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          filled: true,
                          suffixIcon:
                              const Icon(Icons.keyboard_arrow_down_sharp),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide.none))),

                  // Row(
                  //   children: [
                  //     Flexible(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("State",
                  //               style: AppStyle.medium_16(AppColors.black20)),
                  //           SizedBox(height: size.height * 0.01),
                  //           DropdownButton2<String>(
                  //             underline: Container(color: Colors.transparent),
                  //             isExpanded: true,
                  //             value: selectedState,
                  //             hint: Text('Select state',
                  //                 style: AppStyle.medium_16(AppColors.black20)),
                  //             items: stateList
                  //                 .map((item) => DropdownMenuItem<String>(
                  //                     value: item,
                  //                     child: Text(item.toString(),
                  //                         style: const TextStyle(
                  //                             fontSize: 12,
                  //                             color: Colors.black))))
                  //                 .toList(),
                  //             onChanged: (value) =>
                  //                 setState(() => selectedState = value),
                  //             iconStyleData: const IconStyleData(
                  //                 icon: Padding(
                  //                     padding: EdgeInsets.only(right: 5),
                  //                     child: Icon(Icons.keyboard_arrow_down,
                  //                         color: Colors.black45)),
                  //                 iconSize: 24),
                  //             buttonStyleData: ButtonStyleData(
                  //                 decoration: BoxDecoration(
                  //                     color: AppColors.white10,
                  //                     borderRadius: BorderRadius.circular(10))),
                  //             dropdownStyleData: DropdownStyleData(
                  //                 maxHeight:
                  //                     MediaQuery.sizeOf(context).height / 2,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10))),
                  //             menuItemStyleData: const MenuItemStyleData(
                  //               padding: EdgeInsets.symmetric(horizontal: 16),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     SizedBox(width: 10),
                  //     Flexible(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text("City",
                  //               style: AppStyle.medium_16(AppColors.black20)),
                  //           SizedBox(height: size.height * 0.01),
                  //           DropdownButton2<String>(
                  //             underline: Container(color: Colors.transparent),
                  //             isExpanded: true,
                  //             value: selectedCity,
                  //             hint: Text('Select city',
                  //                 style: AppStyle.medium_16(AppColors.black20)),
                  //             items: cityList
                  //                 .map((item) => DropdownMenuItem<String>(
                  //                     value: item,
                  //                     child: Text(item.toString(),
                  //                         style: const TextStyle(
                  //                             fontSize: 12,
                  //                             color: Colors.black))))
                  //                 .toList(),
                  //             onChanged: (value) =>
                  //                 setState(() => selectedCity = value),
                  //             iconStyleData: const IconStyleData(
                  //                 icon: Padding(
                  //                     padding: EdgeInsets.only(right: 5),
                  //                     child: Icon(Icons.keyboard_arrow_down,
                  //                         color: Colors.black45)),
                  //                 iconSize: 24),
                  //             buttonStyleData: ButtonStyleData(
                  //                 decoration: BoxDecoration(
                  //                     color: AppColors.white10,
                  //                     borderRadius: BorderRadius.circular(10))),
                  //             dropdownStyleData: DropdownStyleData(
                  //                 maxHeight:
                  //                     MediaQuery.sizeOf(context).height / 2,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.circular(10))),
                  //             menuItemStyleData: const MenuItemStyleData(
                  //               padding: EdgeInsets.symmetric(horizontal: 16),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),

                  /*        SizedBox(height: size.height * 0.01),
                  customTextField(
                      showPrefix: false,
                      hintText: 'Enter your county',
                      controller: countryController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter county';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.01),
                  Text("State", style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      showPrefix: false,
                      hintText: 'Enter your state',
                      controller: stateController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter state';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.01),
                  Text("City", style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      showPrefix: false,
                      hintText: 'Enter your city',
                      controller: cityController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city';
                        }
                        return null;
                      }),*/

                  SizedBox(height: size.height * 0.02),

                  Text("Pin code",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: 'Enter pin code',
                      controller: pinController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid pin code';
                        } else if (value.length < 6) {
                          return 'Please enter a valid 6-digit pin code';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Area/Landmark",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      showPrefix: false,
                      hintText: 'Enter your area',
                      controller: areaController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter area';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.05),
                  CustomButton(
                    minWidth: size.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (state.text.isEmpty) {
                          snackBar(
                              context,
                              'Please provide your business address',
                              AppColors.redColor);
                        } else {
                          if (widget.forUpdate) {
                            final updatedMerchant =
                                widget.merchantData!.copyWith(
                              name: nameController.text,
                              mobile: mobileController.text,
                              state: state.text,
                              city: city.text,
                              country: country.text,
                              email: emailController.text,
                              landMark: areaController.text,
                              pinCode: pinController.text,
                              lat: "26.9288279",
                              long: "75.7865834",
                              address:
                                  "${areaController.text}, ${city.text} ${state.text}, ${country.text} ${pinController.text}",
                            );

                            context.read<UpdateMerchantBusinessBloc>().add(
                                UpdateMerchantRegistrationEvent(
                                    updatedMerchant, context));
                          } else {
                            MerchantRegistrationModel merchantData =
                                MerchantRegistrationModel(
                                    name: nameController.text.toString(),
                                    mobile: mobileController.text.toString(),
                                    state: state.text.toString(),
                                    city: city.text.toString(),
                                    email: emailController.text.toString(),
                                    landMark: areaController.text.toString(),
                                    pinCode: pinController.text.toString(),
                                    lat: "26.9288279",
                                    long: "75.7865834",
                                    address:
                                        "${areaController.text.toString()}, ${city.text} ${state.text}, ${country.text} ${pinController.text}");

                            AppRouter().navigateTo(context,
                                BusinessDetailsPage(merchantData: merchantData));
                          }
                        }
                      }
                    },
                    txt: widget.forUpdate ? "Update" : "Next",
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
