import 'dart:convert';

import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';

import 'supernode.model.dart';
export 'supernode.model.dart';

class SupernodeGithubApi {
  static final String superNodes =
      "https://raw.githubusercontent.com/mxc-foundation/supernode-list/master/supernode.json";
}

class SuperNodeGithubDao extends HttpDao {
  SuperNodeGithubDao(HttpClient client) : super(client);

  Future<Map<String, Supernode>> superNodes() {
    return get(url: SupernodeGithubApi.superNodes).then(
      (v) => Map<String, dynamic>.from(jsonDecode(v)).map(
        (key, value) => MapEntry(
          key,
          Supernode.fromMap({
            ...value,
            'name': key,
          }),
        ),
      ),
    );
  }
}
