// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_node_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperNodeBean _$SuperNodeBeanFromJson(Map<String, dynamic> json) {
  return SuperNodeBean(
    name: json['name'] as String,
    region: json['region'] as String,
    url: json['url'] as String,
    logo: json['logo'] as String,
  );
}

Map<String, dynamic> _$SuperNodeBeanToJson(SuperNodeBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'region': instance.region,
      'url': instance.url,
      'logo': instance.logo,
    };
