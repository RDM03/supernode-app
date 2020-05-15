import 'package:supernodeapp/common/daos/dao.dart';

class DevicesApi {
  static final String list = '/api/devices';
}

class DevicesDao extends Dao{
  //remote
  Future<dynamic> list(Map data){
    return get(
      url: DevicesApi.list,
      data: data
    ).then((res) => res);
  }
}