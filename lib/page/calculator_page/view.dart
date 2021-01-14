import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:collection/collection.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/wallet/tab_buttons.dart';
import 'package:supernodeapp/common/repositories/coingecko_repository.dart';
import 'package:supernodeapp/common/repositories/shared/dao/coingecko.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'reorderable_list_custom.dart';
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
  Map<int, Map<Currency, double>> values = {};
  bool isDemo;

  // double mxcPrice;

  double mining;
  double staking;
  double balance;

  double get mxcRate => rates == null ? null : rates[Currency.mxc].value;

  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    isDemo = widget.initState.isDemo;
    mining = widget.initState.mining;
    staking = widget.initState.staking;
    balance = widget.initState.balance;
    _loadSelectedCurrencies();
    reinitValues();
    Future.wait([
      _refreshRates(),
    ]).then((value) => recalcValues());
  }

  WalletDao _buildWalletDao() {
    return context.read<SupernodeRepository>().wallet;
  }

  ExchangeRepository _exchangeRepository() {
    return context.read<ExchangeRepository>();
  }

  void _loadSelectedCurrencies() {
    selectedCurrencies = context.read<StorageRepository>().selectedCurrencies();
  }

  Future<double> _getMxcPrice() async {
    final walletDao = _buildWalletDao();

    //final settingsData = GlobalStore.store.getState().settings;
    final userId = context.read<SupernodeCubit>().state.user.userId;
    final orgId = context.read<SupernodeCubit>().state.orgId;
    Map data = {
      'userId': userId,
      'orgId': orgId,
      'currency': '',
      'mxcPrice': '1'
    };
    final response = await walletDao.convertUSD(data);
    final mxcPriceText = response['mxcPrice'];
    return double.parse(mxcPriceText);
  }

  Future<void> _refreshRates() async {
    final dao = _exchangeRepository();
    final rates = await dao.exchangeRates();
    final mxcPrice = await _getMxcPrice();
    setState(() {
      this.rates = {
        ...rates,
        Currency.mxc: ExchangeRate(
          Currency.mxc.shortName,
          Currency.mxc.shortName.toUpperCase(),
          rates[Currency.usd].value / mxcPrice,
          'crypto',
        )
      };
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
        0: Map.fromEntries(selectedCurrencies.map((e) => MapEntry(e, null))),
        1: Map.fromEntries(selectedCurrencies.map((e) => MapEntry(e, null))),
        2: Map.fromEntries(selectedCurrencies.map((e) => MapEntry(e, null))),
      };
    });
    recalcValues();
  }

  void recalcValues() {
    _recalcValuesForTab(values[0], balance);
    _recalcValuesForTab(values[1], staking);
    _recalcValuesForTab(values[2], mining);
  }

  void _recalcValuesForTab(Map<Currency, double> values, double mxcValue,
      {int except}) {
    for (var i = 0; i < selectedCurrencies.length; i++) {
      //if (i == except) continue;
      final currency = selectedCurrencies[i];
      final rate = rates == null ? null : mxcRate / rates[currency]?.value;
      values[currency] = rate == null ? null : (mxcValue / rate);
    }
  }

  void onTextChanged(int tabNum, int currencyIndex, String valueText) {
    if (rates == null || mxcRate == null) return;
    final currency = selectedCurrencies[currencyIndex];
    final rate = rates == null ? null : mxcRate / rates[currency].value;
    final val = double.tryParse(valueText);
    if (val == null) return;
    final mxcValue = rate * val;
    if (tabNum == 0) balance = mxcValue;
    if (tabNum == 1) staking = mxcValue;
    if (tabNum == 2) mining = mxcValue;
    _recalcValuesForTab(values[tabNum], mxcValue, except: currencyIndex);
    setState(() {});
  }

  void onReorder(int tabNum, int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    setState(() {
      final currency = selectedCurrencies.removeAt(oldIndex);
      selectedCurrencies.insert(newIndex, currency);
    });
    await context
        .read<StorageRepository>()
        .setSelectedCurrencies(selectedCurrencies);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget tab(int number) {
    return GenericCurrencyTab(
      selectedCurrencies,
      values[number],
      mxcRate: mxcRate,
      rates: rates,
      onChanged: (s, i) => onTextChanged(number, i, s),
      onReorder: (a, b) => onReorder(number, a, b),
      tabNum: number,
      key: ValueKey('tab_$number'),
    );
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
      body: PageBody(
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
                tab(0),
                tab(1),
                tab(2),
              ],
              expandContent: true,
            ),
          ),
        ],
      ),
    );
  }
}

class GenericCurrencyTab extends StatefulWidget {
  final List<Currency> selectedCurrencies;
  final Map<Currency, double> values;
  final Map<Currency, ExchangeRate> rates;
  final double mxcRate;
  final void Function(String, int) onChanged;
  final void Function(int, int) onReorder;
  final int tabNum;

  GenericCurrencyTab(
    this.selectedCurrencies,
    this.values, {
    this.rates,
    this.mxcRate,
    this.onChanged,
    this.onReorder,
    this.tabNum,
    Key key,
  }) : super(key: key);

  @override
  _GenericCurrencyTabState createState() => _GenericCurrencyTabState();
}

class _GenericCurrencyTabState extends State<GenericCurrencyTab> {
  Map<Currency, GlobalKey> keys;
  static const _listComparer = const DeepCollectionEquality.unordered();

  @override
  void initState() {
    super.initState();
    _initKeys();
  }

  @override
  void didUpdateWidget(GenericCurrencyTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_listComparer.equals(widget.selectedCurrencies, keys.keys.toList())) {
      _initKeys();
    }
  }

  void _initKeys() {
    keys = widget.selectedCurrencies
        .asMap()
        .map((key, value) => MapEntry(value, GlobalKey()));
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListViewCustom(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      children: List.generate(widget.selectedCurrencies.length, (i) {
        final currency = widget.selectedCurrencies[i];
        final value = widget.values[currency];
        final rate = widget.rates == null
            ? null
            : widget.mxcRate /
                (widget.rates[currency]?.value ?? widget.mxcRate);
        var amountPerUnit = _loadingStr;
        if (widget.rates != null) {
          amountPerUnit = rate.toStringAsFixed(7);
        }
        if (currency == Currency.mxc) {
          amountPerUnit = null;
        }
        return CurrencyCard(
          shortName: currency.shortName,
          onChanged: (s) => widget.onChanged(s, i),
          fullName: FlutterI18n.translate(context, currency.shortName),
          value: value?.toStringAsFixed(2) ?? '...',
          amountPerUnit: amountPerUnit,
          iconPath: currency.iconPath,
          key: keys[currency],
        );
      }),
      onReorder: widget.onReorder,
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
    Key key,
  }) : super(key: key);

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
      child: Container(
        constraints: BoxConstraints(
          minHeight: 70,
          maxHeight: 120,
        ),
        child: Padding(
          padding: EdgeInsets.all(10).copyWith(top: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
      ),
    );
  }
}
