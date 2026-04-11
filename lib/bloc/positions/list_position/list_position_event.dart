part of 'list_position_bloc.dart';

@freezed
class ListPositionEvent with _$ListPositionEvent {
  const factory ListPositionEvent.started() = _Started;
  const factory ListPositionEvent.fetchPositions(String outletId) = _FetchPositions;
}