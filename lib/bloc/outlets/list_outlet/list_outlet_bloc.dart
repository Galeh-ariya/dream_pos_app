import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:dream_pos/data/repositories/outlets_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_outlet_event.dart';
part 'list_outlet_state.dart';
part 'list_outlet_bloc.freezed.dart';

class ListOutletBloc extends Bloc<ListOutletEvent, ListOutletState> {
  final OutletsRepository outletsRepository;
  ListOutletBloc(this.outletsRepository) : super(_Initial()) {
    on<_FetchOutlets>((event, emit) async{
      emit(_Loading());
      final data = await outletsRepository.fetchOutlets();
      data.fold(
        (failure) => emit(_Error(failure)),
        (outlets) => emit(_Success(outlets)),
      );
    });
  }
}
