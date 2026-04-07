import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthRepository authRepository;
  LogoutBloc(this.authRepository) : super(_Initial()) {
    on<_Logout>((event, emit) async {
      emit(_Loading());
      final result = await authRepository.signOut();
      result.fold(
        (error) => emit(_Error(error.toString())),
        (data) => emit(_Success()),
      );
    });
  }
}
