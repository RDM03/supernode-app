import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/repositories/supernode/clients/supernode_client.dart';
import 'package:supernodeapp/common/utils/url.dart';

import 'dao.dart';

import 'stake.model.dart';
export 'stake.model.dart';

class StakeApi {
  static const String stake = '/api/staking/{orgId}/stake';
  static const String unstake = '/api/staking/{orgId}/unstake';
  static const String history = '/api/staking/{orgId}/history';
  static const String activestakes = '/api/staking/{orgId}/activestakes';
  static const String revenue = '/api/staking/{orgId}/revenue';
  static const String stakingPercentage = '/api/staking/staking_percentage';
}

class StakeDao extends SupernodeDao {
  StakeDao(SupernodeHttpClient client) : super(client);

  Future<dynamic> stake(Map data) {
    return post(url: Api.url(StakeApi.stake, data['orgId']), data: data)
        .then((res) => res);
  }

  Future<dynamic> unstake(Map data) {
    return post(url: Api.url(StakeApi.unstake, data['orgId']), data: data)
        .then((res) => res);
  }

  Future<List<StakeHistoryEntity>> history({
    @required String orgId,
    String currency,
    DateTime from,
    DateTime till,
  }) {
    return get(url: Api.url(StakeApi.history, orgId), data: {
      'currency': currency,
      'from': from?.toUtc()?.toIso8601String(),
      'till': till?.toUtc()?.toIso8601String(),
    }).then(
      (value) => (value['stakingHist'] as List)
          .map((e) => StakeHistoryEntity.fromMap(e))
          .toList(),
    );
  }

  Future<dynamic> activestakes(Map data) {
    return get(
      url: Api.url(StakeApi.activestakes, data['orgId']),
    ).then((res) => res);
  }

  Future<dynamic> revenue(Map data) {
    return get(url: Api.url(StakeApi.revenue, data['orgId']), data: data);
  }

  Future<dynamic> stakingPercentage() {
    return get(url: StakeApi.stakingPercentage);
  }
}
