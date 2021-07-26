import 'dart:convert';

class Supernode {
  static const demo = Supernode(
      logo: 'https://lora.supernode.matchx.io/branding.png', name: 'Demo');

  final String region;
  final String url;
  final String logo;
  final String darkLogo;
  final String status;
  final String name;

  const Supernode({
    this.region,
    this.url,
    this.logo,
    this.darkLogo,
    this.status,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'region': region,
      'url': url,
      'logo': logo,
      'darkLogo': darkLogo,
      'status': status,
      'name': name,
    };
  }

  factory Supernode.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Supernode(
      region: map['region'],
      url: map['url'],
      logo: map['logo'],
      darkLogo: map['darkLogo'] ?? map['logo'],
      status: map['status'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Supernode.fromJson(String source) =>
      Supernode.fromMap(json.decode(source));
}
