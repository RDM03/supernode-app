import 'package:supernodeapp/common/repositories/shared/clients/client.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

import 'dao.dart';

import '../../supernode/dao/../../shared/dao/coingecko.model.dart';
export '../../supernode/dao/../../shared/dao/coingecko.model.dart';

class CoingeckoApi {
  static final String exchangeRates =
      'https://api.coingecko.com/api/v3/exchange_rates';
}

class CoingeckoDao extends HttpDao {
  CoingeckoDao(HttpClient client) : super(client);

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
