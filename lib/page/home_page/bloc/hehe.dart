// RETHINK.TODO

import 'package:supernodeapp/page/home_page/legacy//gateway_component/item_state.dart';

List<GatewayItemState> parseGateways(dynamic res) {
  List<GatewayItemState> list = [];

  // [0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}
  // 用于匹配版本号 允许范围 0.0.0 -> 99.99.99
  var reg = RegExp(r"[0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}");

  // int allValues = 0;

  List tempList = res['result'] as List;

  if (tempList.length > 0) {
    for (int index = 0; index < tempList.length; index++) {
      RegExp modelReg = new RegExp(r'(?<=(Gateway Model: )).+(?=[\n])');
      RegExpMatch modelRegRes =
          modelReg.firstMatch(tempList[index]['description']);
      if (modelRegRes != null) {
        tempList[index]['model'] = modelRegRes.group(0);
      }

      RegExp versionReg = new RegExp(r'(?<=(Gateway OsVersion: )).+');
      RegExpMatch versionRegRes =
          versionReg.firstMatch(tempList[index]['description']);
      if (versionRegRes != null) {
        tempList[index]['osversion'] = versionRegRes.group(0);
      }

      // allValues += tempList[index]['location']['accuracy'];
      Iterable<Match> matches = reg.allMatches(tempList[index]['description']);
      String description = '';
      for (Match m in matches) {
        description = m.group(0);
      }

      tempList[index]['description'] = description;

      list.add(GatewayItemState.fromMap(tempList[index]));
    }
  }
  return res;
}
