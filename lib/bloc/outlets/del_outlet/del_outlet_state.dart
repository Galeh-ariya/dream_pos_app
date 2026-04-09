part of 'del_outlet_bloc.dart';

@freezed
class DelOutletState with _$DelOutletState {
  const factory DelOutletState.initial() = _Initial;
  const factory DelOutletState.loading() = _Loading;
  const factory DelOutletState.success(String message) = _Success;
  const factory DelOutletState.error(String message) = _Error;
}
