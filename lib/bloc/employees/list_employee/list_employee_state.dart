part of 'list_employee_bloc.dart';

@freezed
class ListEmployeeState with _$ListEmployeeState {
  const factory ListEmployeeState.initial() = _Initial;
  const factory ListEmployeeState.loading() = _Loading;
  const factory ListEmployeeState.success(List<EmployeeResponseModel> employees) = _Success;
  const factory ListEmployeeState.error(String message) = _Error;
}
