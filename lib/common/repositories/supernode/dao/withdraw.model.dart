import 'dart:convert';

class WithdrawHistoryEntity {
  final String amount;
  final String denyComment;
  final DateTime timestamp;
  final String txHash;
  final String txStatus;
  final String withdrawFee;

  double get amountDouble => double.tryParse(amount);

  WithdrawHistoryEntity({
    this.amount,
    this.denyComment,
    this.timestamp,
    this.txHash,
    this.txStatus,
    this.withdrawFee,
  });

  factory WithdrawHistoryEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return WithdrawHistoryEntity(
      amount: map['amount'],
      denyComment: map['denyComment'],
      timestamp: DateTime.tryParse(map['timestamp']),
      txHash: map['txHash'],
      txStatus: map['txStatus'],
      withdrawFee: map['withdrawFee'],
    );
  }

  factory WithdrawHistoryEntity.fromJson(String source) =>
      WithdrawHistoryEntity.fromMap(json.decode(source));
}
