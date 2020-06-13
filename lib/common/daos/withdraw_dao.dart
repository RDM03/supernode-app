import 'package:supernodeapp/common/daos/dao.dart';

import 'mock.dart';

class WithdrawApi {
  static final String withdraw = '/api/withdraw/req';
  static final String history = '/api/withdraw/history';
  static final String fee = '/api/withdraw/get-withdraw-fee';
}

class WithdrawDao extends Dao{
  //remote
  Future<dynamic> withdraw(Map data){
    return post(
      url: WithdrawApi.withdraw,
      data: data
    ).then((res) => res);
  }

  Stream<dynamic> history(Map data){
    return Stream.fromFuture(get(
      url: WithdrawApi.history,
      data: data
    ));
  }

   Future<dynamic> fee(){
    return get(
      url: WithdrawApi.fee,
    ).then((res) => res);
  }
}