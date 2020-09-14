import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/wallet/tab_buttons.dart';
import 'package:supernodeapp/common/daos/coingecko_dao.dart';
import 'package:supernodeapp/common/daos/demo/wallet_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'state.dart';

Widget buildView(
    CalculatorState state, Dispatch dispatch, ViewService viewService) {
  return CalculatorPageView(initState: state);
}

const _loadingStr = '...';

class CalculatorPageView extends StatefulWidget {
  final CalculatorState initState;

  const CalculatorPageView({
    Key key,
    this.initState,
  }) : super(key: key);

  @override
  _CalculatorPageViewState createState() => _CalculatorPageViewState();
}

class _CalculatorPageViewState extends State<CalculatorPageView>
    with SingleTickerProviderStateMixin {
  Map<Currency, ExchangeRate> rates;
  List<Currency> selectedCurrencies;
  Map<int, List<double>> values = {};
  bool isDemo;

  double mxcPrice;

  double mining;
  double staking;
  double balance;

  double get mxcRate => rates == null || mxcPrice == null
      ? null
      : rates[Currency.usd].value / mxcPrice;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    isDemo = widget.initState.isDemo;
    mxcPrice = widget.initState.balance;
    mining = widget.initState.mining;
    staking = widget.initState.staking;
    balance = widget.initState.balance;
    _loadSelectedCurrencies();
    reinitValues();
    Future.wait([
      _refreshMxcPrice(),
      _refreshRates(),
    ]).then((value) => recalcValues());
  }

  WalletDao _buildWalletDao() {
    return isDemo ? DemoWalletDao() : WalletDao();
  }

  void _loadSelectedCurrencies() {
    selectedCurrencies = [
      Currency.mxc,
      ...StorageManager.selectedCurrencies(),
    ];
  }

  Future<void> _refreshMxcPrice() async {
    final walletDao = _buildWalletDao();

    final settingsData = GlobalStore.store.getState().settings;
    final userId = settingsData.userId;
    final orgId = settingsData.selectedOrganizationId;
    Map data = {
      'userId': userId,
      'orgId': orgId,
      'currency': '',
      'mxcPrice': '1'
    };
    final response = await walletDao.convertUSD(data);
    final mxcPriceText = response['mxcPrice'];
    setState(() {
      mxcPrice = double.parse(mxcPriceText);
    });
  }

  Future<void> _refreshRates() async {
    final dao = CoingeckoDao();
    final rates = await dao.exchangeRates();
    setState(() {
      this.rates = rates;
    });
  }

  Future<void> list() async {
    await Navigator.of(context).pushNamed('calculator_list_page');
    _loadSelectedCurrencies();
    reinitValues();
  }

  void reinitValues() {
    setState(() {
      values = {
        0: List.filled(selectedCurrencies.length, null),
        1: List.filled(selectedCurrencies.length, null),
        2: List.filled(selectedCurrencies.length, null),
      };
    });
    recalcValues();
  }

  void recalcValues() {
    _recalcValuesForTab(values[0], balance);
    _recalcValuesForTab(values[1], staking);
    _recalcValuesForTab(values[2], mining);
  }

  void _recalcValuesForTab(List<double> values, double mxcValue, {int except}) {
    for (var i = 0; i < selectedCurrencies.length; i++) {
      //if (i == except) continue;
      final currency = selectedCurrencies[i];
      final rate =
          rates == null ? null : mxcRate / (rates[currency]?.value ?? mxcRate);
      values[i] = rate == null ? null : (mxcValue / rate);
    }
  }

  void onTextChanged(int tabNum, int currencyIndex, String valueText) {
    if (rates == null || mxcRate == null) return;
    final currency = selectedCurrencies[currencyIndex];
    final rate =
        rates == null ? null : mxcRate / (rates[currency]?.value ?? mxcRate);
    final val = double.tryParse(valueText);
    if (val == null) return;
    final mxcValue = rate * val;
    if (tabNum == 0) balance = mxcValue;
    if (tabNum == 1) staking = mxcValue;
    if (tabNum == 2) mining = mxcValue;
    _recalcValuesForTab(values[tabNum], mxcValue, except: currencyIndex);
    setState(() {});
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        onPressed: () => list(),
        child: Icon(Icons.add),
      ),
      body: pageBody(
        usePadding: false,
        useColumn: true,
        children: [
          Expanded(
            child: tabButtons(
              tabController: tabController,
              padding: EdgeInsets.symmetric(horizontal: 20),
              context: context,
              list: [
                FlutterI18n.translate(context, 'balance'),
                FlutterI18n.translate(context, 'staking'),
                FlutterI18n.translate(context, 'mining'),
              ],
              children: [
                GenericCurrencyTab(
                  selectedCurrencies,
                  values[0],
                  mxcRate: mxcRate,
                  rates: rates,
                  onChanged: (s, i) => onTextChanged(0, i, s),
                ),
                GenericCurrencyTab(
                  selectedCurrencies,
                  values[1],
                  mxcRate: mxcRate,
                  rates: rates,
                ),
                GenericCurrencyTab(
                  selectedCurrencies,
                  values[2],
                  mxcRate: mxcRate,
                  rates: rates,
                ),
              ],
              expandContent: true,
            ),
          ),
        ],
      ),
    );
  }
}

