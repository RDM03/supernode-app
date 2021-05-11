import 'dart:convert';

import 'package:supernodeapp/common/utils/currencies.dart';

class Council {
  final String id;
  final String chairOrgId;
  final String name;
  final String lastMpower;

  Council({
    this.id,
    this.chairOrgId,
    this.name,
    this.lastMpower
  });

  factory Council.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Council(
      id: map['id'],
      chairOrgId: map['chairOrgId'],
      name: map['name'],
      lastMpower: map['lastMpower'],
    );
  }

  Council copyWith({
    String id,
    String chairOrgId,
    String name,
    double lastMpower,
  }) {
    return Council(
      id: id ?? this.id,
      chairOrgId: chairOrgId ?? this.chairOrgId,
      name: name ?? this.name,
      lastMpower: lastMpower?? this.lastMpower,
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
      currency: Token.mxc.name,
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
  final String yesterdayTotalDHX;
  final String yesterdayTotalMPower;

  LastMiningResponse(this.date, this.yesterdayTotalDHX, this.yesterdayTotalMPower);
  factory LastMiningResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LastMiningResponse(
      DateTime.tryParse(map['date']),
      map['dhxAllocated'], //dhxAllocated is how much DHX was allocated for the supernode's mpower.
      //map['dhxAmount'], //dhxAmount is how much of that DHX was actually distributed among the users, it is limited by the amount of DHX the user has bonded,
      map['miningPower'],
    );
  }
}
