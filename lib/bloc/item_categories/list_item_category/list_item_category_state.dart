part of 'list_item_category_bloc.dart';

@freezed
class ListItemCategoryState with _$ListItemCategoryState {
  const factory ListItemCategoryState.initial() = _Initial;
  const factory ListItemCategoryState.loading() = _Loading;
  const factory ListItemCategoryState.success(List<ItemCategoryResponseModel> categories) = _Success;
  const factory ListItemCategoryState.error(String message) = _Error;
}
