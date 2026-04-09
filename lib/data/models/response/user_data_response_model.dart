import 'dart:convert';

class UserDataModel {
    final String? id;
    final String? fullName;
    final String? role;
    final dynamic jabatanId;
    final String? email;
    final List<Outlet>? outlets;

    UserDataModel({
        this.id,
        this.fullName,
        this.role,
        this.jabatanId,
        this.email,
        this.outlets,
    });

    UserDataModel copyWith({
        String? id,
        String? fullName,
        String? role,
        dynamic jabatanId,
        String? email,
        List<Outlet>? outlets,
    }) => 
        UserDataModel(
            id: id ?? this.id,
            fullName: fullName ?? this.fullName,
            role: role ?? this.role,
            jabatanId: jabatanId ?? this.jabatanId,
            email: email ?? this.email,
            outlets: outlets ?? this.outlets,
        );

    factory UserDataModel.fromJson(String str) => UserDataModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserDataModel.fromMap(Map<String, dynamic> json) => UserDataModel(
        id: json["id"],
        fullName: json["full_name"],
        role: json["role"],
        jabatanId: json["jabatan_id"],
        email: json["email"],
        outlets: json["outlets"] == null ? [] : List<Outlet>.from(json["outlets"]!.map((x) => Outlet.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "full_name": fullName,
        "role": role,
        "jabatan_id": jabatanId,
        "email": email,
        "outlets": outlets == null ? [] : List<dynamic>.from(outlets!.map((x) => x.toMap())),
    };
}

class Outlet {
    final String? id;
    final String? name;
    final String? address;
    final String? ownerId;
    final String? fifoLifo;

    Outlet({
        this.id,
        this.name,
        this.address,
        this.ownerId,
        this.fifoLifo,
    });

    Outlet copyWith({
        String? id,
        String? name,
        String? address,
        String? ownerId,
        String? fifoLifo,
    }) => 
        Outlet(
            id: id ?? this.id,
            name: name ?? this.name,
            address: address ?? this.address,
            ownerId: ownerId ?? this.ownerId,
            fifoLifo: fifoLifo ?? this.fifoLifo,
        );

    factory Outlet.fromJson(String str) => Outlet.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Outlet.fromMap(Map<String, dynamic> json) => Outlet(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        ownerId: json["owner_id"],
        fifoLifo: json["fifo_lifo"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "owner_id": ownerId,
        "fifo_lifo": fifoLifo,
    };
}
