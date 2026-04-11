part of 'list_unit_bloc.dart';

@freezed
class ListUnitEvent with _$ListUnitEvent {
  const factory ListUnitEvent.started() = _Started;
  const factory ListUnitEvent.fetchUnits(String outletId) = _FetchUnits;
}