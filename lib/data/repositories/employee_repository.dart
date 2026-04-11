import 'package:dartz/dartz.dart';
import 'package:dream_pos/data/models/request/employee_request_model.dart';
import 'package:dream_pos/data/models/response/employee_response_model.dart';
import 'package:dream_pos/data/repositories/auth_local_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeRepository {
  final supabase = Supabase.instance.client;

  Future<Either<String, String>> makeEmployee(
    EmployeeRequestModel request, String outletId, int jabatanId,
  ) async {
    final data = await AuthLocalRepository().getUserData();
    final email = request.email?.trim();
    final password = request.password?.trim();
    final fullName = request.fullName?.trim();
    final role = 'karyawan';
    final createdBy = data?.id;

    if ((email ?? '').isEmpty ||
        (password ?? '').isEmpty ||
        (fullName ?? '').isEmpty) {
      return const Left('data kosong');
    }

    try {
      await supabase.auth.signUp(
        email: email!,
        password: password!,
        data: {'full_name': fullName, 'role': role, 'created_by': createdBy},
      );

      await supabase.from('profiles').update({'outlet_id': outletId, 'jabatan_id': jabatanId}).eq('email', email);
      return const Right("Employee created successfully");
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<EmployeeResponseModel>>> listEmployees(
    String outletId,
  ) async {
    try {
      final data = await supabase
          .from('profiles')
          .select('''id, outlet_id, role, jabatan_id, full_name, email, created_by''')
          .eq('outlet_id', outletId)
          .eq('role', 'karyawan');

      return Right(data.map((d) => EmployeeResponseModel.fromMap(d)).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }


}
