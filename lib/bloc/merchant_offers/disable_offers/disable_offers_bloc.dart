

import 'package:market_place_app/utils/exports.dart';
import 'disable_offers_event.dart';
import 'disable_offers_state.dart';
class DisableOffersBloc extends Bloc<DisableOffersEvent, DisableOffersState> {
  final repo = OffersRepository();

  DisableOffersBloc() : super(DisableOffersInitial()) {
    on<DisableOffersSubmit>((event, emit) async {
      emit(DisableOffersLoading());
      try {
        final offers = await repo.disableOffersApi(event);
        if (offers is String) {
          snackBar(event.context, offers.toString());
        } else {

          emit(DisableOffersSuccess(disableOffersModel: offers));
        }
      } catch (e) {
        emit(DisableOffersFailure(error: e.toString()));
      }
    });
  }
}
