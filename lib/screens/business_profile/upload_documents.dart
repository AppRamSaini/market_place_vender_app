import 'package:market_place_app/bloc/business_registration/create_business/business_registration_state.dart';
import 'package:market_place_app/bloc/business_registration/update_business/update_business_event.dart';
import 'package:market_place_app/data/models/merchant_business_profile_model.dart';
import '../../utils/exports.dart';

class UpdateDocuments extends StatefulWidget {
  final MerchantRegistrationModel merchantData;
  bool forUpdate;
  UpdateDocuments(
      {super.key, required this.merchantData, this.forUpdate = false});

  @override
  State<UpdateDocuments> createState() => _UpdateDocumentsState();
}

class _UpdateDocumentsState extends State<UpdateDocuments> {
  XFile? aadhaarFront;
  XFile? aadhaarBack;
  XFile? panFront;
  XFile? gstCertificate;

  Future _onUploadDocuments() async {
    widget.merchantData.aadhaarFront =
        'https://c.ndtvimg.com/2024-06/uklt4u6o_aadhar-card_625x300_11_June_24.jpeg';
    widget.merchantData.aadhaarBack =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQszLdbN9jF7SZi082r7AP_7nWdXBC32z59fpkm0C8KAA1zhpxOIGRhRFXSCg0ML2rIjHU&usqp=CAU';
    widget.merchantData.panImage =
        'https://5.imimg.com/data5/SELLER/Default/2023/7/329938637/BT/HX/FH/74529084/pre-printed-pan-card-500x500.jpg';
    widget.merchantData.gstCertificate =
        'https://i0.wp.com/suvastika.com/wp-content/uploads/2024/09/GST-Registration-Certificate_page-0001.jpg';

    List<BusinessImage>? businessImages = [
      BusinessImage(
          url:
              "https://i0.wp.com/suvastika.com/wp-content/uploads/2024/09/GST-Registration-Certificate_page-0001.jpg",
          filename: "image1.jpg"),
      BusinessImage(
          url:
              "https://b.zmtcdn.com/data/pictures/3/102003/31424cab04ec30777802a10ec5ff1a7e.jpg",
          filename: "image2.jpg"),
      BusinessImage(
          url:
              "https://b.zmtcdn.com/data/dish_photos/7ac/829f7a0220e6f01558f9f6a9da53d7ac.jpeg",
          filename: "image3.jpg"),
      BusinessImage(
          url:
              "https://b.zmtcdn.com/data/pictures/chains/3/102003/0d5a917dc4e8ed63e49a1da4101226bd.jpg",
          filename: "image3.jpg"),
      BusinessImage(
          url:
              "https://b.zmtcdn.com/data/pictures/chains/3/102003/b54d7bf184c2bb18a325f9ed25c8afb8.jpg?fit=around|960:500&crop=960:500;*,*",
          filename: "image3.jpg"),
    ];
    widget.merchantData.businessImages = businessImages!;

    if (widget.forUpdate) {
      context
          .read<UpdateMerchantBusinessBloc>()
          .add(UpdateMerchantRegistrationEvent(widget.merchantData, context));
    } else {
      context
          .read<BusinessRegistrationBloc>()
          .add(MerchantRegistrationEvent(widget.merchantData, context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
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
        ),
        BlocListener<BusinessRegistrationBloc, BusinessRegistrationState>(
          listener: (context, state) async {
            EasyLoading.dismiss();
            if (state is BusinessRegistrationLoading) {
              EasyLoading.show();
            } else if (state is BusinessRegistrationSuccess) {
              var data = state.merchantBusinessModel.data;
              final token = data!.token.toString();
              await LocalStorage.setString(Pref.token, token);
              final userId = data.user!.id.toString();
              await LocalStorage.setString(Pref.vendorId, userId);
              final message = state.merchantBusinessModel.message.toString();
              snackBar(context, message, AppColors.green);
              AppRouter().navigateTo(context, MerchantDashboard());
            } else if (state is BusinessRegistrationFailure) {
              snackBar(context, state.error.toString(), AppColors.redColor);
              EasyLoading.dismiss();
            }
          },
        )
      ],
      child: Scaffold(
        appBar: customAppbar(context: context, title: "Upload Documents"),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: backOrNextBtn(
          text2: widget.forUpdate ? 'Update' : 'Submit',
          hideOnBack: widget.forUpdate,
          minWidth: widget.forUpdate ? size.width * 0.9 : null,
          context: context,
          onBack: () => Navigator.pop(context),
          onNext: _onUploadDocuments,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.01),
                Text(
                    "Upload Aadhaar, PAN, GST or other required documents for business registration.",
                    style: AppStyle.medium_16(AppColors.black20)),
                SizedBox(height: size.height * 0.03),

                /// Aadhaar Card
                customExpentialTile(
                  context: context,
                  txt: "Aadhaar Card Images",
                  children: [
                    uploadDocumentsWidget(
                      docImage: widget.merchantData.aadhaarFront,
                      onRemove: () => setState(() => aadhaarFront = null),
                      onTap: () async {
                        final picked = await pickDocumentsWidget(context);
                        if (picked != null) {
                          setState(() => aadhaarFront = picked);
                        }
                      },
                      txt: "Upload Aadhaar (Front)",
                      file: aadhaarFront, // 🔹 file pass
                    ),
                    SizedBox(height: size.height * 0.01),
                    uploadDocumentsWidget(
                      docImage: widget.merchantData.aadhaarBack,
                      onTap: () async {
                        final picked = await pickDocumentsWidget(context);
                        if (picked != null) {
                          setState(() => aadhaarBack = picked);
                        }
                      },
                      txt: "Upload Aadhaar (Back)",
                      file: aadhaarBack,
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.025),

                /// PAN Card
                customExpentialTile(
                  context: context,
                  txt: "PAN Card ",
                  children: [
                    uploadDocumentsWidget(
                      docImage: widget.merchantData.panImage,
                      onTap: () async {
                        final picked = await pickDocumentsWidget(context);
                        if (picked != null) {
                          setState(() => panFront = picked);
                        }
                      },
                      txt: "Upload PAN Card (Front)",
                      file: panFront,
                    ),
                  ],
                ),

                SizedBox(height: size.height * 0.025),

                /// GST Certificate
                customExpentialTile(
                  context: context,
                  txt: "GST Certificate (Optional)",
                  children: [
                    uploadDocumentsWidget(
                      docImage: widget.merchantData.gstCertificate,
                      onTap: () async {
                        final picked = await pickDocumentsWidget(context);
                        if (picked != null) {
                          setState(() => gstCertificate = picked);
                        }
                      },
                      txt: "Upload GST Certificate",
                      file: gstCertificate,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Expansion Tile
Widget customExpentialTile(
        {required BuildContext context,
        required String txt,
        List<Widget> children = const <Widget>[]}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.theme5),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          dense: true,
          backgroundColor: AppColors.transparent,
          childrenPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(txt, style: AppStyle.medium_16(AppColors.black20)),
          subtitle: Text("Tap to expand",
              style: AppStyle.normal_12(AppColors.black20)),
          children: children,
        ),
      ),
    );
