
import 'package:market_place_app/screens/business_profile/merchant_registration.dart';
import 'package:market_place_app/utils/exports.dart';

class OtpVerify extends StatefulWidget {
  final String mobileNumber;
  final String role;
  const OtpVerify({super.key, required this.mobileNumber, required this.role});

  @override
  State<OtpVerify> createState() => OtpVerifyState();
}

class OtpVerifyState extends State<OtpVerify> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final TapGestureRecognizer _tapGestureRecognizer = TapGestureRecognizer();

  Timer? timer;
  int startOtpTimer = 30;

  void startCountdownTimer() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    startOtpTimer = 30;
    timer = Timer.periodic(Duration(seconds: 1), (callback) {
      if (startOtpTimer == 0) {
        callback.cancel();
        setState(() {});
      } else {
        startOtpTimer--;
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    startCountdownTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
          fontSize: 22,
          color: AppColors.themeColor,
          fontWeight: FontWeight.bold),
      decoration: BoxDecoration(
          color: AppColors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.white10)));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<VerifyOtpBloc, VerifyOtpState>(
            listener: (context, state) async {
              EasyLoading.dismiss();
              if (state is OtpVerifyLoading) {
                EasyLoading.show();
              } else if (state is OtpVerifySuccess) {
                final message = state.userOtpModel.message.toString();
                snackBar(context, message, AppColors.green);
                final role = state.userOtpModel.data!.role.toString();
                if (state.userOtpModel.data!.token != null) {
                  final token = state.userOtpModel.data!.token.toString();
                  await LocalStorage.setString(Pref.token, token);
                }
                await LocalStorage.setString(Pref.roleType, role);
                // if (state.userOtpModel.data!.user != null && role=='vendor') {
                //   final userId = state.userOtpModel.data!.user!.id.toString();
                //   await LocalStorage.setString(Pref.vendorId, userId);
                // }
                if (role == 'vendor' && state.userOtpModel.data!.user != null) {
                  AppRouter()
                      .navigateAndClearStack(context, MerchantDashboard());
                } else {
                  AppRouter().navigateTo(
                      context,
                      MerchantRegistration(
                          mobile: widget.mobileNumber.toString()));
                }
              } else if (state is OtpVerifyFailure) {
                snackBar(context, state.error.toString(), Colors.red);
              }
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              EasyLoading.dismiss();
              if (state is AuthLoading) {
                EasyLoading.show();
              } else if (state is AuthSuccess) {
                if (state.user.status == true) {
                  if (state.type == AuthFlowType.resendOtp) {
                    startCountdownTimer();
                    _otpController.clear();
                    snackBar(
                        context, "Opt Resent Successfully", AppColors.green);
                  }
                } else {
                  snackBar(context, state.user.message.toString(),
                      AppColors.redColor);
                }
              } else if (state is AuthFailure) {
                snackBar(context, state.error.toString(), AppColors.redColor);
              }
            },
          )
        ],
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.035),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05),
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: CircleAvatar(
                          backgroundColor: AppColors.white10,
                          child: Icon(Icons.arrow_back_ios_new,
                              size: 20, color: AppColors.themeColor))),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                      padding: EdgeInsets.all(size.width * 0.02),
                      child: Image.asset(Assets.verifyOtpImg)),
                  SizedBox(height: size.height * 0.1),
                  Text("Verification OTP",
                      style: AppStyle.bold_28(AppColors.themeColor)),
                  SizedBox(height: 5),
                  Text(
                      "We’ve sent a 6-digit verification code to your Mobile Number. Please enter it below.",
                      style: AppStyle.normal_14(AppColors.blackColor)),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Pinput(
                      length: 6,
                      controller: _otpController,
                      defaultPinTheme: defaultPinTheme,
                      separatorBuilder: (_) => const SizedBox(width: 5),
                      validator: (v) {
                        if (_otpController.text == null ||
                            _otpController.text.isEmpty) {
                          return 'Please enter OTP';
                        } else if (_otpController.text.length < 6) {
                          return 'Please enter OTP';
                        }
                        return null;
                      },
                      onCompleted: (pin) async {},
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: AppColors.themeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  CustomButton(
                    minWidth: size.width,
                    onPressed: () async {
                      // FirebaseMessaging messaging = FirebaseMessaging.instance;
                      // await messaging.requestPermission(alert: true, badge: true, sound: true);
                      // String? token;
                      // if (Platform.isIOS) {
                      //   token = await messaging.getAPNSToken();
                      // } else {
                      //   token = await messaging.getToken();
                      // }
                      //
                      if (_formKey.currentState!.validate()) {
                        context.read<VerifyOtpBloc>().add(SubmitOtpEvent(
                            mobileNumber: widget.mobileNumber.toString(),
                            role: widget.role.toString(),
                            otp: _otpController.text.toString(),
                            context: context));
                      }
                    },
                    txt: "Verify OTP",
                  ),
                  SizedBox(height: size.height * 0.01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          startOtpTimer > 0
                              ? TextSpan(
                                  text: "Resend In $startOtpTimer sec",
                                  style:
                                      AppStyle.medium_16(AppColors.themeColor))
                              : TextSpan(
                                  text: "Resend OTP?",
                                  style:
                                      AppStyle.medium_16(AppColors.themeColor)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                  recognizer: _tapGestureRecognizer
                                    ..onTap = () {
                                      context.read<AuthBloc>().add(
                                          ResendOtpRequested(
                                              widget.mobileNumber.toString(),
                                              context));
                                    },
                                ),
                        ],
                      ),
                    ),
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
