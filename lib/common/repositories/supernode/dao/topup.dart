import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/topup.model.dart';

import '../../shared/dao/dao.dart';

class TopupApi {
  static final String history = '/api/top-up/history';
  static final String account = '/api/top-up/account';
}

class TopupDao extends HttpDao {
  TopupDao(HttpClient client) : super(client);

  Future<List<TopupEntity>> history(Map data) {
    return post(url: TopupApi.history, data: data).then(
      (value) => (value['topupHistory'] as List)
          .map((e) => TopupEntity.fromMap(e))
          .toList(),
    );
  }

  Future<dynamic> account(Map data) {
    return get(url: TopupApi.account, data: data);
  }
}
