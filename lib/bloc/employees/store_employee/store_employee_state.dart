part of 'store_employee_bloc.dart';

@freezed
class StoreEmployeeState with _$StoreEmployeeState {
  const factory StoreEmployeeState.initial() = _Initial;
  const factory StoreEmployeeState.loading() = _Loading;
  const factory StoreEmployeeState.success(String message) = _Success;
  const factory StoreEmployeeState.error(String message) = _Error;
}
