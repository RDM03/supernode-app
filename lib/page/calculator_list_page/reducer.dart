import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

import 'action.dart';
import 'state.dart';

Reducer<CalculatorListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CalculatorListState>>{
      CalculatorListAction.selectCurrency: _selectCurrency,
      CalculatorListAction.initListener: _initListener,
      CalculatorListAction.setSearchValue: _setSearchValue,
      CalculatorListAction.setSelectedCurrencies: _setSelectedCurrencies,
    },
  );
}

CalculatorListState _selectCurrency(CalculatorListState state, Action action) {
  final CalculatorListState newState = state.clone();
  final currency = action.payload as Currency;
  final selectedCurrencies = state.selectedCurrencies;
  if (selectedCurrencies.contains(currency)) {
    selectedCurrencies.remove(currency);
  } else {
    selectedCurrencies.add(currency);
  }
  return newState..selectedCurrencies = selectedCurrencies;
}

CalculatorListState _initListener(CalculatorListState state, Action action) {
  final CalculatorListState newState = state.clone();
  return newState..searchListener = action.payload;
}

CalculatorListState _setSearchValue(CalculatorListState state, Action action) {
  final CalculatorListState newState = state.clone();
  return newState..searchValue = action.payload;
}

CalculatorListState _setSelectedCurrencies(
    CalculatorListState state, Action action) {
  final CalculatorListState newState = state.clone();
  return newState..selectedCurrencies = action.payload;
}
