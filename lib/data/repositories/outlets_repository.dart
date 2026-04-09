import 'package:dartz/dartz.dart';
import 'package:dream_pos/data/models/request/outlet_request_model.dart';
import 'package:dream_pos/data/models/response/outlet_reponse_model.dart';
import 'package:dream_pos/data/repositories/auth_local_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OutletsRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, List<OutletResponseModel>>> fetchOutlets() async {
    final userData = await AuthLocalRepository().getUserData();
    final ownerId = userData?.id;
    if (ownerId == null) {
      return Left('User ID is null');
    }
    try {
      final data = await supabase
          .from('outlets')
          .select('*')
          .eq('owner_id', ownerId.toString())
          .isFilter('deleted_at', null);
      final outlets = (data as List)
          .map(
            (json) => OutletResponseModel.fromMap(json as Map<String, dynamic>),
          )
          .toList();
      return Right(outlets);
    } catch (e) {
      return Left('Failed to fetch outlets: $e');
    }
  }

  Future<Either<String, String>> createOutlet(OutletRequestModel model) async {
    final userData = await AuthLocalRepository().getUserData();
    final ownerId = userData?.id;
    if (ownerId == null) {
      return Left('Kamu bukan pria solo id mu salah');
    }

    final mo = model.toMap();
    mo['owner_id'] = ownerId.toString();

    debugPrint(mo.toString());

    try {
      await supabase.from('outlets').insert(mo);
      return Right('Outlet created successfully');
    } catch (e) {
      return Left('Failed to create outlet: $e');
    }
  }

  Future<Either<String, String>> deleteOutlet(String outletId) async {
    try {
      await supabase
          .from('outlets')
          .update({'deleted_at': DateTime.now().toIso8601String()})
          .eq('id', outletId)
          .select();
      // debugPrint('Delete response: $data');
      return Right('Outlet deleted successfully');
    } catch (e) {
      return Left('Failed to delete outlet: $e');
    }
  }

  Future<Either<String, String>> updateOutlet(OutletRequestModel model) async {
    final userData = await AuthLocalRepository().getUserData();
    final ownerId = userData?.id;
    if (ownerId == null) {
      return Left('Kamu bukan pria solo id mu salah');
    }
    final outletId = model.id;
    if (outletId == null) {
      return Left('Outlet ID tidak ditemukan');
    }

    final payload = model.toMap();
    payload['owner_id'] = ownerId.toString();
    // debugPrint('Update outlet payload: ${payload.toString()}');

    try {
      await supabase.from('outlets').update(payload).eq('id', outletId);
      return Right('Outlet updated successfully');
    } catch (e) {
      debugPrint('Error deleting outlet: $e');
      return Left('Failed to update outlet: $e');
    }
  }
}
