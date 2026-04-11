part of 'del_item_category_bloc.dart';

@freezed
class DelItemCategoryEvent with _$DelItemCategoryEvent {
  const factory DelItemCategoryEvent.started() = _Started;
  const factory DelItemCategoryEvent.delItemCategory({
    required String outletId,
    required int id,
  }) = _DelItemCategory;
}