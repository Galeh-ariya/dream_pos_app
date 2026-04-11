import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/units_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_unit_event.dart';
part 'store_unit_state.dart';
part 'store_unit_bloc.freezed.dart';

class StoreUnitBloc extends Bloc<StoreUnitEvent, StoreUnitState> {
  final UnitRepository unitRepository;
  StoreUnitBloc(this.unitRepository) : super(_Initial()) {
    on<_StoreUnit>((event, emit) async {
      emit(_Loading());
      final result = await unitRepository.storeUnit(
        outletId: event.outletId,
        name: event.name,
      );
      result.fold(
        (failure) => emit(_Error(failure)),
        (success) => emit(_Success("Unit created successfully")),
      );
    });
  }
}
