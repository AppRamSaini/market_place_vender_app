import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_app/bloc/merchant_offers/view_offers_details/view_offers_state.dart';
import 'package:market_place_app/data/repository/offers_repository.dart';
import 'package:market_place_app/utils/custom.dart';
import 'view_offers_event.dart';

class ViewOffersBloc extends Bloc<ViewOffersEvent, ViewOffersState> {
  final repo = OffersRepository();

  ViewOffersBloc() : super(ViewOffersInitial()) {
    on<ViewOffersDetailsEvent>((event, emit) async {
      emit(ViewOffersLoading());
      try {
        final offers = await repo.fetchOffersDetailsApi(event);
        if (offers is String) {
          snackBar(event.context, offers.toString());
        } else {
          emit(ViewOffersSuccess(offersDetailModel: offers));
        }
      } catch (e) {
        emit(ViewOffersFailure(error: e.toString()));
      }
    });
  }
}
