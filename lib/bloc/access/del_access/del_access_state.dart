part of 'del_access_bloc.dart';

@freezed
class DelAccessState with _$DelAccessState {
  const factory DelAccessState.initial() = _Initial;
  const factory DelAccessState.loading() = _Loading;
  const factory DelAccessState.success(String message) = _Success;
  const factory DelAccessState.error(String message) = _Error;
}
