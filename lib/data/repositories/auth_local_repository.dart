import 'dart:convert';
import 'package:dream_pos/data/models/response/user_data_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthLocalRepository {
  final supabase = Supabase.instance.client;

  Future<void> saveUserData(AuthResponse data) async {
    final pref = await SharedPreferences.getInstance();
    final id = data.user!.id;
    // debugPrint('Current User ID: $id');
    final fetchedData = await supabase
        .from('profiles')
        .select('''
            id,
            full_name,
            role,
            jabatan_id,
            email,
            outlets!outlets_owner_id_fkey(id, name, address, owner_id, fifo_lifo)
            ''')
        .eq('id', id);
    if (fetchedData.isNotEmpty) {
      final userModel = UserDataModel.fromJson(jsonEncode(fetchedData[0]));
      await pref.setString('user_data', userModel.toJson());
    }
  }

  Future<void> updateUserData(UserDataModel data) async {
    final pref = await SharedPreferences.getInstance();
    // final userModel = UserDataModel.fromJson(data.toString());
    // debugPrint('Updating User Dataku: ${data.toJson()}');
    await pref.setString('user_data', data.toJson());
  }

  Future<void> removeAuthData() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('user_data');
  }

  Future<UserDataModel?> getUserData() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('user_data');
    if (data != null) {
      return UserDataModel.fromJson(data);
    } else {
      return null;
    }
  }
}
