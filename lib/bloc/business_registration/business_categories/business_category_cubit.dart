import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:market_place_app/data/models/merchant_category_model.dart';
import 'package:market_place_app/data/models/merchant_sub_category_model.dart';
import 'package:market_place_app/data/repository/auth_repository.dart';
import 'package:meta/meta.dart';
part 'business_category_state.dart';

class BusinessCategoryCubit extends Cubit<BusinessCategoryState> {
  BusinessCategoryCubit() : super(BusinessCategoryInitial());

  AuthRepository repository = AuthRepository();

  fetchBusinessCategory() async {
    emit(BusinessCategoryLoading());
    try {
      var categoryData = await repository.fetchMerchantCategory();

      if (categoryData != null) {
        emit(BusinessCategoryLoaded(categoryData: categoryData));
      } else {
        emit(BusinessCategoryFailed());
      }
    } on SocketException {
      emit(BusinessCategoryInternetError());
    } catch (e) {
      print(e);
      emit(BusinessCategoryFailed());
    }
  }
}

class BusinessSubCategoryCubit extends Cubit<BusinessSubCategoryState> {
  BusinessSubCategoryCubit() : super(BusinessSubCategoryInitial());

  AuthRepository repository = AuthRepository();

  /// fetch Business Sub Category
  fetchBusinessSubCategory(String categoryId) async {
    emit(BusinessSubCategoryLoading());
    try {
      var subcategoryData =
          await repository.fetchMerchantSubCategory(categoryId);

      if (subcategoryData != null) {
        emit(BusinessSubCategoryLoaded(subCategoryData: subcategoryData));
      } else {
        emit(BusinessSubCategoryFailed());
      }
    } on SocketException {
      emit(BusinessSubCategoryInternetError());
    } catch (e) {
      print(e);
      emit(BusinessSubCategoryFailed());
    }
  }
}
