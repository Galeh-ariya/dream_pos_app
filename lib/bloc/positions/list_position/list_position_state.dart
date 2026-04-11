part of 'list_position_bloc.dart';

@freezed
class ListPositionState with _$ListPositionState {
  const factory ListPositionState.initial() = _Initial;
  const factory ListPositionState.loading() = _Loading;
  const factory ListPositionState.success(List<PositionResponseModel> positions) = _Success;
  const factory ListPositionState.error(String message) = _Error;
}
