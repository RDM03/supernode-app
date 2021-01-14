import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';

import 'server_info.model.dart';
export 'server_info.model.dart';

class ServerInfoApi {
  static final String appServerVersion = '/api/server-info/appserver-version';
}

class ServerInfoDao extends HttpDao {
  ServerInfoDao(HttpClient client) : super(client);

  Future<AppServerVersionResponse> appServerVersion() {
    return get(url: ServerInfoApi.appServerVersion)
        .then((res) => AppServerVersionResponse.fromMap(res));
  }
}
