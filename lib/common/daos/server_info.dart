import 'package:supernodeapp/common/daos/dao.dart';

class ServerInfoApi {
  static final String appServerVersion = '/api/server-info/appserver-version';
}

class AppServerVersionResponse {
  final String version;
  AppServerVersionResponse(this.version);
  AppServerVersionResponse.fromMap(Map<String, dynamic> map)
      : version = map['version'];
}

class ServerInfoDao extends Dao {
  Future<AppServerVersionResponse> appServerVersion() {
    return get(url: ServerInfoApi.appServerVersion)
        .then((res) => AppServerVersionResponse.fromMap(res));
  }
}
