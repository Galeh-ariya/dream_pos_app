import 'dart:convert';

class OutletResponseModel {
    final String? id;
    final String? name;
    final String? address;
    final DateTime? createdAt;
    final dynamic deletedAt;
    final String? ownerId;
    final String? fifoLifo;

    OutletResponseModel({
        this.id,
        this.name,
        this.address,
        this.createdAt,
        this.deletedAt,
        this.ownerId,
        this.fifoLifo,
    });

    OutletResponseModel copyWith({
        String? id,
        String? name,
        String? address,
        DateTime? createdAt,
        dynamic deletedAt,
        String? ownerId,
        String? fifoLifo,
    }) => 
        OutletResponseModel(
            id: id ?? this.id,
            name: name ?? this.name,
            address: address ?? this.address,
            createdAt: createdAt ?? this.createdAt,
            deletedAt: deletedAt ?? this.deletedAt,
            ownerId: ownerId ?? this.ownerId,
            fifoLifo: fifoLifo ?? this.fifoLifo,
        );

    factory OutletResponseModel.fromJson(String str) => OutletResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory OutletResponseModel.fromMap(Map<String, dynamic> json) => OutletResponseModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
        ownerId: json["owner_id"],
        fifoLifo: json["fifo_lifo"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "address": address,
        "created_at": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "owner_id": ownerId,
        "fifo_lifo": fifoLifo,
    };
}
