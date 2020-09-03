import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';

class CalculatorState implements Cloneable<CalculatorState> {
  List<Currency> selectedCurrencies;

  double balance;
  double staking;
  double mining;

  Map<Currency, ExchangeRate> rates;

  /// Price for 1 mxc in usd
  String mxcPrice;

  double get mxcRate =>
      rates == null ? null : rates[Currency.usd].value / double.parse(mxcPrice);

  @override
  CalculatorState clone() {
    return CalculatorState()
      ..balance = balance
      ..staking = staking
      ..mining = mining
      ..selectedCurrencies = selectedCurrencies
      ..rates = rates
      ..mxcPrice = mxcPrice;
  }
}

CalculatorState initState(Map<String, dynamic> args) {
  final state = CalculatorState();
  state.staking = args['staking'];
  state.mining = args['mining'];
  state.balance = args['balance'];
  state.selectedCurrencies = StorageManager.selectedCurrencies();
  return state;
}
