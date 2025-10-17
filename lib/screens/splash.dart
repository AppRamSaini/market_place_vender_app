import 'package:market_place_app/screens/auth/get_started.dart';
import 'package:market_place_app/utils/exports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() async {
    // Fetch business categories
    context.read<BusinessCategoryCubit>().fetchBusinessCategory();

    // Get stored token and role
    String? token = LocalStorage.getString(Pref.token);
    String? role = LocalStorage.getString(Pref.roleType);
    String? vendorId = LocalStorage.getString(Pref.vendorId);

    // Optional: debug prints
    print('TOKEN==>>$token');
    print('ROLE==>>$role');
    print('Vendor ID==>>$vendorId');

    // Navigate after 2.5 seconds
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (token != null && role != null) {
        AppRouter().navigateAndClearStack(
            context,
            role == 'vendor'
                ? MerchantDashboard()
                : LoginScreen(role: role));
      } else {
        AppRouter().navigateAndClearStack(context, GetStarted());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; // Added for size reference
    return Scaffold(
      body: Image.asset(
        Assets.logoGIF,
        height: size.height,
        width: size.width,
        fit: BoxFit.cover,
      ),
    );
  }
}
