import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_place_app/data/models/user_profile_model.dart';
import 'package:market_place_app/data/repository/profile_repository.dart';
import 'get_profile_event.dart';
import 'get_profile_state.dart';

class DriverProfileBloc extends Bloc<DriverProfileEvent, GetDriverState> {
  final profileRepo = ProfileRepository();

  DriverProfileBloc() : super(DriverProfileInitial()) {
    on<FetchDriverProfileEvent>((event, emit) async {
      emit(DriverProfileLoading());

      try {
        final profile = await profileRepo.getUserProfile(event.context);

        emit(DriverProfileSuccess(userProfileModel: profile!));
      } catch (e) {
        emit(DriverProfileFailure(error: e.toString()));
      }
    });
  }
}