class GenericCurrencyTab extends StatelessWidget {
  final List<Currency> selectedCurrencies;
  final List<double> values;
  final Map<Currency, ExchangeRate> rates;
  final double mxcRate;
  final void Function(String, int) onChanged;

  GenericCurrencyTab(
    this.selectedCurrencies,
    this.values, {
    this.rates,
    this.mxcRate,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: selectedCurrencies.length,
      itemBuilder: (_, i) {
        final currency = selectedCurrencies[i];
        final value = values[i];
        final rate = rates == null
            ? null
            : mxcRate / (rates[currency]?.value ?? mxcRate);
        var amountPerUnit = _loadingStr;
        if (rates != null) {
          amountPerUnit = rate.toStringAsFixed(7);
        }
        if (currency == Currency.mxc) {
          amountPerUnit = null;
        }
        return CurrencyCard(
          shortName: currency.shortName,
          onChanged: (s) => onChanged(s, i),
          fullName: FlutterI18n.translate(context, currency.shortName),
          value: value?.toStringAsFixed(2) ?? '...',
          amountPerUnit: amountPerUnit,
          iconPath: currency.iconPath,
        );
      },
    );
  }
}

class CurrencyCard extends StatefulWidget {
  final String shortName;
  final String fullName;
  final String amountPerUnit;
  final String iconPath;
  final FocusNode focusNode;
  final void Function(String) onChanged;
  final String value;

  CurrencyCard({
    this.shortName,
    this.fullName,
    this.amountPerUnit,
    this.iconPath,
    this.focusNode,
    this.onChanged,
    this.value,
  });

  @override
  _CurrencyCardState createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(CurrencyCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != controller.text) {
      final oldController = controller;
      setState(() {
        controller = TextEditingController(text: widget.value);
      });
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        oldController?.dispose();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
                Image.asset(widget.iconPath),
                SizedBox(width: 10),
                Text(widget.shortName.toUpperCase()),
                Spacer(),
                SizedBox(
                  child: TextFormField(
                    focusNode: widget.focusNode,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    decoration: InputDecoration(
                      suffix: Padding(
                        child: Text(widget.shortName.toUpperCase()),
                        padding: EdgeInsets.only(left: 2),
                      ),
                      suffixStyle: Theme.of(context).textTheme.subtitle1,
                      isDense: true,
                      focusedBorder: null,
                      enabledBorder: InputBorder.none,
                    ),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    controller: controller,
                    onChanged: widget.onChanged,
                    validator: (s) =>
                        double.tryParse(s) == null && s != _loadingStr
                            ? FlutterI18n.translate(context, 'invalid_value')
                            : null,
                    autovalidate: true,
                    readOnly: false,
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
                  widget.fullName,
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
                if (widget.amountPerUnit != null)
                  Text(
                    '1${widget.shortName.toUpperCase()} = ${widget.amountPerUnit} MXC',
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
