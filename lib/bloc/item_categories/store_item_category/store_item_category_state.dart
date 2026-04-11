part of 'store_item_category_bloc.dart';

@freezed
class StoreItemCategoryState with _$StoreItemCategoryState {
  const factory StoreItemCategoryState.initial() = _Initial;
  const factory StoreItemCategoryState.loading() = _Loading;
  const factory StoreItemCategoryState.success(String message) = _Success;
  const factory StoreItemCategoryState.error(String message) = _Error;
}
