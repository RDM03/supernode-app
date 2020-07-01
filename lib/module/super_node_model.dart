import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:supernodeapp/common/daos/supernode_dao.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/data/super_nodes_bean.dart';

import 'base/base_model.dart';

class SuperNodeModel extends BaseModel<SuperNodesBean> {
  static const SUPER_NODES = "assets/others/super_node.json";

  SuperNodeBean _currentNode;

  SuperNodeBean get currentNode => _currentNode;

  set currentNode(SuperNodeBean node) {
    _currentNode = node;
    sp.put(spCurrentNode, _currentNode.toJsonStr());
  }

  Map<String, List<SuperNodeBean>> get superNodesByCountry  {
    var result = Map<String, List<SuperNodeBean>>();
    for (SuperNodeBean item in data?.nodes?.values ?? []) {
      if (result.containsKey(item.region))
        result[item.region].add(item);
      else
        result[item.region] = [item];
    }
    return result;
  }

  @override
  Future<bool> localLoaded() async {
    var newData = data;
    if (data == null) newData = initData();
    if (data?.nodes?.isNotEmpty ?? true) {
      newData.nodes = {};
      Map<String, dynamic> nodes = jsonDecode(await rootBundle.loadString(SUPER_NODES));
      for (var k in nodes.keys) {
        newData.nodes[k] = SuperNodeBean(
          name: k,
          logo: nodes[k]["logo"],
          region: nodes[k]["region"],
          url: nodes[k]["url"],
        );
      }
      await localUpdate(newData);
    }
    if (sp.contains(spCurrentNode)) {
      _currentNode = SuperNodeBean.fromJsonStr(sp.get(spCurrentNode));
    }
    return true;
  }

  @override
  Future<bool> networkLoad() async {
    try {
      var newData = initData();
      var nodes = jsonDecode(await SuperNodeDao().superNodes());
      newData.nodes = {};
      for (var k in nodes.keys) {
        newData.nodes[k] = SuperNodeBean(
          name: k,
          logo: nodes[k]["logo"],
          region: nodes[k]["region"],
          url: nodes[k]["url"],
        );
      }
      return localUpdate(newData);
    } catch(e) {}
    return true;
  }

  String get spCurrentNode => "CURRENT_NODE";

  @override
  String get spPiece => "ENTITY";

  @override
  String get spKey => "SUPER_NODE";

  @override
  SuperNodesBean initData() {
    return SuperNodesBean();
  }
}
