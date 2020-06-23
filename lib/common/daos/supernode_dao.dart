import 'package:supernodeapp/common/daos/app_dao.dart';

class SuperNodeApi {
  static final String superNodes = "https://datadash.oss-accelerate.aliyuncs.com/super_node.json";
}

class SuperNodeDao extends Dao {
  Future<dynamic> superNodes() {
    return get(url: SuperNodeApi.superNodes);
  }
}
