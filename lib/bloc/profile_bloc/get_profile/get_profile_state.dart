import 'package:market_place_app/data/models/user_profile_model.dart';

abstract class GetDriverState {}

class DriverProfileInitial extends GetDriverState {}

class DriverProfileLoading extends GetDriverState {}

class DriverProfileSuccess extends GetDriverState {
  final UserProfileModel userProfileModel;
  DriverProfileSuccess({required this.userProfileModel});
}
class DriverProfileFailure extends GetDriverState {
  final String error;
  DriverProfileFailure({required this.error});
}


class DriverProfileInvalidResult extends GetDriverState {}

