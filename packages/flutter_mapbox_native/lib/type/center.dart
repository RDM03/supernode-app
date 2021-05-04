import 'dart:ui' show hashValues;

import 'latlng.dart';

class CenterPosition {
  const CenterPosition({
    required this.target,
    this.zoom = 0.0,
    this.animated = false,
  });

  final LatLng target;

  final double zoom;

  final bool animated;

  dynamic toMap() => <String, dynamic>{
        'target': target.toJson(),
        'zoom': zoom,
        'animated': animated
      };

  static CenterPosition fromMap(Map json) {
    return CenterPosition(
      target: LatLng.fromJson(json['target'])!,
      zoom: json['zoom'],
      animated: json['animated'],
    );
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final CenterPosition typedOther = other;
    return target == typedOther.target &&
        zoom == typedOther.zoom &&
        animated == typedOther.animated;
  }

  @override
  int get hashCode => hashValues(target, zoom, animated);

  @override
  String toString() =>
      'CenterPosition(target: $target, zoom: $zoom, animated: $animated)';
}
