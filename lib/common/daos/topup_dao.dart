import 'dao.dart';
import 'mock.dart';

class TopupApi {
  static final String history = '/api/top-up/history';
  static final String account = '/api/top-up/account';
}

class TopupDao extends Dao{
  //remote
  Future<dynamic> history(Map data){
    return get(
      url: TopupApi.history,
      data: data
    ).then((res) => !isMock ? res : Mock.topup['history'] );
  }

  Future<dynamic> account(Map data){
    return get(
      url: TopupApi.account,
      data: data
    ).then((res) => res);
  }
}