// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GatewayItem _$_$_GatewayItemFromJson(Map<String, dynamic> json) {
  return _$_GatewayItem(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    location: json['location'] as Map<String, dynamic>,
    organizationId: json['organizationID'] as String,
    networkServerId: json['networkServerID'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    firstSeenAt: json['firstSeenAt'] as String,
    lastSeenAt: json['lastSeenAt'] as String,
    model: json['model'] as String,
    osversion: json['osversion'] as String,
    health: (json['health'] as num)?.toDouble(),
    miningFuelHealth: (json['miningFuelHealth'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_GatewayItemToJson(_$_GatewayItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'location': instance.location,
      'organizationID': instance.organizationId,
      'networkServerID': instance.networkServerId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'firstSeenAt': instance.firstSeenAt,
      'lastSeenAt': instance.lastSeenAt,
      'model': instance.model,
      'osversion': instance.osversion,
      'health': instance.health,
      'miningFuelHealth': instance.miningFuelHealth,
    };
