part of 'list_access_bloc.dart';

@freezed
class ListAccessState with _$ListAccessState {
  const factory ListAccessState.initial() = _Initial;
  const factory ListAccessState.loading() = _Loading;
  const factory ListAccessState.loaded(List<AccessResponseModel> aksesList) = _Loaded;
  const factory ListAccessState.error(String message) = _Error;
}
