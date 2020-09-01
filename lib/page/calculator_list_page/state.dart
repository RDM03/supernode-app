import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';

class CalculatorListState implements Cloneable<CalculatorListState> {
  List<Currency> selectedCurrencies;
  List<Currency> cryptoCurrencies;
  List<Currency> fiatCurrencies;
  TextEditingController searchController = TextEditingController();
  FishListener searchListener;
  String searchValue;

  @override
  CalculatorListState clone() {
    return CalculatorListState()
      ..selectedCurrencies = selectedCurrencies
      ..cryptoCurrencies = cryptoCurrencies
      ..fiatCurrencies = fiatCurrencies
      ..searchController = searchController
      ..searchListener = searchListener
      ..searchValue = searchValue;
  }
}

CalculatorListState initState(Map<String, dynamic> args) {
  final state = CalculatorListState();
  state.cryptoCurrencies =
      Currency.values.where((c) => c.type == CurrencyType.crypto).toList();
  state.fiatCurrencies =
      Currency.values.where((c) => c.type == CurrencyType.fiat).toList();
  state.selectedCurrencies = StorageManager.selectedCurrencies();

  return state;
}
