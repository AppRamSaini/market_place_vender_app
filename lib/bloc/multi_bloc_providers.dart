import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_bloc.dart';
import 'package:market_place_app/bloc/business_registration/update_business/update_business_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/delete_offers/delete_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_dashbaord_offers/dashboard_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/fetch_offers/fetch_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/update_offers/update_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/view_offers_details/view_offers_bloc.dart';
import 'package:market_place_app/utils/exports.dart';

class AppBlocProviders extends StatelessWidget {
  final Widget child;
  const AppBlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<VerifyOtpBloc>(create: (context) => VerifyOtpBloc()),
        BlocProvider<BusinessRegistrationBloc>(
            create: (context) => BusinessRegistrationBloc()),
        BlocProvider<BusinessCategoryCubit>(
            create: (context) => BusinessCategoryCubit()),
        BlocProvider<BusinessSubCategoryCubit>(
            create: (context) => BusinessSubCategoryCubit()),
        BlocProvider<AddOffersBloc>(create: (context) => AddOffersBloc()),
        BlocProvider<FetchOffersBloc>(create: (context) => FetchOffersBloc()),
        BlocProvider<DisableOffersBloc>(
            create: (context) => DisableOffersBloc()),
        BlocProvider<DeleteOffersBloc>(create: (context) => DeleteOffersBloc()),
        BlocProvider<UpdateOffersBloc>(create: (context) => UpdateOffersBloc()),
        BlocProvider<ViewOffersBloc>(create: (context) => ViewOffersBloc()),
        BlocProvider<UpdateMerchantBusinessBloc>(
            create: (context) => UpdateMerchantBusinessBloc()),
        BlocProvider<FetchBusinessDetailsBloc>(
            create: (context) => FetchBusinessDetailsBloc()),
        BlocProvider<FetchDashboardOffersBloc>(
            create: (context) => FetchDashboardOffersBloc()),







        BlocProvider<DriverProfileBloc>(
            create: (context) => DriverProfileBloc()),
        BlocProvider<UpdateProfileBloc>(
            create: (context) => UpdateProfileBloc()),
        BlocProvider<NotificationsBloc>(
            create: (context) => NotificationsBloc()),
        BlocProvider<NotificationsUpdateBloc>(
            create: (context) => NotificationsUpdateBloc()),
        BlocProvider<SupportBloc>(create: (context) => SupportBloc()),
      ],
      child: child,
    );
  }
}
