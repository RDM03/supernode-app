import 'package:supernodeapp/common/daos/dao.dart';

import 'api.dart';

class OrganizationApi {
  static const String update = '/api/organizations/{organization.id}';
  static const String list = '/api/organizations';
}

class OrganizationDao extends Dao {
  //remote
  Future<dynamic> update(Map data) {
    return put(url: Api.url(OrganizationApi.update, data['id']), data: data)
        .then((res) => res);
  }

  Future<dynamic> list(Map data) {
    return get(url: OrganizationApi.list, data: data).then((res) => res);
  }
}
