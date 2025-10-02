import 'package:market_place_app/bloc/home_data_bloc/homepage_bloc/homepage_event.dart';
import 'package:market_place_app/data/models/home_data_model.dart';
import 'package:market_place_app/utils/exports.dart';

class HomeDataBloc extends Bloc<HomeDataEvent, HomeDataState> {
  final homeRepo = HomeDataRepository();
  HomeDataModel? _homeDataModel;

  HomeDataBloc() : super(HomeDataInitial()) {
    on<FetchHomeDataEvent>((event, emit) async {
      emit(HomeDataLoading());

      try {
        final result = await homeRepo.fetchHomeData();

        print('----->>>> Result: $result');

        if (result == null) {
          emit(HomeDataFailure(error: 'No data received from server.'));
          return;
        }

        // If response is a String (e.g., error message)
        if (result is String) {
          if (result.contains("Unauthenticated")) {
            emit(
                HomeDataFailure(error: "Session expired. Please login again."));
            AppRouter().navigateAndClearStack(event.context, LoginScreen());
          } else {
            emit(HomeDataFailure(error: result));
          }
          return;
        }

        // If response is HomeDataModel
        if (result is HomeDataModel) {
          _homeDataModel = result;

          if (_homeDataModel != null) {
            emit(HomeDataSuccess(homeDataModel: _homeDataModel!));
          } else {
            emit(HomeDataFailure(error: 'Parsed home data is null.'));
          }
        } else {
          emit(HomeDataFailure(error: 'Unexpected response format.'));
        }
      } catch (e, stackTrace) {
        print('Exception caught: $e');
        print('Stack trace: $stackTrace');
        emit(HomeDataFailure(error: 'Something went wrong: ${e.toString()}'));
      }
    });
  }
}
