import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/outlets_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'del_outlet_event.dart';
part 'del_outlet_state.dart';
part 'del_outlet_bloc.freezed.dart';

class DelOutletBloc extends Bloc<DelOutletEvent, DelOutletState> {
  final OutletsRepository outletsRepository;
  DelOutletBloc(this.outletsRepository) : super(_Initial()) {
    on<_DelOutlet>((event, emit) async {
      emit(_Loading());
      final result = await outletsRepository.deleteOutlet(event.outletId);
      result.fold(
        (error) => emit(_Error(error)),
        (message) => emit(_Success(message)),
      );
    });
  }
}
