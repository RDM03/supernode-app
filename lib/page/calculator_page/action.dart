import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

enum CalculatorAction {
  setMxcPrice,
  setRates,
}

class CalculatorActionCreator {
  static Action setMxcPrice(String mxcPrice) {
    return Action(CalculatorAction.setMxcPrice, payload: mxcPrice);
  }

  static Action setRates(Map<Currency, ExchangeRate> rates) {
    return Action(CalculatorAction.setRates, payload: rates);
  }
}
