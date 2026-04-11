part of 'del_position_bloc.dart';

@freezed
class DelPositionState with _$DelPositionState {
  const factory DelPositionState.initial() = _Initial;
  const factory DelPositionState.loading() = _Loading;
  const factory DelPositionState.success(String message) = _Success;
  const factory DelPositionState.error(String message) = _Error;
}
