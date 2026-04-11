part of 'store_employee_bloc.dart';

@freezed
class StoreEmployeeEvent with _$StoreEmployeeEvent {
  const factory StoreEmployeeEvent.started() = _Started;
  const factory StoreEmployeeEvent.storeEmployee(EmployeeRequestModel employee, String outletId, int jabatanId) = _StoreEmployee;
}