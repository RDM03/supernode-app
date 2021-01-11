import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/module/base/base_data.dart';

part 'super_nodes_bean.g.dart';

@JsonSerializable()
class SuperNodesBean extends AbstractBaseData<SuperNodesBean> {
  @JsonKey(name: "nodes")
  Map<String, SuperNodeBean> nodes;

  SuperNodesBean({
    this.nodes,
  });

  static SuperNodesBean fromJsonStr(String jsonStr) {
    return SuperNodesBean.fromJson(jsonDecode(jsonStr));
  }

  factory SuperNodesBean.fromJson(Map<String, dynamic> json) =>
      _$SuperNodesBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SuperNodesBeanToJson(this);

  @override
  SuperNodesBean clone() {
    return SuperNodesBean()..nodes = nodes;
  }

  @override
  String toJsonStr() {
    return jsonEncode(toJson());
  }

  @override
  jsonConvert(Map<String, dynamic> json) {}
}
