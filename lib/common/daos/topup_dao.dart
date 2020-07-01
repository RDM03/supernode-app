import 'dao.dart';

class TopupApi {
  static final String history = '/api/top-up/history';
  static final String account = '/api/top-up/account';
}

class TopupDao extends Dao{
  //remote
  Stream<dynamic> history(Map data){
    return Stream.fromFuture(get(
      url: TopupApi.history,
      data: data
    ));
  }

  Stream<dynamic> account(Map data){
    return Stream.fromFuture(get(
      url: TopupApi.account,
      data: data
    ));
  }
}