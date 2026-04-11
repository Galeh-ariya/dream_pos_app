part of 'list_item_category_bloc.dart';

@freezed
class ListItemCategoryEvent with _$ListItemCategoryEvent {
  const factory ListItemCategoryEvent.started() = _Started;
  const factory ListItemCategoryEvent.fetchItemCategories(String outletId) = _FetchItemCategories;
}