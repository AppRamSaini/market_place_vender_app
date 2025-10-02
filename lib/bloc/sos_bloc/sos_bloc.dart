import 'package:market_place_app/bloc/sos_bloc/sos_event.dart';
import 'package:market_place_app/bloc/sos_bloc/sos_state.dart';
import 'package:market_place_app/data/repository/sos_repository.dart';
import 'package:market_place_app/utils/exports.dart';

class SosBloc extends Bloc<SosEvent, SosState> {
  SosBloc() : super(SosInitial()) {
    on<SubmitSosEvent>(_onSosCreateApi);
    on<FetchSosEvent>(_onSosHistoryApi);
  }
  SosRepository repository = SosRepository();
  Future<void> _onSosCreateApi(
      SubmitSosEvent event, Emitter<SosState> emit) async {
    emit(SosLoading());
    try {
      final response = await repository.createSos(event);
      if (response != null) {
        emit(SosSuccess(successMsg: response['message'].toString()));
      } else {
        emit(InvalidSosResult());
      }
    } catch (e) {
      emit(SosFailure(error: e.toString()));
    }
  }

  /// sos report history api
  Future<void> _onSosHistoryApi(
      FetchSosEvent event, Emitter<SosState> emit) async {
    emit(SosHistoryLoading());
    try {
      final response = await repository.fetchSosHistory(event.type);
      if (response != null) {
        emit(SosHistorySuccess(sosHistoryModel: response));
      } else {
        emit(InvalidSosResult());
      }
    } catch (e) {
      emit(SosFailure(error: e.toString()));
    }
  }
}

class SosCancelBloc extends Bloc<CancelSosEvent, CancelSosState> {
  SosCancelBloc() : super(CancelSosInitial()) {
    on<CancelSosEvent>(_onCancelSosApi);
  }
  SosRepository repository = SosRepository();

  /// sos report history api
  Future<void> _onCancelSosApi(
      CancelSosEvent event, Emitter<CancelSosState> emit) async {
    emit(CancelSosLoading());
    try {
      final response = await repository.cancelSos(event.context, event.uuid);
      if (response != null) {
        emit(CancelSosSuccess(successMsg: response['message'].toString()));
      } else {
        emit(InvalidCancelSosResult());
      }
    } catch (e) {
      emit(CancelSosFailure(error: e.toString()));
    }
  }
}
