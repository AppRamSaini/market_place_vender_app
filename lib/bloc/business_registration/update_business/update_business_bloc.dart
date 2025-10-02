import 'package:market_place_app/bloc/business_registration/update_business/update_business_event.dart';
import 'package:market_place_app/bloc/business_registration/update_business/update_business_state.dart';
import 'package:market_place_app/utils/exports.dart';

class UpdateMerchantBusinessBloc
    extends Bloc<UpdateMerchantRegistrationEvent, UpdateMerchantBusinessState> {
  AuthRepository authRepository = AuthRepository();

  UpdateMerchantBusinessBloc() : super(UpdateMerchantBusinessInitial()) {
    on<UpdateMerchantRegistrationEvent>(_updateMerchantBusinessRepo);
  }

  Future _updateMerchantBusinessRepo(UpdateMerchantRegistrationEvent event,
      Emitter<UpdateMerchantBusinessState> emit) async {
    emit(UpdateMerchantBusinessLoading());
    try {
      final updateMerchant = await authRepository.updateMerchantBusiness(
          context: event.context, merchant: event.merchant);
      if (updateMerchant != null && updateMerchant.status == true) {
        emit(UpdateMerchantBusinessSuccess(
            merchantBusinessModel: updateMerchant));
      } else {
        emit(UpdateMerchantBusinessInvalidResult());
      }
    } catch (e) {
      emit(UpdateMerchantBusinessFailure(error: e.toString()));
    }
  }
}
