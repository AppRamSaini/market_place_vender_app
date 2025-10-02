

import 'package:market_place_app/utils/exports.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final profileRepo = ProfileRepository();
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<UpdateProfileSubmitted>(_updateProfile);
  }

  Future _updateProfile(
      UpdateProfileSubmitted event, Emitter<UpdateProfileState> emit) async {
    final data = {
      'name': event.name,
      'email': event.email,
      'address': event.address,
      'driving_license_number': event.licenseNo,
      if (event.imageFile != null) 'profile_picture': event.imageFile!,
    };

    emit(UpdateProfileLoading());
    try {
      final userprofile = await profileRepo.updateProfile(event.context, data);
      if (userprofile != null) {
        emit(UpdateProfileSuccess());
      } else {
        emit(UpdateProfileInvalidResult());
      }
    } catch (e) {
      emit(UpdateProfileFailure(error: e.toString()));
    }
  }
}
