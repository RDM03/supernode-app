import 'package:decimal/decimal.dart';

class MinerHealthResponse {
  final String id;
  final int ageSeconds;
  final double health;
  final Decimal miningFuel;
  final double miningFuelHealth;
  final Decimal miningFuelMax;
  final Decimal totalMined;
  final double uptimeHealth;

  MinerHealthResponse({
    this.id,
    this.ageSeconds,
    this.health,
    this.miningFuel,
    this.miningFuelHealth,
    this.miningFuelMax,
    this.totalMined,
    this.uptimeHealth,
  });

  factory MinerHealthResponse.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return MinerHealthResponse(
      id: map['id'],
      ageSeconds: int.tryParse(map['ageSeconds']),
      health: map['health'],
      miningFuel: Decimal.tryParse(map['miningFuel']),
      miningFuelHealth: map['miningFuelHealth']?.toDouble(),
      miningFuelMax: Decimal.tryParse(map['miningFuelMax']),
      totalMined: Decimal.tryParse(map['totalMined']),
      uptimeHealth: map['uptimeHealth'],
    );
  }
}

class GatewayAmountRequest {
  final String amount;
  final String gatewayMac;

  GatewayAmountRequest(this.amount, this.gatewayMac);
}
