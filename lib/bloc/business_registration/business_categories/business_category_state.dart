part of 'business_category_cubit.dart';

@immutable
sealed class BusinessCategoryState {}
final class BusinessCategoryInitial extends BusinessCategoryState {}
final class BusinessCategoryLoading extends BusinessCategoryState {}
final class BusinessCategoryLoaded extends BusinessCategoryState {
  final MerchantCategoryModel categoryData;
  BusinessCategoryLoaded({required this.categoryData});
}
final class BusinessCategoryFailed extends BusinessCategoryState {}
final class BusinessCategoryInternetError extends BusinessCategoryState {}



/// business sub category

@immutable
sealed class BusinessSubCategoryState {}
final class BusinessSubCategoryInitial extends BusinessSubCategoryState {}
final class BusinessSubCategoryLoading extends BusinessSubCategoryState {}

final class BusinessSubCategoryLoaded extends BusinessSubCategoryState {
  final MerchantSubCategoryModel subCategoryData;

  BusinessSubCategoryLoaded({required this.subCategoryData});
}

final class BusinessSubCategoryFailed extends BusinessSubCategoryState {}


final class BusinessSubCategoryInternetError extends BusinessSubCategoryState {}
