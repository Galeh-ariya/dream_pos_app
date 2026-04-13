part of 'del_access_bloc.dart';

@freezed
class DelAccessEvent with _$DelAccessEvent {
  const factory DelAccessEvent.started() = _Started;
  const factory DelAccessEvent.deleteAccess(String id) = _DeleteAccess;
}