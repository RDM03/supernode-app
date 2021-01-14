class ExchangeRate {
  final String name;
  final String unit;
  final double value;
  final String type;

  ExchangeRate(this.name, this.unit, this.value, this.type);
  ExchangeRate.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        unit = map['unit'],
        value = map['value'],
        type = map['type'];
}
