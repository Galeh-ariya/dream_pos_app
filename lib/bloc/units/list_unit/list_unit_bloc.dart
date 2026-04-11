import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/response/unit_response_model.dart';
import 'package:dream_pos/data/repositories/units_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_unit_event.dart';
part 'list_unit_state.dart';
part 'list_unit_bloc.freezed.dart';

class ListUnitBloc extends Bloc<ListUnitEvent, ListUnitState> {
  final UnitRepository unitRepository;
  
  ListUnitBloc(this.unitRepository) : super(_Initial()) {
    on<_FetchUnits>((event, emit) async {
      emit(const _Loading());
      final result = await unitRepository.listUnits(event.outletId);
      result.fold(
        (error) => emit(_Error(error)),
        (units) => emit(_Success(units)),
      );
    });
  }
}
