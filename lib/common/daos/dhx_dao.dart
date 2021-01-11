import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'dao.dart';

class DhxApi {
  static final String listCouncils = '/api/dhx-mining/list-councils';
  static final String listStakes = '/api/dhx-mining/list-stakes';
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

class StakeDHX {
  final String amount;
  final String boost;
  final bool closed;
  final String councilId;
  final String councilName;
  final DateTime created;
  final String currency;
  final String dhxMined;
  final String lockMonths;
  final String id;
  final DateTime lockTill;
  final String organizationId;
  StakeDHX({
    this.amount,
    this.boost,
    this.closed,
    this.councilId,
    this.councilName,
    this.created,
    this.currency,
    this.dhxMined,
    this.lockMonths,
    this.id,
    this.lockTill,
    this.organizationId,
  });

  StakeDHX copyWith({
    String amount,
    String boost,
    bool closed,
    String councilId,
    String councilName,
    DateTime created,
    String currency,
    String dhxMined,
    String lockMonths,
    String id,
    DateTime lockTill,
    String organizationId,
  }) {
    return StakeDHX(
      amount: amount ?? this.amount,
      boost: boost ?? this.boost,
      closed: closed ?? this.closed,
      councilId: councilId ?? this.councilId,
      councilName: councilName ?? this.councilName,
      created: created ?? this.created,
      currency: currency ?? this.currency,
      dhxMined: dhxMined ?? this.dhxMined,
      lockMonths: lockMonths ?? this.lockMonths,
      id: id ?? this.id,
      lockTill: lockTill ?? this.lockTill,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  factory StakeDHX.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StakeDHX(
      amount: map['amount'],
      boost: map['boost'],
      closed: map['closed'],
      councilId: map['councilId'],
      councilName: map['councilName'],
      created: DateTime.tryParse(map['created']),
      currency: map['currency'],
      dhxMined: map['dhxMined'],
      lockMonths: map['lockMonths'],
      id: map['id'],
      lockTill: DateTime.tryParse(map['lockTill']),
      organizationId: map['organizationId'],
    );
  }

  factory StakeDHX.fromJson(String source) =>
      StakeDHX.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Stake(amount: $amount, boost: $boost, closed: $closed, councilId: $councilId, councilName: $councilName, created: $created, currency: $currency, dhxMined: $dhxMined, lockMonths: $lockMonths, id: $id, lockTill: $lockTill, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StakeDHX &&
        o.amount == amount &&
        o.boost == boost &&
        o.closed == closed &&
        o.councilId == councilId &&
        o.councilName == councilName &&
        o.created == created &&
        o.currency == currency &&
        o.dhxMined == dhxMined &&
        o.lockMonths == lockMonths &&
        o.id == id &&
        o.lockTill == lockTill &&
        o.organizationId == organizationId;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        boost.hashCode ^
        closed.hashCode ^
        councilId.hashCode ^
        councilName.hashCode ^
        created.hashCode ^
        currency.hashCode ^
        dhxMined.hashCode ^
        lockMonths.hashCode ^
        id.hashCode ^
        lockTill.hashCode ^
        organizationId.hashCode;
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

  Future<List<StakeDHX>> listStakes({
    String chairOrgId = '0',
    String organizationId = '0',
  }) async {
    final res = await get(url: DhxApi.listStakes, data: {
      'chairOrgId': chairOrgId,
      'organizationId': organizationId,
    });
    final list = res['stake'] as List;
    return list
        .map((l) => StakeDHX.fromMap(Map<String, dynamic>.from(l)))
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
