part of 'update_outlet_bloc.dart';

@freezed
class UpdateOutletState with _$UpdateOutletState {
  const factory UpdateOutletState.initial() = _Initial;
  const factory UpdateOutletState.loading() = _Loading;
  const factory UpdateOutletState.success(String message) = _Success;
  const factory UpdateOutletState.error(String message) = _Error;
}
