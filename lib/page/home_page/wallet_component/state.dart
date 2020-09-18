import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/utils/uuid.dart';

class WalletState extends MutableSource implements Cloneable<WalletState> {
  bool isFirstRequest = true;
  bool loading = true;
  bool loadingHistory = true;
  TabController tabController;
  int tabIndex = 0;
  double tabHeight = 100;
  bool isSetDate1 = false;
  bool isSetDate2 = false;

  int selectedIndexBtn1 = -1;
  int selectedIndexBtn2 = -1;

  String firstTime = '';
  String secondTime = '';

  List<OrganizationsState> organizations = [];

  //amount
  double balance = 0;

  //stake
  double stakedAmount = 0;
  double totalRevenue = 0;

  //withdraw
  double withdrawFee = 0;

  List<dynamic> get _currentList => tabIndex == 0 ? walletList : stakeList;

  List<StakeItemState> stakeList = [];
  List<WalletItemState> walletList = [];

  @override
  Object getItemData(int index) {
    final o = _currentList[index];
    if (o is WalletItemState) {
      o.fee = withdrawFee;
    }
    return o;
  }

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => _currentList?.length ?? 0;

  @override
  void setItemData(int index, Object data) => _currentList[index] = data;

  bool isDemo;

  Map lastSearchData;
  String lastSearchType;

  @override
  WalletState clone() {
    return WalletState()
      ..isFirstRequest = isFirstRequest
      ..loading = loading
      ..loadingHistory = loadingHistory
      ..tabController = tabController
      ..walletList = walletList
      ..stakeList = stakeList
      ..organizations = organizations
      ..tabIndex = tabIndex
      ..tabHeight = tabHeight
      ..isSetDate1 = isSetDate1
      ..isSetDate2 = isSetDate2
      ..selectedIndexBtn1 = selectedIndexBtn1
      ..selectedIndexBtn2 = selectedIndexBtn2
      ..balance = balance
      ..stakedAmount = stakedAmount
      ..totalRevenue = totalRevenue
      ..withdrawFee = withdrawFee
      ..firstTime = firstTime
      ..secondTime = secondTime
      ..isDemo = isDemo
      ..lastSearchData = lastSearchData
      ..lastSearchType = lastSearchType;
  }
}

WalletState initState(Map<String, dynamic> args) {
  return WalletState();
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

abstract class GeneralItemState {
  bool get isExpand;
  GeneralItemState copyWithExtend(bool isExpand);
}

class StakeItemState extends GeneralItemState
    implements Cloneable<StakeItemState> {
  final StakeHistoryEntity historyEntity;
  final String itemType;
  final bool isLast;
  final bool isExpand;
  StakeItemState(this.historyEntity, this.itemType,
      [this.isLast = false, this.isExpand = false]);

  @override
  StakeItemState clone() {
    return copyWith();
  }

  StakeItemState copyWith(
      {bool isExpand,
      StakeHistoryEntity historyEntity,
      String itemType,
      bool isLast}) {
    return StakeItemState(
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

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      WalletDao.amount: amount,
      WalletDao.createdAt: createdAt,
      WalletDao.txHash: txHash,
    };

    return map;
  }
}
