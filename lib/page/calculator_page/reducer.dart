import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/calculator_page/action.dart';
import 'state.dart';

Reducer<CalculatorState> buildReducer() {
  return asReducer(
    <Object, Reducer<CalculatorState>>{
      CalculatorAction.setMxcPrice: _mxcPrice,
      CalculatorAction.setRates: _rates,
      CalculatorAction.setSelectedCurrencies: _setSelectedCurrencies,
    },
  );
}

CalculatorState _mxcPrice(CalculatorState state, Action action) {
  String price = action.payload;

  final CalculatorState newState = state.clone();

  return newState..mxcPrice = price;
}

CalculatorState _rates(CalculatorState state, Action action) {
  Map<Currency, ExchangeRate> rates = action.payload;

  final CalculatorState newState = state.clone();

  return newState..rates = rates;
}

CalculatorState _setSelectedCurrencies(CalculatorState state, Action action) {
  final CalculatorState newState = state.clone();

  return newState..selectedCurrencies = action.payload;
}
