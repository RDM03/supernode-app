import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/utils/uuid.dart';

class Stake {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String amount;
  final bool active;

  Stake({
    this.id,
    this.startTime,
    this.endTime,
    this.amount,
    this.active,
  });

  factory Stake.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Stake(
      id: map['id'],
      startTime: map['startTime'] != null 
        ? DateTime.tryParse(map['startTime'])
        : null,
      endTime: map['endTime'] != null 
        ? DateTime.tryParse(map['endTime'])
        : null,
      amount: map['amount'],
      active: map['active'] ?? false,
    );
  }

  Stake copyWith({
    String id,
    DateTime startTime,
    DateTime endTime,
    String amount,
    bool active,
  }) {
    return Stake(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      amount: amount ?? this.amount,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'amount': amount,
      'active': active,
    };
  }

  @override
  String toString() {
    return 'Stake(id: $id, startTime: $startTime, endTime: $endTime, amount: $amount, active: $active)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Stake &&
      o.id == id &&
      o.startTime == startTime &&
      o.endTime == endTime &&
      o.amount == amount &&
      o.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      amount.hashCode ^
      active.hashCode;
  }
}

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
      stake: map['stake'] == null
        ? null
        : Stake.fromMap(map['stake']),
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
  String toString() => 'StakeHistoryEntity(timestamp: $timestamp, amount: $amount, type: $type)';

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
  int get hashCode => timestamp.hashCode ^ amount.hashCode ^ type.hashCode ^ stake.hashCode;
}

abstract class GeneralItemState {
  bool get isExpand;
  GeneralItemState copyWithExtend(bool isExpand);
}

class StakeItemState extends GeneralItemState implements Cloneable<StakeItemState> {
  final StakeHistoryEntity historyEntity;
  final String itemType;
  final bool isLast;
  final bool isExpand;
  StakeItemState(this.historyEntity, this.itemType, [this.isLast = false, this.isExpand = false]);

  @override
  StakeItemState clone() {
    return copyWith();
  }

  StakeItemState copyWith({
    bool isExpand,
    StakeHistoryEntity historyEntity,
    String itemType,
    bool isLast
  }) {
    return StakeItemState(
      historyEntity ?? this.historyEntity,
      itemType ?? this.itemType,
      isLast ?? this.isLast,
      isExpand ?? this.isExpand,
    );
  }

  StakeItemState copyWithExtend(bool val) => copyWith(isExpand: val);
}

class WalletItemState extends GeneralItemState implements Cloneable<WalletItemState> {

  DateTime timestamp;
  String type;
  Stake stake;


  //topup history
  String id = '';
  double amount = 0;
  //String createdAt = '';
  String txHash = '';

  bool isExpand = false;
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

  WalletItemState();

  WalletItemState copyWithExtend(bool val) => clone()..isExpand = val;

  @override
  WalletItemState clone() {
    return WalletItemState()
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

  WalletItemState.fromMap(Map map) {
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

  Map<String,dynamic> toMap() {
    var map = <String,dynamic>{
      WalletDao.amount: amount,
      WalletDao.createdAt: createdAt,
      WalletDao.txHash: txHash,
    };

    return map;
  }
}

WalletItemState initState(Map<String, dynamic> args) {
  return WalletItemState();
}
