import 'dart:convert';

class PositionResponseModel {
    final int? id;
    final String? outletId;
    final String? namaJabatan;

    PositionResponseModel({
        this.id,
        this.outletId,
        this.namaJabatan,
    });

    PositionResponseModel copyWith({
        int? id,
        String? outletId,
        String? namaJabatan,
    }) => 
        PositionResponseModel(
            id: id ?? this.id,
            outletId: outletId ?? this.outletId,
            namaJabatan: namaJabatan ?? this.namaJabatan,
        );

    factory PositionResponseModel.fromJson(String str) => PositionResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PositionResponseModel.fromMap(Map<String, dynamic> json) => PositionResponseModel(
        id: json["id"],
        outletId: json["outlet_id"],
        namaJabatan: json["nama_jabatan"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "outlet_id": outletId,
        "nama_jabatan": namaJabatan,
    };
}
