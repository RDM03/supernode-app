// RETHINK.TODO - ask pavel
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';

import 'state.dart';

List<GatewayItem> parseGateways(
    dynamic gatewaysResponse, List<MinerHealthResponse> listMinersHealth) {
  List<GatewayItem> list = [];

  // [0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}
  // 用于匹配版本号 允许范围 0.0.0 -> 99.99.99
  var reg = RegExp(r"[0-9]\d{0,1}\.[0-9]\d{0,1}\.[0-9]\d{0,1}");

  // int allValues = 0;

  List tempGatewaysList = gatewaysResponse['result'] as List;

  if (tempGatewaysList.length > 0) {
    for (int index = 0; index < tempGatewaysList.length; index++) {
      RegExp modelReg = new RegExp(r'(?<=(Gateway Model: )).+(?=[\n])');
      RegExpMatch modelRegRes =
          modelReg.firstMatch(tempGatewaysList[index]['description']);
      if (modelRegRes != null) {
        tempGatewaysList[index]['model'] = modelRegRes.group(0);
      }

      RegExp versionReg = new RegExp(r'(?<=(Gateway OsVersion: )).+');
      RegExpMatch versionRegRes =
          versionReg.firstMatch(tempGatewaysList[index]['description']);
      if (versionRegRes != null) {
        tempGatewaysList[index]['osversion'] = versionRegRes.group(0);
      }

      // allValues += tempList[index]['location']['accuracy'];
      Iterable<Match> matches =
          reg.allMatches(tempGatewaysList[index]['description']);
      String description = '';
      for (Match m in matches) {
        description = m.group(0);
      }

      tempGatewaysList[index]['description'] = description;

      // Add mining health info
      if (listMinersHealth != null)
        for (MinerHealthResponse minerHealth in listMinersHealth) {
          if (tempGatewaysList[index]['id'] == minerHealth.id) {
            tempGatewaysList[index]['health'] = minerHealth.health;
            tempGatewaysList[index]['miningFuelHealth'] =
                minerHealth.miningFuelHealth;
            tempGatewaysList[index]['totalMined'] =
                minerHealth.totalMined.toDouble();
            tempGatewaysList[index]['miningFuelMax'] =
                minerHealth.miningFuelMax.toString();
            tempGatewaysList[index]['miningFuel'] =
                minerHealth.miningFuel.toString();
            break;
          }
        }

      list.add(GatewayItem.fromJson(tempGatewaysList[index]));
    }
  }
  return list;
}
