
import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_bloc.dart';
import 'package:market_place_app/bloc/business_registration/update_business/update_business_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/delete_offers/delete_offers_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/disable_offers/disable_offers_bloc.dart';
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
        BlocProvider<BusinessRegistrationBloc>(create: (context) => BusinessRegistrationBloc()),
        BlocProvider<BusinessCategoryCubit>(create: (context) => BusinessCategoryCubit()),
        BlocProvider<BusinessSubCategoryCubit>(create: (context) => BusinessSubCategoryCubit()),
        BlocProvider<AddOffersBloc>(create: (context) => AddOffersBloc()),
        BlocProvider<FetchOffersBloc>(create: (context) => FetchOffersBloc()),
        BlocProvider<DisableOffersBloc>(create: (context) => DisableOffersBloc()),
        BlocProvider<DeleteOffersBloc>(create: (context) => DeleteOffersBloc()),
        BlocProvider<UpdateOffersBloc>(create: (context) => UpdateOffersBloc()),
        BlocProvider<ViewOffersBloc>(create: (context) => ViewOffersBloc()),
        BlocProvider<UpdateMerchantBusinessBloc>(create: (context) => UpdateMerchantBusinessBloc()),
        BlocProvider<FetchBusinessDetailsBloc>(create: (context) => FetchBusinessDetailsBloc()),







        BlocProvider<DriverProfileBloc>(
            create: (context) => DriverProfileBloc()),
        BlocProvider<UpdateProfileBloc>(
            create: (context) => UpdateProfileBloc()),
        BlocProvider<HomeDataBloc>(create: (context) => HomeDataBloc()),
        BlocProvider<DeliveryDataBloc>(create: (context) => DeliveryDataBloc()),
        BlocProvider<DeliveryDetailsBloc>(
            create: (context) => DeliveryDetailsBloc()),
        BlocProvider<IssueReportBloc>(create: (context) => IssueReportBloc()),
        BlocProvider<FetchIssueReportHistoryBloc>(
            create: (context) => FetchIssueReportHistoryBloc()),
        BlocProvider<FetchIssueReportDetailsBloc>(
            create: (context) => FetchIssueReportDetailsBloc()),
        BlocProvider<CreateIssueReportBloc>(
            create: (context) => CreateIssueReportBloc()),
        BlocProvider<DeliveryActionsBloc>(
            create: (context) => DeliveryActionsBloc()),
        BlocProvider<UpdateLatLngBloc>(create: (context) => UpdateLatLngBloc()),
        BlocProvider<SosBloc>(create: (context) => SosBloc()),
        BlocProvider<SosCancelBloc>(create: (context) => SosCancelBloc()),
        BlocProvider<NotificationsBloc>(
            create: (context) => NotificationsBloc()),
        BlocProvider<NotificationsUpdateBloc>(
            create: (context) => NotificationsUpdateBloc()),
        BlocProvider<SupportBloc>(create: (context) => SupportBloc()),
        BlocProvider<SetVoiceDataBloc>(create: (context) => SetVoiceDataBloc()),
      ],
      child: child,
    );
  }
}
