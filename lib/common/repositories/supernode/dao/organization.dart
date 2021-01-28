import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/utils/url.dart';
import 'dao.dart';

class OrganizationApi {
  static const String update = '/api/organizations/{organization.id}';
  static const String list = '/api/organizations';
}

class OrganizationDao extends SupernodeDao {
  OrganizationDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<dynamic> update(Map data) {
    return put(url: Api.url(OrganizationApi.update, data['id']), data: data)
        .then((res) => res);
  }

  Future<dynamic> list(Map data) {
    return get(url: OrganizationApi.list, data: data).then((res) => res);
  }
}
