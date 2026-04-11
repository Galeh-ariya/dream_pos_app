import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/request/employee_request_model.dart';
import 'package:dream_pos/data/repositories/employee_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_employee_event.dart';
part 'store_employee_state.dart';
part 'store_employee_bloc.freezed.dart';

class StoreEmployeeBloc extends Bloc<StoreEmployeeEvent, StoreEmployeeState> {
  final EmployeeRepository employeeRepository;
  StoreEmployeeBloc(this.employeeRepository) : super(_Initial()) {
    on<_StoreEmployee>((event, emit) async {
      emit(_Loading());
      final result = await employeeRepository.makeEmployee(event.employee, event.outletId, event.jabatanId);
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
