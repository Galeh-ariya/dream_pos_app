import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/access_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'del_access_event.dart';
part 'del_access_state.dart';
part 'del_access_bloc.freezed.dart';

class DelAccessBloc extends Bloc<DelAccessEvent, DelAccessState> {
  final AccessRepository accessRepository;

  DelAccessBloc(this.accessRepository) : super(_Initial()) {
    on<_DeleteAccess>((event, emit) async {
      emit(const _Loading());
      final result = await accessRepository.deleteAccess(event.id);
      result.fold(
        (errorMessage) => emit(_Error(errorMessage)),
        (successMessage) => emit(_Success(successMessage)),
      );
    });
  }
}
