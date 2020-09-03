import 'package:supernodeapp/common/utils/currencies.dart';

import 'dao.dart';

class CoingeckoApi {
  static final String exchangeRates =
      'https://api.coingecko.com/api/v3/exchange_rates';
}

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

class CoingeckoDao extends Dao {
  Future<Map<Currency, ExchangeRate>> exchangeRates() async {
    final data = await get(
      url: CoingeckoApi.exchangeRates,
    );
    Map<String, dynamic> rates = data['rates'];
    Map<Currency, ExchangeRate> res = {};
    for (final r in rates.entries) {
      final currency = Currency.values.firstWhere(
        (e) => e.shortName == r.key,
        orElse: () => null,
      );
      if (currency == null) {
        print('${r.key} not found');
      }
      res[currency] = ExchangeRate.fromMap(r.value);
    }
    return res;
  }
}
