import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/withdraw.model.dart';

import 'dao.dart';

import 'withdraw.model.dart';
export 'withdraw.model.dart';

class WithdrawApi {
  static final String withdraw = '/api/withdraw/req';
  static final String history = '/api/withdraw/history';
  static final String fee = '/api/withdraw/get-withdraw-fee';
}

class WithdrawDao extends SupernodeDao {
  WithdrawDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<WithdrawReq> withdraw(Map data) {
    return post(url: WithdrawApi.withdraw, data: data).then((res) => WithdrawReq.fromMap(res));
  }

  Future<List<WithdrawHistoryEntity>> history(Map data) {
    return get(url: WithdrawApi.history, data: data).then(
      (value) => (value['withdrawHistory'] as List)
          .map((e) => WithdrawHistoryEntity.fromMap(e))
          .toList(),
    );
  }

  Future<WithdrawFee> fee({String currency = 'ETH_MXC'}) {
    return get(
      url: WithdrawApi.fee,
      data: {'currency': currency},
    ).then((res) => WithdrawFee.fromMap(res));
  }
}
