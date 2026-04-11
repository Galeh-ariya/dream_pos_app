part of 'store_item_category_bloc.dart';

@freezed
class StoreItemCategoryEvent with _$StoreItemCategoryEvent {
  const factory StoreItemCategoryEvent.started() = _Started;
  const factory StoreItemCategoryEvent.storeItemCategory(
    String outletId,
    String name,
  ) = _StoreItemCategory;
}