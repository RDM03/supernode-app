import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/utils/uuid.dart';

class StakeHistoryEntity {
  final DateTime timestamp;
  final String amount;
  final String type;
  final Stake stake;

  StakeHistoryEntity({
    this.timestamp,
    this.amount,
    this.type,
    this.stake,
  });

  factory StakeHistoryEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StakeHistoryEntity(
      timestamp: DateTime.tryParse(map['timestamp']),
      amount: map['amount'],
      type: map['type'],
      stake: map['stake'] == null ? null : Stake.fromMap(map['stake']),
    );
  }

  StakeHistoryEntity copyWith({
    DateTime timestamp,
    String amount,
    String type,
    Stake stake,
  }) {
    return StakeHistoryEntity(
      timestamp: timestamp ?? this.timestamp,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      stake: stake ?? this.stake,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timestamp': timestamp?.toIso8601String(),
      'amount': amount,
      'type': type,
      'stake': stake?.toMap(),
    };
  }

  @override
  String toString() =>
      'StakeHistoryEntity(timestamp: $timestamp, amount: $amount, type: $type)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StakeHistoryEntity &&
        o.timestamp == timestamp &&
        o.amount == amount &&
        o.type == type &&
        o.stake == stake;
  }

  @override
  int get hashCode =>
      timestamp.hashCode ^ amount.hashCode ^ type.hashCode ^ stake.hashCode;
}

class StakeDHXItemEntity {
  final String amount;
  final String boost;
  final bool closed;
  final String councilId;
  final String councilName;
  final DateTime created;
  final String currency;
  final String dhxMined;
  final String id;
  final DateTime lockTill;
  final String organisationId;

  StakeDHXItemEntity(
    this.amount,
    this.boost,
    this.closed,
    this.councilId,
    this.councilName,
    this.created,
    this.currency,
    this.dhxMined,
    this.id,
    this.lockTill,
    this.organisationId
  );

  factory StakeDHXItemEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return StakeDHXItemEntity(
      map['amount'],
      map['boost'],
      map['closed'],
      map['councilId'],
      map['councilName'],
      DateTime.tryParse(map['created']),
      map['currency'],
      map['dhxMined'],
      map['id'],
      DateTime.tryParse(map['lockTill']),
      map['organisationId']
    );
  }

  StakeDHXItemEntity copyWith({
    String amount,
    String boost,
    String closed,
    String councilId,
    String councilName,
    DateTime created,
    String currency,
    String dhxMined,
    String id,
    DateTime lockTill,
    String organisationId,
  }) {
    return StakeDHXItemEntity(
      amount ?? this.amount,
      boost ?? this.boost,
      closed ?? this.closed,
      councilId ?? this.councilId,
      councilName ?? this.councilName,
      created ?? this.created,
      currency ?? this.currency,
      dhxMined ?? this.dhxMined,
      id ?? this.id,
      lockTill ?? this.lockTill,
      organisationId ?? this.organisationId
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "amount": amount,
      "boost": boost,
      "closed": closed,
      "councilId": councilId,
      "councilName": councilName,
      "created": created?.toIso8601String(),
      "currency": currency,
      "dhxMined": dhxMined,
      "id": id,
      "lockTill": lockTill?.toIso8601String(),
      "organizationId": organisationId,
    };
  }

  @override
  String toString() =>
      'StakeDHXHistoryEntity(created: $created, amount: $amount, council Name: $councilName)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is StakeDHXItemEntity &&
        o.created == created &&
        o.amount == amount &&
        o.organisationId == organisationId &&
        o.lockTill == lockTill;
  }

  @override
  int get hashCode =>
      created.hashCode ^ amount.hashCode ^ organisationId.hashCode ^ lockTill.hashCode;
}

abstract class GeneralItemState {
  bool get isExpand;
  int get index;
  GeneralItemState copyWithExtend(bool isExpand);
}

