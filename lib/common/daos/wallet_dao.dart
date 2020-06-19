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
  Stream<dynamic> balance(Map data){
    return Stream.fromFuture(get(
      url: WalletApi.balance,
      data: data
    ));
  }

  Stream<dynamic> history(Map data){
    return Stream.fromFuture(get(
      url: Api.url( WalletApi.history, data['orgId'] ),
      data: data
    ));
  }

  Stream<dynamic> miningIncome(Map data){
    return Stream.fromFuture(get(
      url: WalletApi.miningIncome,
      data: data
    ));
  }

  Stream<dynamic> convertUSD(Map data){
    return Stream.fromFuture(get(
      url: WalletApi.convertUSD,
      data: data
    ));
  }
}