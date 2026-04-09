part of 'del_outlet_bloc.dart';

@freezed
class DelOutletEvent with _$DelOutletEvent {
  const factory DelOutletEvent.started() = _Started;
  const factory DelOutletEvent.delOutlet(String outletId) = _DelOutlet;
}