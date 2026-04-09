import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/request/outlet_request_model.dart';
import 'package:dream_pos/data/repositories/outlets_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'store_outlet_event.dart';
part 'store_outlet_state.dart';
part 'store_outlet_bloc.freezed.dart';

class StoreOutletBloc extends Bloc<StoreOutletEvent, StoreOutletState> {
  final OutletsRepository outletsRepository;
  StoreOutletBloc(this.outletsRepository) : super(_Initial()) {
    on<_CreateOutlet>((event, emit) async {
      emit(_Loading());
      final result = await outletsRepository.createOutlet(event.model);
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
