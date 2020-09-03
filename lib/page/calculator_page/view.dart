import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/wallet/tab_buttons.dart';
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/calculator_page/action.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'state.dart';

Widget buildView(
    CalculatorState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;
  final _ctx = viewService.context;
  return DefaultTabController(
    length: 3,
    child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          FlutterI18n.translate(context, 'calculator'),
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('addCurrencyButton'),
        onPressed: () {
          dispatch(CalculatorActionCreator.list());
        },
        child: Icon(Icons.add),
      ),
      body: pageBody(
        usePadding: false,
        useColumn: true,
        children: [
          Expanded(
            child: tabButtons(
              padding: EdgeInsets.symmetric(horizontal: 20),
              context: _ctx,
              list: [
                FlutterI18n.translate(context, 'balance'),
                FlutterI18n.translate(context, 'staking'),
                FlutterI18n.translate(context, 'mining'),
              ],
              children: [
                GenericCurrencyTab(
                  state.selectedCurrencies,
                  state.balance,
                  mxcRate: state.mxcRate,
                  rates: state.rates,
                ),
                GenericCurrencyTab(
                  state.selectedCurrencies,
                  state.staking,
                  mxcRate: state.mxcRate,
                  rates: state.rates,
                ),
                GenericCurrencyTab(
                  state.selectedCurrencies,
                  state.mining,
                  mxcRate: state.mxcRate,
                  rates: state.rates,
                ),
              ],
              expandContent: true,
            ),
          ),
          smallColumnSpacer(),
        ],
      ),
    ),
  );
}

class GenericCurrencyTab extends StatelessWidget {
  final List<Currency> selectedCurrencies;
  final double mxcValue;
  final double mxcRate;
  final Map<Currency, ExchangeRate> rates;

  GenericCurrencyTab(
    this.selectedCurrencies,
    this.mxcValue, {
    this.rates,
    this.mxcRate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: selectedCurrencies.length + 1,
      itemBuilder: (_, i) {
        if (i == 0)
          return CurrencyCard(
            shortName: Currency.mxc.shortName,
            fullName: FlutterI18n.translate(context, Currency.mxc.shortName),
            iconPath: Currency.mxc.iconPath,
            withUnderline: true,
            amount: mxcValue.toStringAsFixed(2),
          );
        final currency = selectedCurrencies[i - 1];
        final rate = rates == null ? null : mxcRate / rates[currency].value;
        return CurrencyCard(
          shortName: currency.shortName,
          fullName: FlutterI18n.translate(context, currency.shortName),
          amount: rates == null ? '...' : (mxcValue / rate).toStringAsFixed(2),
          amountPerUnit: rates == null ? '...' : rate.toStringAsFixed(7),
          iconPath: currency.iconPath,
        );
      },
    );
  }
}

class MXCCurrencyCard extends StatefulWidget {
  @override
  _MXCCurrencyCardState createState() => _MXCCurrencyCardState();
}

class _MXCCurrencyCardState extends State<MXCCurrencyCard> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CurrencyCard extends StatelessWidget {
  final String shortName;
  final String fullName;
  final String amount;
  final String amountPerUnit;
  final String iconPath;
  final bool withUnderline;

  CurrencyCard({
    this.shortName,
    this.fullName,
    this.amount,
    this.amountPerUnit,
    this.iconPath,
    this.withUnderline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      child: Padding(
        padding: EdgeInsets.all(10).copyWith(top: 5),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(iconPath),
                SizedBox(width: 10),
                Text(shortName.toUpperCase()),
                Spacer(),
                SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      suffix: Padding(
                        child: Text(shortName.toUpperCase()),
                        padding: EdgeInsets.only(left: 2),
                      ),
                      suffixStyle: Theme.of(context).textTheme.subtitle1,
                      isDense: true,
                      border: withUnderline ? null : InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    readOnly: true,
                    controller: TextEditingController(
                      text: amount,
                    ),
                  ),
                  width: 180,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  fullName,
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                if (amountPerUnit != null)
                  Text(
                    '1${shortName.toUpperCase()} = $amountPerUnit MXC',
                    style: Theme.of(context).textTheme.caption,
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
