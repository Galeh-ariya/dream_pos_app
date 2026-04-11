import 'dart:convert';

class ItemCategoryResponseModel {
  final int? id;
  final String? outletId;
  final String? namaKategori;

  ItemCategoryResponseModel({this.id, this.outletId, this.namaKategori});

  ItemCategoryResponseModel copyWith({
    int? id,
    String? outletId,
    String? namaKategori,
  }) => ItemCategoryResponseModel(
    id: id ?? this.id,
    outletId: outletId ?? this.outletId,
    namaKategori: namaKategori ?? this.namaKategori,
  );

  factory ItemCategoryResponseModel.fromJson(String str) =>
      ItemCategoryResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ItemCategoryResponseModel.fromMap(Map<String, dynamic> json) =>
      ItemCategoryResponseModel(
        id: json["id"],
        outletId: json["outlet_id"],
        namaKategori: json["nama_kategori"],
      );

  Map<String, dynamic> toMap() => {
    "id": id,
    "outlet_id": outletId,
    "nama_kategori": namaKategori,
  };
}
