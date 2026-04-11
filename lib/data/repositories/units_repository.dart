import 'package:dartz/dartz.dart';
import 'package:dream_pos/data/models/response/unit_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UnitRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, String>> storeUnit({
    required String outletId,
    required String name,
  }) async {
    try {
      await supabase.from('satuan').insert({
        'outlet_id': outletId,
        'nama_satuan': name,
      });
      return const Right("Unit created successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<UnitResponseModel>>> listUnits(
    String outletId,
  ) async {
    try {
      final data = await supabase
          .from('satuan')
          .select('''id, outlet_id, nama_satuan''')
          .eq('outlet_id', outletId);

      return Right(data.map((d) => UnitResponseModel.fromMap(d)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteUnit({
    required String outletId,
    required int id,
  }) async {
    // debugPrint("ini outlet idnya $outletId");
    // debugPrint("ini unit idnya $id");
    try {
      await supabase
          .from('satuan')
          .delete()
          .eq('id', id)
          .eq('outlet_id', outletId);
      return const Right("Unit deleted successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
