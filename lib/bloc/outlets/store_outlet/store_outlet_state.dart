part of 'store_outlet_bloc.dart';

@freezed
class StoreOutletState with _$StoreOutletState {
  const factory StoreOutletState.initial() = _Initial;
  const factory StoreOutletState.loading() = _Loading;
  const factory StoreOutletState.success(String message) = _Success;
  const factory StoreOutletState.error(String message) = _Error;
}
