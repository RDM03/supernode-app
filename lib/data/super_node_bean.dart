import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:supernodeapp/module/base/base_data.dart';

part 'super_node_bean.g.dart';

@JsonSerializable()
class SuperNodeBean extends AbstractBaseData<SuperNodeBean> {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "url")
  String url;
  @JsonKey(name: "logo")
  String logo;

  SuperNodeBean({
    this.name,
    this.region,
    this.url,
    this.logo,
  });

  static SuperNodeBean fromJsonStr(String jsonStr) {
    return SuperNodeBean.fromJson(jsonDecode(jsonStr));
  }

  factory SuperNodeBean.fromJson(Map<String, dynamic> json) => _$SuperNodeBeanFromJson(json);

  Map<String, dynamic> toJson() => _$SuperNodeBeanToJson(this);

  @override
  SuperNodeBean clone() {
    return SuperNodeBean()
      ..name
      ..region
      ..url
      ..logo;
  }

  @override
  String toJsonStr() {
    return jsonEncode(toJson());
  }

  @override
  jsonConvert(Map<String, dynamic> json) {}
}
