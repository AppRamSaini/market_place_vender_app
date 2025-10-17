import 'package:market_place_app/utils/exports.dart';
import 'dashboard_offers_event.dart';

class FetchDashboardOffersBloc
    extends Bloc<FetchDashboardOffersEvent, FetchDashboardOffersState> {
  final repo = OffersRepository();

  FetchDashboardOffersBloc() : super(FetchDashboardOffersInitial()) {
    on<DashboardOffersEvent>((event, emit) async {
      emit(FetchDashboardOffersLoading());

      try {
        final offers = await repo.fetchMerchantDashboard(event.context);
        if (offers is String) {
          snackBar(event.context, offers.toString(), AppColors.redColor);
        } else {
          emit(FetchDashboardOffersSuccess(merchantDashboardModel: offers));
        }
      } catch (e) {
        emit(FetchDashboardOffersFailure(error: e.toString()));
      }
    });
  }
}
