import 'package:supernodeapp/common/daos/dao.dart';

class NetworkServerApi {
  static const String list = '/api/network-servers';
}

class NetworkServerDao extends Dao {
  //remote
  Future<dynamic> list(Map data) {
    return get(url: NetworkServerApi.list, data: data).then((res) => res);
  }
}
