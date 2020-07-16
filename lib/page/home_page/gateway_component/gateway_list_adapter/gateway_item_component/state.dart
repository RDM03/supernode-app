import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';

class GatewayItemState implements Cloneable<GatewayItemState> {

  String id = '';
  String name = '';
  String description = '';
  Map location = {};
  String organizationID = '';
  bool discoveryEnabled = true;
  String networkServerID = '';
  String gatewayProfileID = '';
  List boards = [];
  String createdAt = '';
  String updatedAt = '';
  String firstSeenAt = '';
  String lastSeenAt = '';
  String model = '';
  String osversion = '';

  //profile
  // MapController mapCtl = MapController();
  bool isSelectIdType = true;
  
  GatewayItemState();

  @override
  GatewayItemState clone() {
    return GatewayItemState()
      ..id = id
      ..name = name
      ..description = description
      ..location = location
      ..organizationID = organizationID
      ..discoveryEnabled = discoveryEnabled
      ..networkServerID = networkServerID
      ..gatewayProfileID = gatewayProfileID
      ..boards = boards
      ..createdAt = createdAt
      ..updatedAt = updatedAt
      ..firstSeenAt = firstSeenAt
      ..lastSeenAt = lastSeenAt
      // ..mapCtl = mapCtl
      ..isSelectIdType = isSelectIdType;
  }

 GatewayItemState.fromMap(Map map) {
    id = map[GatewaysDao.id] as String;
    name = map[GatewaysDao.name] as String;
    description = map[GatewaysDao.description] as String;
    location = map[GatewaysDao.location] as Map;
    organizationID = map[GatewaysDao.organizationID] as String;
    discoveryEnabled = map[GatewaysDao.discoveryEnabled] == null ? false : map[GatewaysDao.discoveryEnabled] as bool;
    networkServerID = map[GatewaysDao.networkServerID] as String;
    gatewayProfileID = map[GatewaysDao.gatewayProfileID] as String;
    boards = map[GatewaysDao.boards];
    createdAt = map[GatewaysDao.createdAt] as String;
    updatedAt = map[GatewaysDao.updatedAt] as String;
    firstSeenAt = map[GatewaysDao.firstSeenAt] as String;
    lastSeenAt = map[GatewaysDao.lastSeenAt] as String;
    model = map[GatewaysDao.model] as String;
    osversion = map[GatewaysDao.osversion] as String;
  }

  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      GatewaysDao.id: id,
      GatewaysDao.name: name,
      GatewaysDao.description: description,
      GatewaysDao.location: location,
      GatewaysDao.organizationID: organizationID,
      GatewaysDao.discoveryEnabled: discoveryEnabled,
      GatewaysDao.networkServerID: networkServerID,
      GatewaysDao.gatewayProfileID: gatewayProfileID,
      GatewaysDao.boards: boards,
      GatewaysDao.createdAt: createdAt,
      GatewaysDao.updatedAt: updatedAt,
      GatewaysDao.firstSeenAt: firstSeenAt,
      GatewaysDao.lastSeenAt: lastSeenAt,
    };

    return map;
  }
}

GatewayItemState initState(Map<String, dynamic> args) {
  return GatewayItemState();
}