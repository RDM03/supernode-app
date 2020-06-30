// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'super_nodes_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperNodesBean _$SuperNodesBeanFromJson(Map<String, dynamic> json) {
  return SuperNodesBean(
    nodes: (json['nodes'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k,
          e == null ? null : SuperNodeBean.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$SuperNodesBeanToJson(SuperNodesBean instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
    };
