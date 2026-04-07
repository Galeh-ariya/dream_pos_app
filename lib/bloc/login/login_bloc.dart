import 'package:bloc/bloc.dart';
import 'package:dream_pos/data/repositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(_Initial()) {
    on<_Login>((event, emit) async {
      emit(_Loading());
      final result = await authRepository.signIn(event.email, event.password);
      result.fold(
        (error) => emit(_Error(error.toString())),
        (data) => emit(_Success(data)),
      );
    });
  }
}
