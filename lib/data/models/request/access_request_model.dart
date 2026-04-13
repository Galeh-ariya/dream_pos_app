import 'dart:convert';

class AccessRequestModel {
  final String? id;
  final String? outletId;
  final int? jabatanId;
  final String? kategoriMenu;
  final String? namaAkses;
  final bool? valueAkses;

  AccessRequestModel({
    this.id,
    this.outletId,
    this.jabatanId,
    this.kategoriMenu,
    this.namaAkses,
    this.valueAkses,
  });

  AccessRequestModel copyWith({
    String? id,
    String? outletId,
    int? jabatanId,
    String? kategoriMenu,
    String? namaAkses,
    bool? valueAkses,
  }) => AccessRequestModel(
    id: id ?? this.id,
    outletId: outletId ?? this.outletId,
    jabatanId: jabatanId ?? this.jabatanId,
    kategoriMenu: kategoriMenu ?? this.kategoriMenu,
    namaAkses: namaAkses ?? this.namaAkses,
    valueAkses: valueAkses ?? this.valueAkses,
  );

  factory AccessRequestModel.fromJson(String str) =>
      AccessRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AccessRequestModel.fromMap(Map<String, dynamic> json) =>
      AccessRequestModel(
        id: json["id"],
        outletId: json["outlet_id"],
        jabatanId: json["jabatan_id"],
        kategoriMenu: json["kategori_menu"],
        namaAkses: json["nama_akses"],
        valueAkses: _parseBool(json["value_akses"]),
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "outlet_id": outletId,
    "jabatan_id": jabatanId,
    "kategori_menu": kategoriMenu,
    "nama_akses": namaAkses,
    "value_akses": valueAkses,
  };

  // Payload insert mengabaikan id karena biasanya dihasilkan otomatis oleh database.
  Map<String, dynamic> toInsertMap() => {
    "outlet_id": outletId,
    "jabatan_id": jabatanId,
    "kategori_menu": kategoriMenu,
    "nama_akses": namaAkses,
    "value_akses": valueAkses,
  };

  static List<Map<String, dynamic>> toInsertPayload(
    List<AccessRequestModel> items,
  ) {
    return items.map((item) => item.toInsertMap()).toList(growable: false);
  }

  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      final normalized = value.trim().toLowerCase();
      if (normalized == 'true' || normalized == '1') return true;
      if (normalized == 'false' || normalized == '0') return false;
    }
    return null;
  }
}
