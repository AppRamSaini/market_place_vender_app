import 'package:market_place_app/bloc/business_registration/update_business/update_business_event.dart';
import 'package:market_place_app/utils/exports.dart';

class BusinessDetailsPage extends StatefulWidget {
  final MerchantRegistrationModel merchantData;
  bool forUpdate;
  final String? category;
  final String? subCategory;
  final String? categoryID;

  BusinessDetailsPage(
      {super.key,
      required this.merchantData,
      this.forUpdate = false,
      this.category,
      this.subCategory,
      this.categoryID});
  @override
  State<BusinessDetailsPage> createState() => BusinessDetailsPageState();
}

class BusinessDetailsPageState extends State<BusinessDetailsPage> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessNoController = TextEditingController();
  final TextEditingController gstNoController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    businessNameController.dispose();
    businessNoController.dispose();
    gstNoController.dispose();
    super.dispose();
  }

  String? selectedCategory;
  String? selectedSubCategory;
  String? selectedCategoryID;
  String? selectedSubCategoryID;
  String ?businessLogoImg;

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() {
    if (widget.forUpdate) {
      businessNameController.text = widget.merchantData.businessName ?? '';
      businessNoController.text =
          widget.merchantData.businessRegistrationNo ?? '';
      gstNoController.text = widget.merchantData.gstNumber ?? '';
      selectedCategoryID = widget.merchantData.category ?? '';
      selectedSubCategoryID = widget.merchantData.subCategory ?? '';
      selectedCategory = widget.category ?? '';
      selectedSubCategory = widget.subCategory ?? '';
      businessLogoImg = widget.merchantData.businessLogo??'';
      // Fetch subcategories for the selected category
      if (widget.categoryID != null) {

        context
            .read<BusinessSubCategoryCubit>()
            .fetchBusinessSubCategory(widget.categoryID.toString());
      }
    }
  }

  XFile? businessLogo;
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMerchantBusinessBloc,
            UpdateMerchantBusinessState>(
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
        child: Scaffold(
          appBar: customAppbar(
              context: context,
              title: "${widget.forUpdate ? 'Update' : ''} Business Details"),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: backOrNextBtn(
              text2: widget.forUpdate ? 'Update' : 'Next',
              hideOnBack: widget.forUpdate,
              minWidth: widget.forUpdate ? size.width * 0.9 : null,
              context: context,
              onBack: () => Navigator.pop(context),
              onNext: () {
                widget.merchantData.businessName =
                    businessNameController.text.toString();
                widget.merchantData.businessRegistrationNo =
                    businessNoController.text.toString();
                widget.merchantData.gstNumber = gstNoController.text.toString();
                widget.merchantData.businessLogo =
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFDGXBQ_MjMnps2kXxjQLYPN8WerAf2iJKSA&s";
                widget.merchantData.category = selectedCategoryID.toString();
                widget.merchantData.subCategory =
                    selectedSubCategoryID.toString();
                if (_formKey.currentState!.validate()) {
                  if (selectedCategoryID == null) {
                    snackBar(context, 'Please select your business category',
                        AppColors.redColor);
                  } else if (selectedSubCategoryID == null) {
                    snackBar(
                        context,
                        'Please select your business sub-category',
                        AppColors.redColor);
                  } else {
                    if (widget.forUpdate) {
                      context.read<UpdateMerchantBusinessBloc>().add(
                          UpdateMerchantRegistrationEvent(
                              widget.merchantData, context));
                    } else {
                      AppRouter().navigateTo(
                          context,
                          UpdateBusinessHours(
                              merchantData: widget.merchantData));
                    }
                  }
                }
              }),
          body: Padding(
            padding: EdgeInsets.all(size.width * 0.04),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Business Name",
                        style: AppStyle.medium_16(AppColors.black20)),
                    SizedBox(height: size.height * 0.01),
                    customTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Business name',
                        controller: businessNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your business name';
                          }
                          return null;
                        }),
                    SizedBox(height: size.height * 0.02),
                    Text("Business Registration Number (Optional)",
                        style: AppStyle.medium_16(AppColors.black20)),
                    SizedBox(height: size.height * 0.01),
                    customTextField(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter business registration no',
                        controller: businessNoController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter business registration no';
                          }
                          return null;
                        }),
                    SizedBox(height: size.height * 0.02),
                    Text("GST Number (Optional)",
                        style: AppStyle.medium_16(AppColors.black20)),
                    SizedBox(height: size.height * 0.01),
                    customTextField(
                      keyboardType: TextInputType.text,
                      hintText: 'Enter gst number',
                      controller: gstNoController,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        // Category Dropdown
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Business Category",
                                  style: AppStyle.medium_16(AppColors.black20)),
                              SizedBox(height: size.height * 0.01),
                              BlocBuilder<BusinessCategoryCubit,
                                  BusinessCategoryState>(
                                builder: (context, state) {
                                  if (state is BusinessCategoryLoaded) {
                                    var categories =
                                        state.categoryData.data ?? [];

                                    return DropdownButton2<String>(
                                      isExpanded: true,
                                      value: selectedCategory,
                                      barrierColor: AppColors.theme5,
                                      hint: Text('Select category',
                                          style: AppStyle.normal_15(
                                              AppColors.black20)),
                                      items: categories.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item.name,
                                          onTap: () => setState(() =>
                                              selectedCategoryID =
                                                  item!.id!.toString()),
                                          child: Text(item.name.toString(),
                                              style: AppStyle.normal_16(
                                                  AppColors.black20)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategory = value;
                                          selectedSubCategory =
                                              null; // Reset subcategory on category change
                                        });

                                        // // Fetch subcategory based on selected category
                                        var selectedCat = categories
                                            .firstWhere((c) => c.name == value);

                                        print(selectedCat.datumId.toString());
                                        context
                                            .read<BusinessSubCategoryCubit>()
                                            .fetchBusinessSubCategory(
                                                selectedCat.datumId.toString());
                                      },
                                      underline: Container(),
                                      iconStyleData: const IconStyleData(
                                          icon: Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
                                              child: Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.black45)),
                                          iconSize: 24),
                                      buttonStyleData: ButtonStyleData(
                                        padding: EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                          color: AppColors.theme5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight:
                                            MediaQuery.sizeOf(context).height /
                                                2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 10),

                        // Subcategory Dropdown
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sub Category",
                                  style: AppStyle.medium_16(AppColors.black20)),
                              SizedBox(height: size.height * 0.01),
                              BlocBuilder<BusinessSubCategoryCubit,
                                  BusinessSubCategoryState>(
                                builder: (context, state) {
                                  if (state is BusinessSubCategoryLoaded) {
                                    var subcategories =
                                        state.subCategoryData.data ?? [];
                                    return DropdownButton2<String>(
                                      isExpanded: true,
                                      value: selectedSubCategory,
                                      hint: Text('Sub category',
                                          style: AppStyle.normal_15(
                                              AppColors.black20)),
                                      items: subcategories.map((item) {
                                        return DropdownMenuItem<String>(
                                            value: item.name,
                                            onTap: () => setState(() =>
                                                selectedSubCategoryID =
                                                    item!.id.toString()),
                                            child: Text(item.name.toString(),
                                                style: AppStyle.normal_15(
                                                    AppColors.black20)));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(
                                            () => selectedSubCategory = value);
                                      },
                                      underline: Container(),
                                      iconStyleData: const IconStyleData(
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(Icons.keyboard_arrow_down,
                                              color: Colors.black45),
                                        ),
                                        iconSize: 24,
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        decoration: BoxDecoration(
                                          color: AppColors.theme5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight:
                                            MediaQuery.sizeOf(context).height /
                                                2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                    );
                                  } else {
                                    final List<String> defaultData = [];
                                    return DropdownButton2<String>(
                                      isExpanded: true,
                                      value: selectedSubCategory,
                                      hint: Text('Sub category',
                                          style: AppStyle.normal_15(
                                              AppColors.black20)),
                                      items: defaultData.map((item) {
                                        return DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item.toString(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black)),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(
                                            () => selectedSubCategory = value);
                                      },
                                      underline: Container(),
                                      iconStyleData: const IconStyleData(
                                        icon: Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(Icons.keyboard_arrow_down,
                                              color: Colors.black45),
                                        ),
                                        iconSize: 24,
                                      ),
                                      buttonStyleData: ButtonStyleData(
                                        decoration: BoxDecoration(
                                          color: AppColors.theme5,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight:
                                            MediaQuery.sizeOf(context).height /
                                                2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5)),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text("Business Logo / Image (Optional)",
                        style: AppStyle.medium_16(AppColors.black20)),
                    SizedBox(height: size.height * 0.01),
                    SizedBox(
                      width: size.width * 0.6,
                      child: uploadDocumentsWidget(
                        docImage: businessLogoImg,
                        onRemove: () => setState(() => businessLogo = null),
                        onTap: () async {
                          final picked = await pickDocumentsWidget(context);
                          if (picked != null) {
                            setState(() => businessLogo = picked);
                          }
                        },
                        txt: "Business Logo / Image",
                        file: businessLogo,
                      ),
                    ),
                    SizedBox(height: size.height * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
