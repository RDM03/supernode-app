import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';

enum CalculatorListAction {
  selectCurrency,
  onDone,
  initListener,
  setSearchValue,
  setSelectedCurrencies,
}

class CalculatorListActionCreator {
  static Action selectCurrency(Currency currency) {
    return Action(CalculatorListAction.selectCurrency, payload: currency);
  }

  static Action setSelectedCurrencies(List<Currency> currencies) {
    return Action(CalculatorListAction.selectCurrency, payload: currencies);
  }

  static Action onDone() {
    return Action(CalculatorListAction.onDone);
  }

  static Action initListener(FishListener listener) {
    return Action(CalculatorListAction.initListener, payload: listener);
  }

  static Action setSearchValue(String val) {
    return Action(CalculatorListAction.setSearchValue, payload: val);
  }
}