class StakeItemState extends GeneralItemState
    implements Cloneable<StakeItemState> {
  final StakeHistoryEntity historyEntity;
  final String itemType;
  final bool isLast;
  final bool isExpand;
  final int index;
  StakeItemState(this.index, this.historyEntity, this.itemType,
      [this.isLast = false, this.isExpand = false]);

  @override
  StakeItemState clone() {
    return copyWith();
  }

  StakeItemState copyWith(
      {bool isExpand,
      int index,
      StakeHistoryEntity historyEntity,
      String itemType,
      bool isLast}) {
    return StakeItemState(
      index,
      historyEntity ?? this.historyEntity,
      itemType ?? this.itemType,
      isLast ?? this.isLast,
      isExpand ?? this.isExpand,
    );
  }

  StakeItemState copyWithExtend(bool val) => copyWith(isExpand: val);
}

class WalletItemState extends GeneralItemState
    implements Cloneable<WalletItemState> {
  DateTime timestamp;
  String type;
  Stake stake;

  //topup history
  String id = '';
  double amount = 0;
  //String createdAt = '';
  String txHash = '';

  bool isExpand = false;
  final int index;
  bool isLast = false;

  //withdraw history
  String txSentTime = '';
  String txStatus = '';
  String denyComment = '';
  double fee = 0;

  //wallet history
  String txType = '';
  String fromAddress = '';
  String toAddress = '';

  //stake
  double revenue = 0;
  String startStakeTime = '';
  String unstakeTime = '';

  //unstake
  double stakeAmount = 0;
  String start = '';
  String end = '';

  String createdAt;

  WalletItemState(this.index);

  WalletItemState copyWithExtend(bool val) => clone()..isExpand = val;

  @override
  WalletItemState clone() {
    return WalletItemState(index)
      ..type = type
      ..id = id
      ..amount = amount
      ..revenue = revenue
      ..createdAt = createdAt
      ..txHash = txHash
      ..isExpand = isExpand
      ..isLast = isLast
      ..txSentTime = txSentTime
      ..txStatus = txStatus
      ..denyComment = denyComment
      ..fee = fee
      ..fromAddress = fromAddress
      ..toAddress = toAddress
      ..txType = txType
      ..startStakeTime = startStakeTime
      ..unstakeTime = unstakeTime
      ..stakeAmount = stakeAmount
      ..start = start
      ..end = end
      ..timestamp = timestamp;
  }

  WalletItemState.fromMap(this.index, Map map) {
    id = Uuid().generateV4();
    type = map['type'];
    timestamp = DateTime.parse(map['timestamp']);
    amount = Tools.convertDouble(map[WalletDao.amount]);
    revenue = Tools.convertDouble(map[WalletDao.revenue]);
    createdAt = map[WalletDao.createdAt] as String;
    txHash = map[WalletDao.txHash] as String;
    txSentTime = map[WalletDao.txSentTime] as String;
    txStatus = map[WalletDao.txStatus] as String;
    denyComment = map[WalletDao.denyComment] as String;
    fromAddress = map[WalletDao.from] as String;
    toAddress = map[WalletDao.to] as String;
    txType = map[WalletDao.txType] as String;
    startStakeTime = map[WalletDao.startStakeTime] as String;
    unstakeTime = map[WalletDao.unstakeTime] as String;
    stakeAmount = Tools.convertDouble(map[WalletDao.stakeAmount]);
    start = map[WalletDao.start] as String;
    end = map[WalletDao.end] as String;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      WalletDao.amount: amount,
      WalletDao.createdAt: createdAt,
      WalletDao.txHash: txHash,
    };

    return map;
  }
}

class StakeDHXItemState extends GeneralItemState
    implements Cloneable<StakeDHXItemState> {
  final StakeDHXItemEntity historyEntity;
  bool isLast;
  final bool isExpand;
  final int index;
  StakeDHXItemState(this.index, this.historyEntity, [this.isLast = false, this.isExpand = false]);

  @override
  StakeDHXItemState clone() {
    return copyWith();
  }

  StakeDHXItemState copyWith(
      {bool isExpand,
        int index,
        StakeHistoryEntity historyEntity,
        String itemType,
        bool isLast}) {
    return StakeDHXItemState(
      index,
      historyEntity ?? this.historyEntity,
      isLast ?? this.isLast,
      isExpand ?? this.isExpand,
    );
  }

  StakeDHXItemState copyWithExtend(bool val) => copyWith(isExpand: val);
}

WalletItemState initState(Map<String, dynamic> args) {
  return WalletItemState(0);
}
