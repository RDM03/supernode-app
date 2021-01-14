import 'package:supernodeapp/common/repositories/shared/clients/client.dart';

import '../../shared/dao/dao.dart';

class TopupApi {
  static final String history = '/api/top-up/history';
  static final String account = '/api/top-up/account';
}

class TopupDao extends HttpDao {
  TopupDao(HttpClient client) : super(client);

  Future<dynamic> history(Map data) {
    return post(url: TopupApi.history, data: data);
  }

  Future<dynamic> account(Map data) {
    return get(url: TopupApi.account, data: data);
  }
}
