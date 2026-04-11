import 'dart:convert';

class UnitResponseModel {
    final int? id;
    final String? outletId;
    final String? namaSatuan;

    UnitResponseModel({
        this.id,
        this.outletId,
        this.namaSatuan,
    });

    UnitResponseModel copyWith({
        int? id,
        String? outletId,
        String? namaSatuan,
    }) => 
        UnitResponseModel(
            id: id ?? this.id,
            outletId: outletId ?? this.outletId,
            namaSatuan: namaSatuan ?? this.namaSatuan,
        );

    factory UnitResponseModel.fromJson(String str) => UnitResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UnitResponseModel.fromMap(Map<String, dynamic> json) => UnitResponseModel(
        id: json["id"],
        outletId: json["outlet_id"],
        namaSatuan: json["nama_satuan"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "outlet_id": outletId,
        "nama_satuan": namaSatuan,
    };
}
