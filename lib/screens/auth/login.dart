import 'package:market_place_app/screens/auth/otp_verify.dart';
import 'package:market_place_app/utils/exports.dart';

class LoginScreen extends StatefulWidget {
  final String? role;
  const LoginScreen({super.key , this.role});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    mobileController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          EasyLoading.dismiss();
          if (state is AuthLoading) {
            EasyLoading.show();
          } else if (state is AuthSuccess) {
            final message = state.user.message.toString();
            final status = state.user.status;
            if (status == true) {
              if (state.type == AuthFlowType.login) {
                snackBar(context, message, AppColors.green);
                AppRouter().navigateTo(
                    context,
                    OtpVerify(
                        mobileNumber: mobileController.text.toString(),
                        role: widget.role.toString()));
              }
            } else {
              snackBar(context, message, AppColors.redColor);
            }
          } else if (state is AuthFailure) {
            snackBar(context, state.error.toString(), AppColors.redColor);
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
                      child: Image.asset(Assets.loginImg)),
                  SizedBox(height: size.height * 0.1),

                  Text(widget.role=='vendor'?
                      "Login To MarketPlace":
                      "Welcome to the Sales Portal",
                      style: AppStyle.bold_28(AppColors.themeColor)),
                  SizedBox(height: 5),
                  Text(widget.role=='vendor'?
                      "Log in with your mobile number to manage your business, create coupons, and grow your customer base seamlessly.":
                      "Add new Vendor to the platform with ease. Enter their details, verify information, and ensure a smooth onboarding process.",
                      style: AppStyle.normal_14(AppColors.blackColor)),

                  SizedBox(height: size.height * 0.03),
                  Text("Mobile Number",
                      style: AppStyle.normal_14(AppColors.black20)),
                  SizedBox(height: size.height * 0.01),
                  customTextField(
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      hintText: 'Enter your mobile number',
                      controller: mobileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number';
                        } else if (value.length < 9) {
                          return 'Please enter minimum 10 characters of mobile number';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length > 9) {
                          FocusScope.of(context).unfocus();
                        }
                      }),

                  /*      SizedBox(height: size.height * 0.03),
                    customTextField(
                        hintText: 'Enter your email address',
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }

                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        }),
                    SizedBox(height: size.height * 0.03),
                    customTextField(
                      hintText: 'Enter your password',
                      controller: passwordController,
                      suffix: const Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Icon(Icons.visibility,
                              color: AppColors.blackColor)),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return "Please enter password";
                        }
                        return null;
                      },
                    ),*/
                  // SizedBox(height: size.height * 0.035),
                  // Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Flexible(
                  //           flex: 2,
                  //           child: Padding(
                  //               padding: const EdgeInsets.only(left: 10),
                  //               child: _myRadioButton(
                  //                   title: "Driver",
                  //                   value: 'driver',
                  //                   onChanged: (newValue) => setState(
                  //                       () => _selectedRole = newValue!),
                  //                   groupValue: _selectedRole))),
                  //       Flexible(
                  //           flex: 2,
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(left: 5),
                  //             child: _myRadioButton(
                  //                 title: "Admin",
                  //                 value: 'admin',
                  //                 onChanged: (newValue) => setState(
                  //                     () => _selectedRole = newValue!),
                  //                 groupValue: _selectedRole),
                  //           )),
                  //       Flexible(
                  //           flex: 3,
                  //           child: _myRadioButton(
                  //               title: "Support Team",
                  //               value: 'support',
                  //               onChanged: (newValue) =>
                  //                   setState(() => _selectedRole = newValue!),
                  //               groupValue: _selectedRole))
                  //     ]),
                  SizedBox(height: size.height * 0.05),
                  CustomButton(
                    minWidth: size.width,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(SendOtpRequested(
                            mobileController.text.toString(), context));
                      }
                    },
                    txt: "Send OTP",
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

Widget myRadioButton(
    {required String title,
    required String value,
    required String groupValue,
    required void Function(String?) onChanged,
    required void Function()? onClear,
    bool showBtn = true}) {
  return ListTile(
      hoverColor: Colors.transparent, // Remove hover effect
      focusColor: Colors.transparent, // Remove focus effect
      splashColor: Colors.transparent, // Optional: remove splash
      onTap: () {
        onChanged(value);
      },
      contentPadding: EdgeInsets.zero,
      dense: true,
      minLeadingWidth: 10,
      leading: SizedBox(
        width: 5,
        child: Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.themeColor,
        ),
      ),
      title: Text(
        title,
        style: AppStyle.normal_14(
          Colors.black,
        ),
      ),
      trailing: showBtn
          ? SizedBox(
              width: size.width * 0.07,
              height: size.height * 0.032,
              child: CustomButton2(onPressed: onClear, txt: 'X'))
          : null);
}
