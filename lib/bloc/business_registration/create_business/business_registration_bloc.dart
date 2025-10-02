import 'package:market_place_app/bloc/business_registration/create_business/business_registration_event.dart';
import 'package:market_place_app/bloc/business_registration/create_business/business_registration_state.dart';
import 'package:market_place_app/utils/exports.dart';

class BusinessRegistrationBloc
    extends Bloc<BusinessRegistrationEvent, BusinessRegistrationState> {
  AuthRepository authRepository = AuthRepository();

  BusinessRegistrationBloc() : super(BusinessRegistrationInitial()) {
    on<MerchantRegistrationEvent>(_businessRegistrationRepo);
  }

  Future _businessRegistrationRepo(MerchantRegistrationEvent event,
      Emitter<BusinessRegistrationState> emit) async {
    emit(BusinessRegistrationLoading());
    try {
      final merchantSignup = await authRepository.merchantRegistration(
          context: event.context, merchant: event.merchant);
      if (merchantSignup != null && merchantSignup.status==true) {
        emit(BusinessRegistrationSuccess(merchantBusinessModel: merchantSignup));
      } else {
        emit(BusinessRegistrationInvalidResult());
      }
    } catch (e) {
      emit(BusinessRegistrationFailure(error: e.toString()));
    }
  }
}
