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
  Map<int, List<TextEditingController>> controllers = {};
  Map<int, List<String>> controllersValue = {};
  Map<int, ScrollController> scrollControllers = {
    0: ScrollController(keepScrollOffset: false),
    1: ScrollController(),
    2: ScrollController(),
  };
  Map<int, List<FocusNode>> focusNodes = {};

  bool isDemo;

  double mxcPrice;

  double mining;
  double staking;
  double balance;

  double get mxcRate => rates == null || mxcPrice == null
      ? null
      : rates[Currency.usd].value / mxcPrice;

  bool lockControllers = false;

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
    reinitControllers();
    Future.wait([
      _refreshMxcPrice(),
      _refreshRates(),
    ]).then((value) => recalcControllers());
    focusNodes[0][0].requestFocus();
    tabController.addListener(_tabControllerChanged);
  }

  WalletDao _buildWalletDao() {
    return isDemo ? DemoWalletDao() : WalletDao();
  }

  void _tabControllerChanged() {
    if (tabController.indexIsChanging) return;
    focusNodes[tabController.index][0].requestFocus();
    FocusScope.of(context).unfocus();
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
    reinitControllers();
  }

  void reinitControllers() {
    disposeControllers();
    setState(() {
      controllers = {
        0: List.generate(
            selectedCurrencies.length, (_) => TextEditingController()),
        1: List.generate(
            selectedCurrencies.length, (_) => TextEditingController()),
        2: List.generate(
            selectedCurrencies.length, (_) => TextEditingController()),
      };
      focusNodes = {
        0: List.generate(selectedCurrencies.length, (_) => FocusNode()),
        1: List.generate(selectedCurrencies.length, (_) => FocusNode()),
        2: List.generate(selectedCurrencies.length, (_) => FocusNode()),
      };
      controllersValue = {
        0: List.generate(selectedCurrencies.length, (_) => null),
        1: List.generate(selectedCurrencies.length, (_) => null),
        2: List.generate(selectedCurrencies.length, (_) => null),
      };
    });
    for (final entry in controllers.entries) {
      final tabNum = entry.key;
      final list = entry.value;
      for (var i = 0; i < list.length; i++) {
        final controller = list[i];
        controller.addListener(() => onTextChanged(tabNum, i, controller));
      }
    }
    recalcControllers();
  }

  void recalcControllers() {
    _recalcControllersForTab(controllers[0], balance);
    _recalcControllersForTab(controllers[1], staking);
    _recalcControllersForTab(controllers[2], mining);
  }

  void _recalcControllersForTab(
      List<TextEditingController> controllers, double value,
      {TextEditingController except}) {
    lockControllers = true;
    for (var i = 0; i < selectedCurrencies.length; i++) {
      if (controllers[i] == except) continue;
      final currency = selectedCurrencies[i];
      final rate =
          rates == null ? null : mxcRate / (rates[currency]?.value ?? mxcRate);
      controllers[i].value = controllers[i].value.copyWith(
          text: rate == null ? '...' : (value / rate).toStringAsFixed(2));
    }
    lockControllers = false;
  }

  void onTextChanged(
      int tabNum, int currencyIndex, TextEditingController controller) {
    if (lockControllers) return;
    if (controllersValue[tabNum][currencyIndex] == null ||
        controllersValue[tabNum][currencyIndex] == controller.text) {
      controllersValue[tabNum][currencyIndex] = controller.text;
      return;
    }
    if (rates == null || mxcRate == null) return;
    controllersValue[tabNum][currencyIndex] = controller.text;
    final currency = selectedCurrencies[currencyIndex];
    final rate =
        rates == null ? null : mxcRate / (rates[currency]?.value ?? mxcRate);
    final valueText = controller.text;
    final val = double.tryParse(valueText);
    if (val == null) return;
    final mxcValue = rate * val;
    if (tabNum == 0) balance = mxcValue;
    if (tabNum == 1) staking = mxcValue;
    if (tabNum == 2) mining = mxcValue;
    //_recalcControllersForTab(controllers[tabNum], mxcValue, except: controller);
    controllers[tabNum][currencyIndex].text = '234';
  }

  void disposeControllers() {
    if (controllers != null) {
      for (final tabNum in controllers.keys) {
        final controllersList = controllers[tabNum];
        final nodesList = focusNodes[tabNum];
        for (var i = 0; i < controllersList.length; i++) {
          final controller = controllersList[i];
          final node = nodesList[i];
          node.dispose();
          controller.dispose();
        }
      }
    }
  }

  @override
  void dispose() {
    disposeControllers();
    scrollControllers.forEach((key, value) => value.dispose());
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
                  controllers[0],
                  mxcRate: mxcRate,
                  rates: rates,
                  scrollController: scrollControllers[0],
                  focusNodes: focusNodes[0],
                ),
                GenericCurrencyTab(
                  selectedCurrencies,
                  controllers[1],
                  mxcRate: mxcRate,
                  rates: rates,
                  scrollController: scrollControllers[1],
                  focusNodes: focusNodes[1],
                ),
                GenericCurrencyTab(
                  selectedCurrencies,
                  controllers[2],
                  mxcRate: mxcRate,
                  rates: rates,
                  scrollController: scrollControllers[2],
                  focusNodes: focusNodes[2],
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
  final List<TextEditingController> controllers;
  final Map<Currency, ExchangeRate> rates;
  final double mxcRate;
  final ScrollController scrollController;
  final List<FocusNode> focusNodes;

  GenericCurrencyTab(
    this.selectedCurrencies,
    this.controllers, {
    this.rates,
    this.mxcRate,
    this.scrollController,
    this.focusNodes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      addAutomaticKeepAlives: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      controller: scrollController,
      itemCount: selectedCurrencies.length,
      itemBuilder: (_, i) {
        final currency = selectedCurrencies[i];
        final controller = controllers[i];
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
          fullName: FlutterI18n.translate(context, currency.shortName),
          controller: controller,
          amountPerUnit: amountPerUnit,
          iconPath: currency.iconPath,
          focusNode: focusNodes[i],
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
  final TextEditingController controller;
  final String amountPerUnit;
  final String iconPath;
  final FocusNode focusNode;

  CurrencyCard({
    this.shortName,
    this.fullName,
    this.controller,
    this.amountPerUnit,
    this.iconPath,
    this.focusNode,
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
                  child: TextFormField(
                    focusNode: focusNode,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    decoration: InputDecoration(
                      suffix: Padding(
                        child: Text(shortName.toUpperCase()),
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
                    validator: (s) =>
                        double.tryParse(s) == null && s != _loadingStr
                            ? FlutterI18n.translate(context, 'invalid_value')
                            : null,
                    autovalidate: true,
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
