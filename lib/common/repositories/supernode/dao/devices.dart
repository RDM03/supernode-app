import '../../shared/clients/client.dart';
import '../../shared/dao/dao.dart';

class DevicesApi {
  static final String list = '/api/devices';
}

class DevicesDao extends HttpDao {
  DevicesDao(HttpClient client) : super(client);

  //remote
  Future<dynamic> list(Map data) {
    return get(url: DevicesApi.list, data: data).then((res) => res);
  }
}
