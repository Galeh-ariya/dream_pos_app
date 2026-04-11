part of 'list_employee_bloc.dart';

@freezed
class ListEmployeeEvent with _$ListEmployeeEvent {
  const factory ListEmployeeEvent.started() = _Started;
  const factory ListEmployeeEvent.fetchEmployees(String outletId) = _FetchEmployees;
}