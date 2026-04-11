part of 'store_position_bloc.dart';

@freezed
class StorePositionState with _$StorePositionState {
  const factory StorePositionState.initial() = _Initial;
  const factory StorePositionState.loading() = _Loading;
  const factory StorePositionState.success(String message) = _Success;
  const factory StorePositionState.error(String message) = _Error;
}
