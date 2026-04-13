import 'package:dartz/dartz.dart';
import 'package:dream_pos/data/models/request/access_request_model.dart';
import 'package:dream_pos/data/models/response/access_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccessRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, List<AccessResponseModel>>> fetchAccess(
    String outletId, {
    int? jabatanId,
  }) async {
    try {
      var query = supabase
          .from('hak_akses')
          .select(
            'id, outlet_id, jabatan_id, kategori_menu, nama_akses, value_akses',
          )
          .eq('outlet_id', outletId);

      if (jabatanId != null) {
        query = query.eq('jabatan_id', jabatanId);
      }

      final fetchedData = await query;

      if (fetchedData.isNotEmpty) {
        final aksesList = fetchedData
            .map((item) => AccessResponseModel.fromMap(item))
            .toList();
        return Right(aksesList);
      } else {
        return const Right([]);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> storeAccess(
    List<AccessRequestModel> data,
  ) async {
    try {
      if (data.isEmpty) {
        return const Left('Data hak akses kosong, tidak ada yang disimpan.');
      }

      for (final item in data) {
        if ((item.outletId ?? '').trim().isEmpty) {
          return const Left(
            'outlet_id wajib diisi pada setiap data hak akses.',
          );
        }
        if (item.jabatanId == null) {
          return const Left(
            'jabatan_id wajib diisi pada setiap data hak akses.',
          );
        }
        if ((item.kategoriMenu ?? '').trim().isEmpty) {
          return const Left(
            'kategori_menu wajib diisi pada setiap data hak akses.',
          );
        }
        if ((item.namaAkses ?? '').trim().isEmpty) {
          return const Left(
            'nama_akses wajib diisi pada setiap data hak akses.',
          );
        }
        if (item.valueAkses == null) {
          return const Left(
            'value_akses wajib diisi pada setiap data hak akses.',
          );
        }
      }

      final dataToInsert = AccessRequestModel.toInsertPayload(data);

      await supabase.from('hak_akses').insert(dataToInsert);

      return Right('Hak akses berhasil disimpan (${dataToInsert.length} data)');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> changeStatusAccess(
    String id,
    bool newValue,
  ) async {
    try {
      await supabase
          .from('hak_akses')
          .update({'value_akses': newValue})
          .eq('id', id);
      return const Right('Status hak akses berhasil diubah');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteAccess(String id) async {
    try {
      await supabase.from('hak_akses').delete().eq('id', id);
      return const Right('Hak akses berhasil dihapus');
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> updateAccess(
    String id,
    AccessRequestModel updatedData,
  ) async {
    try {
      final dataToUpdate = updatedData.toMap();
      await supabase.from('hak_akses').update(dataToUpdate).eq('id', id);
      return const Right('Hak akses berhasil diperbarui');
    } catch (e) {
      return Left(e.toString());
    }
  }
}
