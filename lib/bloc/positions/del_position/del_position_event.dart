part of 'del_position_bloc.dart';

@freezed
class DelPositionEvent with _$DelPositionEvent {
  const factory DelPositionEvent.started() = _Started;
  const factory DelPositionEvent.delPosition(String outletId, int id) = _DelPosition;
}