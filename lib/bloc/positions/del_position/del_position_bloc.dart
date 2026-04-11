import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/position_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'del_position_event.dart';
part 'del_position_state.dart';
part 'del_position_bloc.freezed.dart';

class DelPositionBloc extends Bloc<DelPositionEvent, DelPositionState> {
  final PositionRepository positionRepository;

  DelPositionBloc(this.positionRepository) : super(_Initial()) {
    on<_DelPosition>((event, emit) async {
      emit(_Loading());
      final result = await positionRepository.deletePosition(
        outletId: event.outletId,
        id: event.id,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
