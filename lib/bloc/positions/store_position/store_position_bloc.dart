import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/position_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_position_event.dart';
part 'store_position_state.dart';
part 'store_position_bloc.freezed.dart';

class StorePositionBloc extends Bloc<StorePositionEvent, StorePositionState> {
  final PositionRepository positionRepository;
  StorePositionBloc(this.positionRepository) : super(_Initial()) {
    on<_StorePosition>((event, emit) async {
      emit(_Loading());
      final result = await positionRepository.storePosition(
        outletId: event.outletId,
        name: event.name,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
