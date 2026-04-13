part of 'bulk_access_bloc.dart';

@freezed
class BulkAccessState with _$BulkAccessState {
  const factory BulkAccessState.initial() = _Initial;
  const factory BulkAccessState.loading() = _Loading;
  const factory BulkAccessState.success(String message) = _Success;
  const factory BulkAccessState.error(String message) = _Error;
}
