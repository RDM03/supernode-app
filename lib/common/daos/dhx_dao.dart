import 'package:flutter/foundation.dart';

import 'dao.dart';

class DhxApi {
  static final String listCouncils = '/api/dhx-mining/list-councils';
  static final String createCouncil = '/api/dhx-mining/create-council';
  static final String createStake = '/api/dhx-mining/create-stake';
  static final String lastMining = '/api/dhx-mining/last-mining';
}

class Council {
  final String id;
  final String chairOrgId;
  final String name;

  Council({
    this.id,
    this.chairOrgId,
    this.name,
  });

  factory Council.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Council(
      id: map['id'],
      chairOrgId: map['chairOrgId'],
      name: map['name'],
    );
  }

  Council copyWith({
    String id,
    String chairOrgId,
    String name,
  }) {
    return Council(
      id: id ?? this.id,
      chairOrgId: chairOrgId ?? this.chairOrgId,
      name: name ?? this.name,
    );
  }
}

class CreateCouncilResponse {
  final String councilId;
  final String stakeId;

  CreateCouncilResponse(this.councilId, this.stakeId);
  factory CreateCouncilResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CreateCouncilResponse(
      map['councilId'],
      map['stakeId'],
    );
  }
}

class LastMiningResponse {
  final DateTime date;
  final String dhxAmount;
  final String miningPower;

  LastMiningResponse(this.date, this.dhxAmount, this.miningPower);
  factory LastMiningResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LastMiningResponse(
      DateTime.tryParse(map['date']),
      map['dhxAmount'],
      map['miningPower'],
    );
  }
}

class DhxDao extends Dao {
  Future<List<Council>> listCouncils() async {
    final res = await get(url: DhxApi.listCouncils);
    final list = res['council'] as List;
    return list
        .map((l) => Council.fromMap(Map<String, dynamic>.from(l)))
        .toList();
  }

  Future<CreateCouncilResponse> createCouncil({
    @required String amount,
    @required String boost,
    @required String lockMonths,
    @required String name,
    @required String organizationId,
  }) async {
    final res = await post(url: DhxApi.createCouncil, data: {
      'amount': amount,
      'boost': boost,
      'currency': 'ETH_MXC',
      'lockMonths': lockMonths,
      'name': name,
      'organizationId': organizationId,
    });
    return CreateCouncilResponse.fromMap(res);
  }

  Future<String> createStake({
    @required String amount,
    @required String boost,
    @required String councilId,
    @required String lockMonths,
    @required String organizationId,
  }) async {
    final res = await post(url: DhxApi.createStake, data: {
      'amount': amount,
      'boost': boost,
      'currency': 'ETH_MXC',
      'councilId': councilId,
      'lockMonths': lockMonths,
      'organizationId': organizationId,
    });
    return res == null ? null : res['stakeId'];
  }

  Future<LastMiningResponse> lastMining() async {
    var res = await get(url: DhxApi.lastMining);
    return LastMiningResponse.fromMap(Map<String, dynamic>.from(res));
  }
}
