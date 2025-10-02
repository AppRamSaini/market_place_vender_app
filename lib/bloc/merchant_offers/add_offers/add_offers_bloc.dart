import 'package:market_place_app/bloc/merchant_offers/add_offers/add_offers_event.dart';
import 'package:market_place_app/bloc/merchant_offers/add_offers/add_offers_state.dart';
import 'package:market_place_app/data/repository/offers_repository.dart';
import 'package:market_place_app/utils/exports.dart';

class AddOffersBloc extends Bloc<AddOffersEvent, AddOffersState> {
  OffersRepository offersRepository = OffersRepository();

  AddOffersBloc() : super(AddOffersInitial()) {
    on<SubmitOffersEvent>(_addOffersApi);
  }

  Future _addOffersApi(
      SubmitOffersEvent event, Emitter<AddOffersState> emit) async {
    emit(AddOffersLoading());
    try {
      final submitOffers = await offersRepository.createOffersApi(event);


      if (submitOffers != null && submitOffers.status == true) {
        emit(AddOffersSuccess(offersModel: submitOffers));
      } else {
        emit(AddOffersInvalidResult());
      }
    } catch (e) {
      emit(AddOffersFailure(error: e.toString()));
    }
  }
}
