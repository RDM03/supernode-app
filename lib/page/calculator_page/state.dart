import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';

class CalculatorState implements Cloneable<CalculatorState> {
  List<Currency> selectedCurrencies;
  List<TextEditingController> controllers;

  double balance;
  double staking;
  double mining;

  Map<Currency, ExchangeRate> rates;

  /// Price for 1 mxc in usd
  String mxcPrice;

  double get mxcRate =>
      rates == null ? null : rates[Currency.usd].value / double.parse(mxcPrice);

  bool isDemo;

  @override
  CalculatorState clone() {
    return CalculatorState()
      ..balance = balance
      ..staking = staking
      ..mining = mining
      ..selectedCurrencies = selectedCurrencies
      ..rates = rates
      ..mxcPrice = mxcPrice
      ..isDemo = isDemo;
  }
}

CalculatorState initState(Map<String, dynamic> args) {
  final state = CalculatorState();
  state.staking = args['staking'] ?? 0.0;
  state.mining = args['mining'] ?? 0.0;
  state.balance = args['balance'] ?? 0.0;
  state.isDemo = args['isDemo'] ?? false;
  state.selectedCurrencies = StorageManager.selectedCurrencies();
  state.controllers = List.generate(
      state.selectedCurrencies.length, (_) => TextEditingController());
  return state;
}
