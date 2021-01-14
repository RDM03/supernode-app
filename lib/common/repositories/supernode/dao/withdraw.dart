import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/dao.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.model.dart';

import 'withdraw.model.dart';
export 'withdraw.model.dart';

class WithdrawApi {
  static final String withdraw = '/api/withdraw/req';
  static final String history = '/api/withdraw/history';
  static final String fee = '/api/withdraw/get-withdraw-fee';
}

class WithdrawDao extends HttpDao {
  WithdrawDao(HttpClient client) : super(client);

  //remote
  Future<dynamic> withdraw(Map data) {
    return post(url: WithdrawApi.withdraw, data: data).then((res) => res);
  }

  Future<List<WithdrawHistoryEntity>> history(Map data) {
    return get(url: WithdrawApi.history, data: data).then(
      (value) => (value['withdrawHistory'] as List)
          .map((e) => WithdrawHistoryEntity.fromMap(e))
          .toList(),
    );
  }

  Future<dynamic> fee() {
    return get(
      url: WithdrawApi.fee,
    ).then((res) => res);
  }
}
