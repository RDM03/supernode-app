import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'dao.dart';

class NetworkServerApi {
  static const String list = '/api/network-servers';
}

class NetworkServerDao extends SupernodeDao {
  NetworkServerDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<dynamic> list(Map data) {
    return get(url: NetworkServerApi.list, data: data).then((res) => res);
  }
}
