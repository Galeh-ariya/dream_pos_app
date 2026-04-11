part of 'del_unit_bloc.dart';

@freezed
class DelUnitState with _$DelUnitState {
  const factory DelUnitState.initial() = _Initial;
  const factory DelUnitState.loading() = _Loading;
  const factory DelUnitState.success(String message) = _Success;
  const factory DelUnitState.error(String message) = _Error;
}
