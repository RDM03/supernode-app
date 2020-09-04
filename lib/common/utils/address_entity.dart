import 'dart:convert';

class AddressEntity {
  final String name;
  final String address;
  final String memo;

  AddressEntity({
    this.name,
    this.address,
    this.memo,
  });

  AddressEntity copyWith({
    String name,
    String address,
    String memo,
  }) {
    return AddressEntity(
      name: name ?? this.name,
      address: address ?? this.address,
      memo: memo ?? this.memo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'memo': memo,
    };
  }

  factory AddressEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AddressEntity(
      name: map['name'],
      address: map['address'],
      memo: map['memo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressEntity.fromJson(String source) =>
      AddressEntity.fromMap(json.decode(source));

  @override
  String toString() =>
      'AddressEntity(name: $name, address: $address, memo: $memo)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AddressEntity &&
        o.name == name &&
        o.address == address &&
        o.memo == memo;
  }

  @override
  int get hashCode => name.hashCode ^ address.hashCode ^ memo.hashCode;
}
