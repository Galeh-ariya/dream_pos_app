part of 'bulk_access_bloc.dart';

@freezed
class BulkAccessEvent with _$BulkAccessEvent {
  const factory BulkAccessEvent.started() = _Started;
  const factory BulkAccessEvent.storeBulkAccess(List<AccessRequestModel> data) =
      _StoreBulkAccess;
}
