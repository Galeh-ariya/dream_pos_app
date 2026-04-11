import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/units_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'del_unit_event.dart';
part 'del_unit_state.dart';
part 'del_unit_bloc.freezed.dart';

class DelUnitBloc extends Bloc<DelUnitEvent, DelUnitState> {
  final UnitRepository unitRepository;

  DelUnitBloc(this.unitRepository) : super(_Initial()) {
    on<_DelUnit>((event, emit) async {
      emit(_Loading());
      final result = await unitRepository.deleteUnit(
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
