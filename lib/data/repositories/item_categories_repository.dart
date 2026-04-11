import 'package:dartz/dartz.dart';
import 'package:dream_pos/data/models/response/item_category_response_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ItemCategoriesRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, String>> storeItemCategory({
    required String outletId,
    required String name,
  }) async {
    try {
      await supabase.from('kategori').insert({
        'outlet_id': outletId,
        'nama_kategori': name,
      });
      return const Right("Item category created successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String, List<ItemCategoryResponseModel>>> fetchItemCategories(String outletId) async {
    try {
      final data = await supabase
          .from('kategori')
          .select('''id, outlet_id, nama_kategori''')
          .eq('outlet_id', outletId);
      debugPrint("fetch item category data: $data");
      return Right(data.map((d) => ItemCategoryResponseModel.fromMap(d)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> deleteItemCategory({
    required String outletId,
    required int id,
  }) async {
    debugPrint("ini outlet idnya $outletId");
    debugPrint("ini unit idnya $id");
    try {
      await supabase
          .from('kategori')
          .delete()
          .eq('id', id)
          .eq('outlet_id', outletId);
      return const Right("Item category deleted successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }
}