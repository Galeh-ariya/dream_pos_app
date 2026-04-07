import 'package:dream_pos/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthLocalRepository {

  Future<void> saveAuthData(AuthResponse data) async {
    final pref = await SharedPreferences.getInstance();
    final authModel = AuthResponseModel.fromSupabase(data);
    await pref.setString('auth_data', authModel.toJson());
  }

}