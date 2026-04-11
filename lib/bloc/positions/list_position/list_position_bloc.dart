import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/response/position_response_model.dart';
import 'package:dream_pos/data/repositories/position_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_position_event.dart';
part 'list_position_state.dart';
part 'list_position_bloc.freezed.dart';

class ListPositionBloc extends Bloc<ListPositionEvent, ListPositionState> {
  final PositionRepository positionRepository;
  ListPositionBloc(this.positionRepository) : super(_Initial()) {
    on<_FetchPositions>((event, emit) async {
      emit(_Loading());
      final result = await positionRepository.listPositions(event.outletId);
      result.fold(
        (error) => emit(_Error(error)),
        (positions) => emit(_Success(positions)),
      );
    });
  }
}
