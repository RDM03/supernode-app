import 'package:supernodeapp/common/daos/app_dao.dart';

class SuperNodeApi {
  static final String superNodes = "https://datadash.oss-accelerate.aliyuncs.com/supernode.json";
}

class SuperNodeDao extends Dao {
  Future<dynamic> superNodes() {
    return get(url: SuperNodeApi.superNodes);
  }
}
