import 'demo.dart';
import '../server_info.dart';

class DemoServerInfoDao extends DemoDao implements ServerInfoDao {
  @override
  Future<AppServerVersionResponse> appServerVersion() {
    return Future.value(AppServerVersionResponse("2.0.8-22-demo"));
  }
}
