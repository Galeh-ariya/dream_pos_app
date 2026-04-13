import 'dart:convert';

import 'package:dream_pos/data/models/response/access_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccessLocalRepository {
  final supabase = Supabase.instance.client;

  Future<void> saveAccess(int jabatanId) async {
    final pref = await SharedPreferences.getInstance();
    final fetchedData = await supabase
        .from('hak_akses')
        .select('*')
        .eq('jabatan_id', jabatanId);

    if (fetchedData.isNotEmpty) {
      final aksesList = fetchedData
          .map((item) => AccessResponseModel.fromMap(item))
          .toList();

      final encodedList = json.encode(
        aksesList.map((akses) => akses.toMap()).toList(),
      );

      await pref.setString('akses', encodedList);
      return;
    }

    await pref.setString('akses', json.encode(<Map<String, dynamic>>[]));
  }

  Future<void> removeAccess() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove('akses');
  }

  Future<List<AccessResponseModel>?> getAccess() async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString('akses');
    if (data != null) {
      final List<dynamic> decodedList = json.decode(data);
      return decodedList
          .map((item) => AccessResponseModel.fromMap(item))
          .toList();
    } else {
      return null;
    }
  }
}
