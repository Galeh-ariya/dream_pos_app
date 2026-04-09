part of 'list_outlet_bloc.dart';

@freezed
class ListOutletState with _$ListOutletState {
  const factory ListOutletState.initial() = _Initial;
  const factory ListOutletState.loading() = _Loading;
  const factory ListOutletState.success(List<OutletResponseModel> outlets) = _Success;
  const factory ListOutletState.error(String message) = _Error;
}
