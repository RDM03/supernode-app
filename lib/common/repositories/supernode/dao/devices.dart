import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';

import 'dao.dart';

class DevicesApi {
  static final String list = '/api/devices';
}

class DevicesDao extends SupernodeDao {
  DevicesDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<dynamic> list(Map data) {
    return get(url: DevicesApi.list, data: data).then((res) => res);
  }
}
