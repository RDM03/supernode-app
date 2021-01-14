import 'package:supernodeapp/common/repositories/shared/clients/shared_client.dart';
import 'package:supernodeapp/common/repositories/shared/dao/coingecko.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

class ExchangeRepository {
  final CoingeckoDao _dao = CoingeckoDao(SharedHttpClient());

  Future<Map<Currency, ExchangeRate>> exchangeRates() {
    return _dao.exchangeRates();
  }
}
