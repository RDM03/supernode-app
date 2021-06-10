class TopupEntity {
  final String amount;
  final DateTime timestamp;
  final String txHash;

  double get amountDouble => double.tryParse(amount);

  TopupEntity({
    this.amount,
    this.timestamp,
    this.txHash,
  });

  factory TopupEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TopupEntity(
      amount: map['amount'],
      timestamp: DateTime.tryParse(map['timestamp']),
      txHash: map['txHash'],
    );
  }
}

class TopupAccount {
  final String activeAccount;

  TopupAccount(this.activeAccount);

  factory TopupAccount.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TopupAccount(
      map['activeAccount'],
    );
  }
}
