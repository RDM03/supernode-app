import 'package:supernodeapp/common/daos/demo/demo_dao.dart';
import 'package:supernodeapp/common/daos/server_info.dart';

class DemoServerInfoDao extends DemoDao implements ServerInfoDao {
  @override
  Future<AppServerVersionResponse> appServerVersion() {
    return Future.value(AppServerVersionResponse("2.0.8-22-demo"));
  }
}
