import 'package:intl/intl.dart';
import 'package:market_place_app/bloc/merchant_offers/add_offers/add_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_state.dart';
import 'package:market_place_app/data/models/fetchoffers_model.dart';
import 'package:market_place_app/utils/exports.dart';

class CreateOffers extends StatefulWidget {
  final OffersList? data;
  final bool forUpdate;
  const CreateOffers({super.key, this.data, this.forUpdate = false});
  @override
  State<CreateOffers> createState() => _CreateOffersState();
}

class _CreateOffersState extends State<CreateOffers> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController minBillController = TextEditingController();
  final TextEditingController offersAmtController = TextEditingController();
  final TextEditingController maxAmtController = TextEditingController();
  final TextEditingController validDateController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.forUpdate) {
      setData();
    }
  }

  void setData() {
    if (widget.data != null) {
      selectedOfferType = widget.data!.type!.toString() ?? '';
      if (widget.data!.flat != null) {
        titleController.text = widget.data!.flat!.title ?? '';
        descriptionController.text = widget.data!.flat!.description ?? '';
        minBillController.text =
            widget.data!.flat!.minBillAmount?.toString() ?? '';
        offersAmtController.text = widget.data!.flat!.amount?.toString() ?? '';
        maxAmtController.text =
            widget.data!.flat!.maxDiscountCap?.toString() ?? '';
        offerImageUrl = widget.data!.flat!.offerImage?.toString() ?? '';

        if (widget.data!.flat!.expiryDate != null) {
          expiryDate =
              DateFormat('yyyy-MM-dd').format(widget.data!.flat!.expiryDate!);
          formattedDate =
              DateFormat('dd MMMM yy').format(widget.data!.flat!.expiryDate!);
          validDateController?.text = formattedDate!;
        }
        selectedDiscount =
            "${widget.data!.flat!.discountPercentage?.toString() ?? ''}% OFF";
      }

      // Agar percentage offer available hai
      if (widget.data!.percentage != null) {
        titleController.text = widget.data!.percentage!.title ?? '';
        descriptionController.text = widget.data!.percentage!.description ?? '';
        minBillController.text =
            widget.data!.percentage!.minBillAmount?.toString() ?? '';
        offersAmtController.text =
            widget.data!.percentage!.amount?.toString() ?? '';
        maxAmtController.text =
            widget.data!.percentage!.maxDiscountCap?.toString() ?? '';
        offerImageUrl = widget.data!.percentage!.offerImage?.toString() ?? '';

        if (widget.data!.percentage!.expiryDate != null) {
          expiryDate = DateFormat('yyyy-MM-dd')
              .format(widget.data!.percentage!.expiryDate!);
          formattedDate = DateFormat('dd MMMM yy')
              .format(widget.data!.percentage!.expiryDate!);
          validDateController?.text = formattedDate!;
        }
        selectedDiscount =
            "${widget.data!.percentage!.discountPercentage?.toString() ?? ''}% OFF";
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    minBillController.dispose();
    offersAmtController.dispose();
    maxAmtController.dispose();
    validDateController.dispose();
    super.dispose();
  }

  DateTime selectedDate = DateTime.now();
  String? expiryDate;
  String? formattedDate;
  XFile? offerImage;
  String? offerImageUrl;

  void updateDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (picked != null) {
      setState(() {
        validDateController!.clear();
        selectedDate = picked;
        expiryDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        formattedDate = DateFormat('dd MMMM yy').format(selectedDate);
        validDateController?.text = formattedDate!;
      });
    }
  }

  String? selectedDiscount;
  String? selectedOfferType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
          context: context,
          title: widget.forUpdate ? "Update Offer" : "Add New Offer"),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AddOffersBloc, AddOffersState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is AddOffersLoading) {
                EasyLoading.show();
              } else if (state is AddOffersSuccess) {
                final message = state.offersModel.message.toString();
                snackBar(context, message, AppColors.green);
                Navigator.pop(context);
              } else if (state is AddOffersFailure) {
                snackBar(context, state.error.toString(), AppColors.redColor);
              }
            },
          ),
          BlocListener<UpdateOffersBloc, UpdateOffersState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is UpdateOffersLoading) {
                EasyLoading.show();
              } else if (state is UpdateOffersSuccess) {
                final message = state.offersData.message.toString();
                snackBar(context, message, AppColors.green);
                Navigator.pop(context);
              } else if (state is UpdateOffersFailure) {
                snackBar(context, state.error.toString(), AppColors.redColor);
              }
            },
          ),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Upload OFFER Image",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  uploadDocumentsWidget(
                    docImage: offerImageUrl,
                    onTap: () async {
                      final picked = await pickDocumentsWidget(context);
                      if (picked != null) {
                        setState(() => offerImage = picked);
                      }
                    },
                    txt: "Upload OFFER Image",
                    file: offerImage,
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text("Offer Title",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      keyboardType: TextInputType.text,
                      hintText: 'Offer title',
                      controller: titleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please offer title';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Description(optional)",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      maxLines: 3,
                      minLines: 1,
                      hintText: 'Describe your offers here...',
                      controller: descriptionController),
                  SizedBox(height: size.height * 0.02),
                  Text("Offer Type",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  DropdownButton2<String>(
                    underline: Container(color: Colors.transparent),
                    isExpanded: true,
                    value: selectedOfferType,
                    barrierColor: AppColors.theme5,
                    hint: Text('Select offer type',
                        style: AppStyle.normal_16(AppColors.black20)),
                    items: offerTypeList
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item.toString().toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black))))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedOfferType = value),
                    iconStyleData: const IconStyleData(
                        icon: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.keyboard_arrow_down,
                                color: Colors.black45)),
                        iconSize: 24),
                    buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            color: AppColors.theme5,
                            borderRadius: BorderRadius.circular(10))),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: MediaQuery.sizeOf(context).height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10))),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text("Discount % OFF",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  DropdownButton2<String>(
                    underline: Container(color: Colors.transparent),
                    isExpanded: true,
                    value: selectedDiscount,
                    barrierColor: AppColors.theme5,
                    hint: Text('Select Discount % OFF',
                        style: AppStyle.normal_16(AppColors.black20)),
                    items: categoryList
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item.toString(),
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.black))))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => selectedDiscount = value),
                    iconStyleData: const IconStyleData(
                        icon: Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.keyboard_arrow_down,
                                color: Colors.black45)),
                        iconSize: 24),
                    buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                            color: AppColors.theme5,
                            borderRadius: BorderRadius.circular(10))),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: MediaQuery.sizeOf(context).height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10))),
                    menuItemStyleData: const MenuItemStyleData(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text("Min Bill Amount",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      prefix: Icon(Icons.currency_rupee, size: 18),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: 'Enter bill amount',
                      controller: minBillController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter bill amount';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Offer Amount",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      prefix: Icon(Icons.currency_rupee, size: 18),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: 'Enter offers amount',
                      controller: offersAmtController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter offers amount';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Maximum Discount",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      prefix: Icon(Icons.currency_rupee, size: 18),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: 'Enter maximum discount',
                      controller: maxAmtController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter maximum discount';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.02),
                  Text("Valid Till",
                      style: AppStyle.medium_16(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      readOnly: true,
                      showPrefix: false,
                      hintText: 'Select offers valid date',
                      controller: validDateController,
                      suffix: GestureDetector(
                          onTap: () => updateDate(),
                          child: Icon(Icons.date_range)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter offers valid date';
                        }
                        return null;
                      }),
                  SizedBox(height: size.height * 0.05),
                  CustomButton(
                    minWidth: size.width,
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      AddOffersModel offersData = AddOffersModel(
                          titleController.text.toString(),
                          descriptionController.text.toString(),
                          expiryDate.toString(),
                          int.parse(selectedDiscount
                              .toString()
                              .replaceAll("% OFF", '')),
                          maxAmtController.text.toString(),
                          minBillController.text.toString(),
                          offersAmtController.text.toString(),
                          "https://mediabrief.com/wp-content/uploads/2021/11/IMAGE-Woovlys-Black-Friday-Sale-offers-FLAT-50-off-MEDIABRIEF.png",
                          selectedOfferType);
                      if (_formKey.currentState!.validate()) {
                        if (widget.forUpdate) {
                          context.read<UpdateOffersBloc>().add(
                              SubmitUpdateOffersEvent(offersData, context,
                                  widget.data!.id.toString()));
                        } else {
                          context
                              .read<AddOffersBloc>()
                              .add(SubmitOffersEvent(offersData, context));
                        }
                      }
                    },
                    txt: widget.forUpdate ? "Update Now" : "Submit",
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String> categoryList = [
  "10% OFF",
  "20% OFF",
  "30% OFF",
  "40% OFF",
  "50% OFF",
  "60% OFF",
  "70% OFF",
];
List<String> offerTypeList = ["flat", "percentage"];
