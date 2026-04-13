part of 'status_access_bloc.dart';

@freezed
class StatusAccessState with _$StatusAccessState {
  const factory StatusAccessState.initial() = _Initial;
  const factory StatusAccessState.loading() = _Loading;
  const factory StatusAccessState.success(String message) = _Success;
  const factory StatusAccessState.error(String message) = _Error;
}
