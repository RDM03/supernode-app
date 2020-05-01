import 'api.dart';
import 'dao.dart';
import 'mock.dart';

class StakeApi {
 static const String amount = '/api/staking/{orgId}/activestakes';
 static const String stake = '/api/staking/{orgId}/stake';
 static const String unstake = '/api/staking/{orgId}/unstake';
 static const String history = '/api/staking/{orgId}/history';
 static const String activestakes = '/api/staking/{orgId}/activestakes';
}

class StakeDao extends Dao{
  //remote
  Future<dynamic> amount(String orgId){
    return get(
      url: Api.url(StakeApi.amount,orgId),
    ).then((res) => res);
  }

  Future<dynamic> stake(Map data){
    return post(
      url: Api.url(StakeApi.stake,data['orgId']),
      data: data
    ).then((res) => res);
  }

  Future<dynamic> unstake(Map data){
    return post(
      url: Api.url(StakeApi.unstake,data['orgId']),
      data: data
    ).then((res) => res);
  }

  Future<dynamic> history(Map data){
    return get(
      url: Api.url(StakeApi.history,data['orgId']),
      data: data
    ).then((res) => !isMock ? res : Mock.stakeHistory);
  }

  Future<dynamic> activestakes(Map data){
    return get(
      url: Api.url(StakeApi.activestakes,data['orgId']),
    ).then((res) => !isMock ? res : Mock.activestakes);
  }
}