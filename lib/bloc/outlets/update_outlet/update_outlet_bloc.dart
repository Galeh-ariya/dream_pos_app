import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/request/outlet_request_model.dart';
import 'package:dream_pos/data/repositories/outlets_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_outlet_event.dart';
part 'update_outlet_state.dart';
part 'update_outlet_bloc.freezed.dart';

class UpdateOutletBloc extends Bloc<UpdateOutletEvent, UpdateOutletState> {
  final OutletsRepository outletsRepository;
  UpdateOutletBloc(this.outletsRepository) : super(_Initial()) {
    on<_UpdateOutlet>((event, emit) async {
      emit(_Loading());
      final result = await outletsRepository.updateOutlet(event.outlet);
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
