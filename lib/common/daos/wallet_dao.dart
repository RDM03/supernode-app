import 'api.dart';
import 'dao.dart';
import 'mock.dart';

class WalletApi {
  static const String balance = '/api/wallet/balance';
  static const String history = '/api/wallet/{orgId}/tx-history';
  static const String miningIncome = '/api/wallet/mining_income';
  static const String convertUSD = '/api/wallet/mxc_price';
}

class WalletDao extends Dao{
  static const String amount = 'amount';
  static const String revenue = 'revenue';
  static const String createdAt = 'createdAt';
  static const String txHash = 'txHash';
  static const String txSentTime = 'txSentTime';
  static const String txStatus = 'txStatus';
  static const String denyComment ='denyComment';
  static const String from = 'from';
  static const String to = 'to';
  static const String txType = 'txType';
  static const String startStakeTime = 'startStakeTime';
  static const String unstakeTime = 'unstakeTime';
  static const String stakeAmount = 'stakeAmount';
  static const String start = 'start';
  static const String end = 'end';

  //remote
  Future<dynamic> balance(Map data){
    return get(
      url: WalletApi.balance,
      data: data
    ).then((res) => res);
  }

  Future<dynamic> history(Map data){
    return get(
      url: Api.url( WalletApi.history, data['orgId'] ),
      data: data
    ).then((res) => !isMock ? res : Mock.wallet['history'] );
  }

  Future<dynamic> miningIncome(Map data){
    return get(
      url: WalletApi.miningIncome,
      data: data
    ).then((res) => res);
  }

  Future<dynamic> convertUSD(Map data){
    return get(
      url: WalletApi.convertUSD,
      data: data
    ).then((res) => res);
  }
}