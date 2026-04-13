part of 'status_access_bloc.dart';

@freezed
class StatusAccessEvent with _$StatusAccessEvent {
  const factory StatusAccessEvent.started() = _Started;
  const factory StatusAccessEvent.toggleStatus(String id, bool isActive) =
      _ToggleStatus;
}