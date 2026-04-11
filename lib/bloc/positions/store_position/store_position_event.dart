part of 'store_position_bloc.dart';

@freezed
class StorePositionEvent with _$StorePositionEvent {
  const factory StorePositionEvent.started() = _Started;
  const factory StorePositionEvent.storePosition(String outletId, String name) = _StorePosition;
}