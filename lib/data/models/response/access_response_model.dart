import 'dart:convert';

class AccessResponseModel {
    final String? id;
    final int? jabatanId;
    final String? kategoriMenu;
    final String? namaAkses;
    final String? valueAkses;
    final String? createdBy;

    AccessResponseModel({
        this.id,
        this.jabatanId,
        this.kategoriMenu,
        this.namaAkses,
        this.valueAkses,
        this.createdBy,
    });

    AccessResponseModel copyWith({
        String? id,
        int? jabatanId,
        String? kategoriMenu,
        String? namaAkses,
        String? valueAkses,
        String? createdBy,
    }) => 
        AccessResponseModel(
            id: id ?? this.id,
            jabatanId: jabatanId ?? this.jabatanId,
            kategoriMenu: kategoriMenu ?? this.kategoriMenu,
            namaAkses: namaAkses ?? this.namaAkses,
            valueAkses: valueAkses ?? this.valueAkses,
            createdBy: createdBy ?? this.createdBy,
        );

    factory AccessResponseModel.fromJson(String str) => AccessResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AccessResponseModel.fromMap(Map<String, dynamic> json) => AccessResponseModel(
        id: json["id"],
        jabatanId: json["jabatan_id"],
        kategoriMenu: json["kategori_menu"],
        namaAkses: json["nama_akses"],
        valueAkses: json["value_akses"],
        createdBy: json["created_by"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "jabatan_id": jabatanId,
        "kategori_menu": kategoriMenu,
        "nama_akses": namaAkses,
        "value_akses": valueAkses,
        "created_by": createdBy,
    };
}
