import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';

class NetworkServerApi {
  static const String list = '/api/network-servers';
}

class NetworkServerDao extends HttpDao {
  NetworkServerDao(HttpClient client) : super(client);

  //remote
  Future<dynamic> list(Map data) {
    return get(url: NetworkServerApi.list, data: data).then((res) => res);
  }
}
