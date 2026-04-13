import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/request/access_request_model.dart';
import 'package:dream_pos/data/repositories/access_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bulk_access_event.dart';
part 'bulk_access_state.dart';
part 'bulk_access_bloc.freezed.dart';

class BulkAccessBloc extends Bloc<BulkAccessEvent, BulkAccessState> {
  final AccessRepository accessRepository;

  BulkAccessBloc(this.accessRepository) : super(_Initial()) {
    on<_StoreBulkAccess>((event, emit) async {
      emit(const _Loading());
      final result = await accessRepository.storeAccess(event.data);
      result.fold(
        (errorMessage) => emit(_Error(errorMessage)),
        (successMessage) => emit(_Success(successMessage)),
      );
    });
  }
}
