import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/response/employee_response_model.dart';
import 'package:dream_pos/data/repositories/employee_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_employee_event.dart';
part 'list_employee_state.dart';
part 'list_employee_bloc.freezed.dart';

class ListEmployeeBloc extends Bloc<ListEmployeeEvent, ListEmployeeState> {
  final EmployeeRepository employeeRepository;

  ListEmployeeBloc(this.employeeRepository) : super(_Initial()) {
    on<_FetchEmployees>((event, emit) async {
      emit(_Loading());
      final result = await employeeRepository.listEmployees(event.outletId);
      result.fold(
        (error) => emit(_Error(error)),
        (employees) => emit(_Success(employees)),
      );
    });
  }
}
