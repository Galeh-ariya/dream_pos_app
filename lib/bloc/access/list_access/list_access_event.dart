part of 'list_access_bloc.dart';

@freezed
class ListAccessEvent with _$ListAccessEvent {
  const factory ListAccessEvent.started() = _Started;
  const factory ListAccessEvent.fetchAccess(String outletId) = _FetchAccess;
  const factory ListAccessEvent.fetchAccessByJabatan(
    String outletId,
    int jabatanId,
  ) = _FetchAccessByJabatan;
}
