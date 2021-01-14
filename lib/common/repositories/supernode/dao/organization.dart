import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';
import 'package:supernodeapp/common/utils/url.dart';

class OrganizationApi {
  static const String update = '/api/organizations/{organization.id}';
  static const String list = '/api/organizations';
}

class OrganizationDao extends HttpDao {
  OrganizationDao(HttpClient client) : super(client);

  //remote
  Future<dynamic> update(Map data) {
    return put(url: Api.url(OrganizationApi.update, data['id']), data: data)
        .then((res) => res);
  }

  Future<dynamic> list(Map data) {
    return get(url: OrganizationApi.list, data: data).then((res) => res);
  }
}
