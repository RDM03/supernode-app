import 'package:supernodeapp/common/daos/app_dao.dart';

class SuperNodeApi {
  static final String superNodes =
      "http://raw.githubusercontent.com/mxc-foundation/supernode-list/master/supernode.json";
}

class SuperNodeDao extends Dao {
  Future<dynamic> superNodes() {
    return get(url: SuperNodeApi.superNodes);
  }
}
