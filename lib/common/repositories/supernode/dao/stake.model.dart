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

class Stake {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final String amount;
  final bool active;
  final DateTime lockTill;
  final String boost;
  final double revenue;

  int get months {
    if (lockTill == null) return null;
    return (lockTill.difference(startTime).inDays / 30).floor();
  }

  Stake({
    this.id,
    this.startTime,
    this.endTime,
    this.amount,
    this.active,
    this.lockTill,
    this.boost,
    this.revenue,
  });

  factory Stake.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Stake(
      id: map['id'],
      amount: map['amount'],
      active: map['active'] ?? false,
      lockTill:
          map['lockTill'] != null ? DateTime.tryParse(map['lockTill']) : null,
      boost: map['boost'],
      startTime:
          map['startTime'] != null ? DateTime.tryParse(map['startTime']) : null,
      endTime:
          map['endTime'] != null ? DateTime.tryParse(map['endTime']) : null,
      revenue: map['revenue'] != null ? double.tryParse(map['revenue']) : null,
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
