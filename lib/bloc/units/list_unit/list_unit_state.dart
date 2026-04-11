part of 'list_unit_bloc.dart';

@freezed
class ListUnitState with _$ListUnitState {
  const factory ListUnitState.initial() = _Initial;
  const factory ListUnitState.loading() = _Loading;
  const factory ListUnitState.success(List<UnitResponseModel> units) = _Success;
  const factory ListUnitState.error(String message) = _Error;
}
