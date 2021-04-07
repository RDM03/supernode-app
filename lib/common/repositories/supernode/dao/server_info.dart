import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'dao.dart';

import 'server_info.model.dart';
export 'server_info.model.dart';

class ServerInfoApi {
  static final String appServerVersion = '/api/server-info/appserver-version';
}

class ServerInfoDao extends SupernodeDao {
  ServerInfoDao(SupernodeHttpClient client) : super(client);

  Future<AppServerVersionResponse> appServerVersion() {
    return get(url: ServerInfoApi.appServerVersion)
        .then((res) => AppServerVersionResponse.fromMap(res));
  }
}
