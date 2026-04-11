import 'dart:convert';

class EmployeeRequestModel {
    final String? email;
    final String? password;
    final String? fullName;
    final String? createdBy;

    EmployeeRequestModel({
        this.email,
        this.password,
        this.fullName,
        this.createdBy,
    });

    EmployeeRequestModel copyWith({
        String? email,
        String? password,
        String? fullName,
        String? role,
        String? createdBy,
    }) => 
        EmployeeRequestModel(
            email: email ?? this.email,
            password: password ?? this.password,
            fullName: fullName ?? this.fullName,
            createdBy: createdBy ?? this.createdBy,
        );

    factory EmployeeRequestModel.fromJson(String str) => EmployeeRequestModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory EmployeeRequestModel.fromMap(Map<String, dynamic> json) => EmployeeRequestModel(
        email: json["email"],
        password: json["password"],
        fullName: json["full_name"],
        createdBy: json["created_by"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
        "password": password,
        "full_name": fullName,
        "created_by": createdBy,
    };
}
