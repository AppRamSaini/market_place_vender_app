import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_app/data/models/user_profile_model.dart';
import 'package:market_place_app/data/repository/offers_repository.dart';
import 'package:market_place_app/data/repository/profile_repository.dart';
import 'package:market_place_app/utils/custom.dart';
import 'fetch_offers_event.dart';
import 'fetch_offers_state.dart';

class FetchOffersBloc extends Bloc<FetchOffersEvent, FetchOffersState> {
  final repo = OffersRepository();

  FetchOffersBloc() : super(FetchOffersInitial()) {
    on<GetOffersEvent>((event, emit) async {
      emit(FetchOffersLoading());

      try {
        final offers = await repo.fetchOffersListApi();
        if (offers is String) {
          snackBar(event.context, offers.toString());
        } else {
          emit(FetchOffersSuccess(fetchOffersListModel: offers));
        }
      } catch (e) {
        emit(FetchOffersFailure(error: e.toString()));
      }
    });
  }
}
