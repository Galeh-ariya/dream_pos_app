part of 'store_outlet_bloc.dart';

@freezed
class StoreOutletEvent with _$StoreOutletEvent {
  const factory StoreOutletEvent.started() = _Started;
  const factory StoreOutletEvent.createOutlet(OutletRequestModel model) = _CreateOutlet;
}