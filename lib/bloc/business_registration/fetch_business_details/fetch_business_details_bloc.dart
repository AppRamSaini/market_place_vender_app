import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_app/bloc/business_registration/fetch_business_details/fetch_business_details_state.dart';
import 'package:market_place_app/data/repository/auth_repository.dart';
import 'package:market_place_app/utils/custom.dart';
import 'fetch_business_details_event.dart';

class FetchBusinessDetailsBloc extends Bloc<FetchBusinessDetailsEvent, FetchBusinessDetailsState> {
  final repo = AuthRepository();
  FetchBusinessDetailsBloc() : super(FetchBusinessDetailsInitial()) {
    on<FetchBusinessDetailsDetailsEvent>((event, emit) async {
      emit(FetchBusinessDetailsLoading());
      try {
        final businessProfile = await repo.fetchBusinessProfile();
        if (businessProfile is String) {
          snackBar(event.context, businessProfile.toString());
        } else {
          emit(FetchBusinessDetailsSuccess(profileModel: businessProfile));
        }
      } catch (e) {
        emit(FetchBusinessDetailsFailure(error: e.toString()));
      }
    });
  }
}
