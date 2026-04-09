part of 'update_outlet_bloc.dart';

@freezed
class UpdateOutletEvent with _$UpdateOutletEvent {
  const factory UpdateOutletEvent.started() = _Started;
  const factory UpdateOutletEvent.updateOutlet(OutletRequestModel outlet) = _UpdateOutlet;
}