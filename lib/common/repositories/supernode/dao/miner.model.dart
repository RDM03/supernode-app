class MinerStatsEntity {
  DateTime date;
  double revenue;
  double health;
  double uptime;
  double received;
  double transmitted;

  MinerStatsEntity({
    this.date,
    this.revenue,
    this.health,
    this.uptime,
    this.received,
    this.transmitted,
  });

  factory MinerStatsEntity.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MinerStatsEntity(
      date: DateTime.tryParse(map['date'] ?? map['timestamp']),
      revenue: double.tryParse(map['amount'] ?? '0'),
      health: map['health'] ?? 0,
      uptime: double.tryParse(map['onlineSeconds'] ?? '0'),
      received: double.tryParse(map['rxPacketsReceivedOK'].toString() ?? '0'),
      transmitted: double.tryParse(map['txPacketsEmitted'].toString() ?? '0'),
    );
  }

  @override
  String toString() =>
      'MinerStatsEntity(date: $date, revenue: $revenue, health: $health, uptime: $uptime, received: $received, transmitted: $transmitted))';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MinerStatsEntity &&
        o.date == date &&
        o.revenue == revenue &&
        o.health == health &&
        o.uptime == uptime &&
        o.received == received &&
        o.transmitted == transmitted;
  }

  @override
  int get hashCode =>
      date.hashCode ^
      revenue.hashCode ^
      health.hashCode ^
      uptime.hashCode ^
      received.hashCode ^
      transmitted.hashCode;
}

// class FrameStatsEntity {
//   DateTime date;
//   double received;
//   double transmitted;

//   FrameStatsEntity({
//     this.date,
//     this.received,
//     this.transmitted,
//   });

//   factory FrameStatsEntity.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return FrameStatsEntity(
//       date: DateTime.tryParse(map['timestamp']),
//       received: double.tryParse(map['rxPacketsReceivedOK'].toString()) ?? 0,
//       transmitted: double.tryParse(map['txPacketsEmitted'].toString()) ?? 0,
//     );
//   }

//   @override
//   String toString() =>
//       'MinerStatsEntity(date: $date, received: $received, transmitted: $transmitted)';

//   @override
//   bool operator ==(Object o) {
//     if (identical(this, o)) return true;

//     return o is FrameStatsEntity &&
//         o.date == date &&
//         o.received == received &&
//         o.transmitted == transmitted;
//   }

//   @override
//   int get hashCode =>
//       date.hashCode ^ received.hashCode ^ transmitted.hashCode;
// }
