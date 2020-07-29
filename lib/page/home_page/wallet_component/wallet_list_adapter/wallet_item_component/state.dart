import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/utils/uuid.dart';

class WalletItemState implements Cloneable<WalletItemState> {

  String type = '';

  //topup history
  String id = '';
  double amount = 0;
  String createdAt = '';
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

  DateTime timestamp;

  WalletItemState();

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
