part of 'del_item_category_bloc.dart';

@freezed
class DelItemCategoryState with _$DelItemCategoryState {
  const factory DelItemCategoryState.initial() = _Initial;
  const factory DelItemCategoryState.loading() = _Loading;
  const factory DelItemCategoryState.success(String message) = _Success;
  const factory DelItemCategoryState.error(String message) = _Error;
}
