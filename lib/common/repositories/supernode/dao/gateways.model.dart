class MinerHealthResponse {
  final String id;
  final int ageSeconds;
  final double health;
  final double miningFuel;
  final double miningFuelHealth;
  final double miningFuelMax;
  final double totalMined;
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
      miningFuel: double.tryParse(map['miningFuel']),
      miningFuelHealth: map['miningFuelHealth'],
      miningFuelMax: double.tryParse(map['miningFuelMax']),
      totalMined: double.tryParse(map['totalMined']),
      uptimeHealth: map['uptimeHealth'],
    );
  }
}

class TopUpGatewayRequest {
  final String amount;
  final String gatewayMac;

  TopUpGatewayRequest(this.amount, this.gatewayMac);
}
