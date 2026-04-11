
import 'package:dartz/dartz.dart';
import 'package:dream_pos/data/models/response/position_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PositionRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, String>> storePosition({
    required String outletId,
    required String name,
  }) async {
    try {
      await supabase.from('jabatan').insert({
        'outlet_id': outletId,
        'nama_jabatan': name,
      });
      return const Right("Position created successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<PositionResponseModel>>> listPositions(
    String outletId,
  ) async {
    try {
      final data = await supabase
          .from('jabatan')
          .select('''id, outlet_id, nama_jabatan''')
          .eq('outlet_id', outletId);

      return Right(data.map((d) => PositionResponseModel.fromMap(d)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deletePosition({
    required String outletId,
    required int id,
  }) async {
    try {
      await supabase
          .from('jabatan')
          .delete()
          .eq('id', id)
          .eq('outlet_id', outletId);
      return const Right("Position deleted successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }
}