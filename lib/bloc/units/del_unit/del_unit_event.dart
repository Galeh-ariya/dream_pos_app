part of 'del_unit_bloc.dart';

@freezed
class DelUnitEvent with _$DelUnitEvent {
  const factory DelUnitEvent.started() = _Started;
  const factory DelUnitEvent.delUnit(int id, String outletId) = _DelUnit;
}