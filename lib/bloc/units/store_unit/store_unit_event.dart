part of 'store_unit_bloc.dart';

@freezed
class StoreUnitEvent with _$StoreUnitEvent {
  const factory StoreUnitEvent.started() = _Started;
  const factory StoreUnitEvent.storeUnit(String outletId, String name) = _StoreUnit;
}