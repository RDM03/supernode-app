import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/utils/url.dart';

import 'dao.dart';

class WalletApi {
  static const String balance = '/api/wallet/balance';
  static const String history = '/api/wallet/{orgId}/tx-history';
  static const String miningIncome = '/api/wallet/mining_income';
  static const String convertUSD = '/api/wallet/mxc_price';
  static const String miningInfo = '/api/wallet/mining_info';
  static const String miningIncomeGateway = '/api/wallet/mining_income_gw';
  static final String topUpMiningFuel = "/api/wallet/top-up-mining-fuel";
  static final String withdrawMiningFuel = "/api/wallet/withdraw-mining-fuel";
  static final String downlinkPrice = "/api/wallet/{orgId}/downlink_price";
}

class WalletDao extends SupernodeDao {
  static const String amount = 'amount';
  static const String revenue = 'revenue';
  static const String createdAt = 'createdAt';
  static const String txHash = 'txHash';
  static const String txSentTime = 'txSentTime';
  static const String txStatus = 'txStatus';
  static const String denyComment = 'denyComment';
  static const String from = 'from';
  static const String to = 'to';
  static const String txType = 'txType';
  static const String startStakeTime = 'startStakeTime';
  static const String unstakeTime = 'unstakeTime';
  static const String stakeAmount = 'stakeAmount';
  static const String start = 'start';
  static const String end = 'end';

  WalletDao(SupernodeHttpClient client) : super(client);

  //remote
  Future<dynamic> balance(Map data) {
    return get(url: WalletApi.balance, data: data);
  }

  Future<dynamic> history(Map data) {
    return get(url: Api.url(WalletApi.history, data['orgId']), data: data);
  }

  Future<dynamic> miningIncome(Map data) {
    return get(url: WalletApi.miningIncome, data: data);
  }

  Future<dynamic> convertUSD(Map data) {
    return get(url: WalletApi.convertUSD, data: data);
  }

  Future<dynamic> miningInfo(Map data) {
    return get(url: WalletApi.miningInfo, data: data);
  }

  Future<MiningIncomeGatewayResponse> miningIncomeGateway({
    String gatewayMac,
    String orgId,
    DateTime fromDate,
    DateTime tillDate,
  }) {
    return get(url: WalletApi.miningIncomeGateway, data: {
      if (fromDate != null) 'fromDate': fromDate?.toUtc()?.toIso8601String(),
      if (tillDate != null) 'tillDate': tillDate?.toUtc()?.toIso8601String(),
      'orgId': orgId,
      'gatewayMac': gatewayMac,
    }).then((d) => MiningIncomeGatewayResponse.fromMap(d));
  }

  Future<void> topUpMiningFuel({
    String currency,
    String orgId,
    List<GatewayAmountRequest> topUps,
  }) {
    return post(url: WalletApi.topUpMiningFuel, data: {
      'currency': currency,
      'orgId': orgId,
      'topUps': [
        for (final t in topUps)
          {
            'amount': t.amount,
            'gatewayMac': t.gatewayMac,
          }
      ]
    });
  }

  Future<void> withdrawMiningFuel({
    String currency,
    String orgId,
    List<GatewayAmountRequest> withdraws,
  }) {
    return post(url: WalletApi.withdrawMiningFuel, data: {
      'currency': currency,
      'orgId': orgId,
      'withdrawals': [
        for (final t in withdraws)
          {
            'amount': t.amount,
            'gatewayMac': t.gatewayMac,
          }
      ]
    });
  }

  Future<double> downlinkPrice(String orgId) {
    return get(url: Api.url(WalletApi.downlinkPrice, orgId))
        .then((value) => value['downLinkPrice'].toDouble());
  }
}
