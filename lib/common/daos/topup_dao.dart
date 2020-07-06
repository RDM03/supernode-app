import 'dao.dart';

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
    );
  }

  Future<dynamic> account(Map data){
    return get(
      url: TopupApi.account,
      data: data
    );
  }
}