part of 'list_outlet_bloc.dart';

@freezed
class ListOutletEvent with _$ListOutletEvent {
  const factory ListOutletEvent.started() = _Started;
  const factory ListOutletEvent.fetchOutlets() = _FetchOutlets;
}