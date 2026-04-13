import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/access_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'status_access_event.dart';
part 'status_access_state.dart';
part 'status_access_bloc.freezed.dart';

class StatusAccessBloc extends Bloc<StatusAccessEvent, StatusAccessState> {
  final AccessRepository accessRepository;
  StatusAccessBloc(this.accessRepository) : super(_Initial()) {
    on<_ToggleStatus>((event, emit) async {
      emit(const _Loading());
      final result = await accessRepository.changeStatusAccess(event.id, event.isActive);
      result.fold(
        (errorMessage) => emit(_Error(errorMessage)),
        (successMessage) => emit(_Success(successMessage)),
      );
    });
  }
}
