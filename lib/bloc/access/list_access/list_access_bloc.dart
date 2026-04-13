import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/response/access_response_model.dart';
import 'package:dream_pos/data/repositories/access_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_access_event.dart';
part 'list_access_state.dart';
part 'list_access_bloc.freezed.dart';

class ListAccessBloc extends Bloc<ListAccessEvent, ListAccessState> {
  final AccessRepository accessRepository;

  ListAccessBloc(this.accessRepository) : super(_Initial()) {
    on<_FetchAccess>((event, emit) async {
      emit(const _Loading());
      final result = await accessRepository.fetchAccess(event.outletId);
      result.fold(
        (errorMessage) => emit(_Error(errorMessage)),
        (aksesList) => emit(_Loaded(aksesList)),
      );
    });

    on<_FetchAccessByJabatan>((event, emit) async {
      emit(const _Loading());
      final result = await accessRepository.fetchAccess(
        event.outletId,
        jabatanId: event.jabatanId,
      );
      result.fold(
        (errorMessage) => emit(_Error(errorMessage)),
        (aksesList) => emit(_Loaded(aksesList)),
      );
    });
  }
}
