part of 'store_unit_bloc.dart';

@freezed
class StoreUnitState with _$StoreUnitState {
  const factory StoreUnitState.initial() = _Initial;
  const factory StoreUnitState.loading() = _Loading;
  const factory StoreUnitState.success(String message) = _Success;
  const factory StoreUnitState.error(String message) = _Error;
}
