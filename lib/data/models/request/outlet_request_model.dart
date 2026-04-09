import 'dart:convert';

class OutletRequestModel {
  final String? id;
  final String? name;
  final String? address;
  final String? ownerId;
  final String? fifoLifo;

  OutletRequestModel({
    this.id,
    this.name,
    this.address,
    this.ownerId,
    this.fifoLifo,
  });

  OutletRequestModel copyWith({
    String? id,
    String? name,
    String? address,
    String? ownerId,
    String? fifoLifo,
  }) => OutletRequestModel(
    id: id ?? this.id,
    name: name ?? this.name,
    address: address ?? this.address,
    ownerId: ownerId ?? this.ownerId,
    fifoLifo: fifoLifo ?? this.fifoLifo,
  );

  factory OutletRequestModel.fromJson(String str) =>
      OutletRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OutletRequestModel.fromMap(Map<String, dynamic> json) =>
      OutletRequestModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        ownerId: json["owner_id"],
        fifoLifo: json["fifo_lifo"],
      );

  Map<String, dynamic> toMap() => {
    "name": name,
    "address": address,
    "owner_id": ownerId,
    "fifo_lifo": fifoLifo,
  };
}
