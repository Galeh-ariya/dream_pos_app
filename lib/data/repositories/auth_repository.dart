import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, AuthResponse>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await supabase
          .from('profiles')
          .select('''
        deleted_at
      ''')
          .eq('email', email)
          .maybeSingle();

      if (result != null && result['deleted_at'] != null) {
        return Left('This account has been deleted.');
      }
    } catch (e) {
      return Left('An error occurred while checking account status.');
    }

    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // debugPrint('Auth Response: ${res.user.toString()}');

      return Right(res);
    } on AuthException catch (e) {
      // debugPrint('AuthException: ${e.message} & ${e.statusCode}');
      return Left(e.message);
    } catch (e) {
      return Left('An unexpected error occurred');
    }
  }

  Future<Either<String, String>> signOut() async {
    try {
      await supabase.auth.signOut();
      return Right('Sign out successful');
    } catch (e) {
      return Left('An unexpected error occurred $e');
    }
  }
}
