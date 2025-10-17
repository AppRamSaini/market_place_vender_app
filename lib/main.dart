import 'package:firebase_core/firebase_core.dart';
import 'package:market_place_app/bloc/multi_bloc_providers.dart';
import 'package:market_place_app/data/storage/sharedpreferenc.dart';
import 'package:market_place_app/screens/business_profile/merchant_registration.dart';
import 'package:market_place_app/utils/exports.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Firebase Initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Local Storage
  await LocalStorage.init();

  await dotenv.load(fileName: ".env");

  /// Start App
  runApp(AppBlocProviders(child: MyApp()));

  /// EasyLoading config
  configLoading();
}
late Size size;
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.sizeOf(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Market Place',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.whiteColor,
        fontFamily: 'AlanSans',
        appBarTheme: AppBarTheme(
            centerTitle: false,
            backgroundColor: AppColors.whiteColor,
            iconTheme: IconThemeData(color: AppColors.themeColor)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}

var GOOGLE_MAP_API_KEY = "";
