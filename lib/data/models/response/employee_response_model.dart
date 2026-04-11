import 'dart:convert';

class EmployeeResponseModel {
  final String? id;
  final String? outletId;
  final String? role;
  final int? jabatanId;
  final String? fullName;
  final String? email;
  final String? createdBy;

  EmployeeResponseModel({
    this.id,
    this.outletId,
    this.role,
    this.jabatanId,
    this.fullName,
    this.email,
    this.createdBy,
  });

  EmployeeResponseModel copyWith({
    String? id,
    String? outletId,
    String? role,
    int? jabatanId,
    String? fullName,
    String? email,
    String? createdBy,
  }) => EmployeeResponseModel(
    id: id ?? this.id,
    outletId: outletId ?? this.outletId,
    role: role ?? this.role,
    jabatanId: jabatanId ?? this.jabatanId,
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    createdBy: createdBy ?? this.createdBy,
  );

  factory EmployeeResponseModel.fromJson(String str) =>
      EmployeeResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeResponseModel.fromMap(Map<String, dynamic> json) =>
      EmployeeResponseModel(
        id: json["id"],
        outletId: json["outlet_id"],
        role: json["role"],
        jabatanId: json["jabatan_id"],
        fullName: json["full_name"],
        email: json["email"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "outlet_id": outletId,
    "role": role,
    "jabatan_id": jabatanId,
    "full_name": fullName,
    "email": email,
    "created_by": createdBy,
  };
}
