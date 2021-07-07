import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/circle_button.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/pagination_mixin.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/parser.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/utils/extensions.dart';
import 'confirm_page.dart';
import 'filter_dialog.dart';
import 'proceed_dialog.dart';

class SendToWalletPage extends StatefulWidget {
  const SendToWalletPage({
    Key key,
    this.gatewayItem,
  }) : super(key: key);

  final GatewayItem gatewayItem;

  @override
  _SendToWalletPageState createState() => _SendToWalletPageState();
}

class _SendToWalletPageState extends State<SendToWalletPage>
    with PaginationMixin {
  @override
  final scrollController = ScrollController();
  @override
  bool isLoading = false;
  @override
  bool get hasDataToLoad {
    if (widget.gatewayItem != null) return false;
    if (forceStopLoading) return false;
    if (totalGateways == null) return true;
    return totalGateways > allGateways?.length;
  }

  int totalGateways;
  List<GatewayItem> allGateways;
  List<GatewayItem> gateways;
  Map<String, GatewayItem> gatewaysMap;
  bool forceStopLoading = false;
  Map<String, double> gatewaySelection = {};

  @override
  Future<void> load({bool noLimit = false}) async {
    if (widget.gatewayItem != null) return;
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    try {
      final supernodeRepository = context.read<SupernodeRepository>();
      final orgId = context.read<SupernodeCubit>().state.orgId;
      final res = await supernodeRepository.gateways.list({
        "organizationID": orgId,
        "offset": allGateways?.length ?? 0,
        "limit": noLimit ? 10000000 : 10,
      });
      final listMinersHealth = await supernodeRepository.gateways.minerHealth({
        "orgId": orgId,
      });
      totalGateways = int.parse(res['totalCount']);
      final newGateways = parseGateways(res, listMinersHealth, orgId);
      if (newGateways.isEmpty) forceStopLoading = true;
      if (mounted)
        setState(() {
          isLoading = false;
          allGateways = [...(allGateways ?? <GatewayItem>[]), ...newGateways];
          gateways = allGateways
              .where((e) => e.miningFuel > Decimal.zero && !e.reseller)
              .toList();
          gatewaysMap =
              gateways.asMap().map((key, value) => MapEntry(value.id, value));
        });
    } catch (e) {
      tip(e?.message ?? FlutterI18n.translate(context, 'error_tip'));
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.gatewayItem != null) {
      gateways = [widget.gatewayItem];
      gatewaysMap = {widget.gatewayItem.id: widget.gatewayItem};
    } else
      load();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Widget addFuelMessage() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleButton(
              key: Key('addFuelBottom'),
              circleColor: whiteColor,
              icon: Icon(Icons.arrow_forward, color: fuelColor),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  FlutterI18n.translate(context, 'send_to_wallet'),
                  style: kBigBoldFontOfBlack,
                ),
                Text(
                  FlutterI18n.translate(context, 'send_to_wallet_desc'),
                ),
              ],
            ),
          ),
        ],
      );

  Widget selectAll() => Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: greyColorShade200, width: 0.5),
            bottom: BorderSide(color: greyColorShade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                FlutterI18n.translate(context, 'add_all'),
                textAlign: TextAlign.right,
                style: kBigFontOfBlack,
              ),
            ),
            SizedBox(width: 5),
            Switch(
              value: gateways != null &&
                  gateways.length > 0 &&
                  gatewaySelection.length >= gateways.length &&
                  !hasDataToLoad &&
                  gatewaySelection.values.every((e) => e == 1),
              onChanged: (v) {
                if (v)
                  fuelAll();
                else
                  defaultAll();
              },
              inactiveThumbColor: greyColorShade700,
              activeColor: healthColor,
            ),
            SizedBox(width: 16),
          ],
        ),
      );

  Widget gatewayItem(GatewayItem item) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => gatewaySelection[item.id] = 0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 28, right: 4, top: 3),
                      child: Icon(
                        Icons.check,
                        size: 18,
                        color: (gatewaySelection[item.id] ?? 0) > 0
                            ? healthColor
                            : greyColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.name,
                      style: kBigFontOfBlack,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    AppImages.gateways,
                    height: 16,
                    color: colorMxc,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${Tools.priceFormat((item.health ?? 0) * 100, range: 0)}%',
                    style: kBigFontOfBlack,
                  ),
                  SizedBox(width: 18),
                  Image.asset(
                    AppImages.fuel,
                    color: fuelColor,
                    height: 16,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '${Tools.priceFormat((item.miningFuelHealth ?? 0) * 100, range: 0)}%',
                    style: kBigFontOfBlack,
                  ),
                  SizedBox(width: 28),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: SizedBox(
                height: 30,
                child: MxcSliderTheme(
                  child: Slider(
                    value: gatewaySelection[item.id] ?? 0,
                    onChanged: (v) =>
                        setState(() => gatewaySelection[item.id] = v),
                    activeColor: healthColor,
                    inactiveColor: healthColor20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 32),
                Text(FlutterI18n.translate(context, 'current_fuel'),
                    style: kSmallFontOfGrey),
                Text(
                  '${Tools.priceFormat(item.miningFuel.toDouble(), range: 2)} MXC',
                  style: kSmallFontOfBlack.copyWith(color: healthColor),
                ),
                Spacer(),
                ColoredText(
                  text:
                      '${Tools.priceFormat(item.miningFuel.toDouble() * (gatewaySelection[item.id] ?? 0), range: 2)} MXC',
                  color: healthColor20,
                  style: kMiddleFontOfBlack,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                ),
                SizedBox(width: 32),
              ],
            ),
          ],
        ),
      );

  Future<void> fuelAll() async {
    await load(noLimit: true);
    gateways.forEach((e) => gatewaySelection[e.id] = 1);
    if (mounted) setState(() {});
  }

  void defaultAll() {
    gateways.forEach((e) => gatewaySelection[e.id] = 0);
    if (mounted) setState(() {});
  }

  void onFilter() {
    showInfoDialog(
      context,
      filterDialog(),
    );
  }

  Future<void> onNext(BuildContext context) async {
    final res = await showCupertinoModalPopup(
          context: context,
          builder: (ctx) => proceedDialog(ctx, withdrawMxc),
        ) ??
        false;
    if (res) {
      final loading = Loading.show(context);
      try {
        final orgId = context.read<SupernodeCubit>().state.orgId;
        final rep = context.read<SupernodeRepository>();
        final withdraws =
            gatewaySelection.entries.where((e) => e.value > 0).map((e) {
          var val =
              (gatewaysMap[e.key].miningFuel.toDouble() * e.value).toString();
          if (gatewaysMap[e.key].miningFuel < Decimal.parse(val))
            val = gatewaysMap[e.key].miningFuel.toString();

          return GatewayAmountRequest(
            val,
            e.key,
          );
        }).toList();

        await rep.wallet.withdrawMiningFuel(
            currency: 'ETH_MXC', orgId: orgId, withdraws: withdraws);

        await context.read<GatewayCubit>().refreshGateways();
        await context.read<SupernodeUserCubit>().refreshBalance();
        loading.hide();
        await Navigator.of(context)
            .push(route((ctx) => SendToWalletConfirmPage()));
        Navigator.of(context).pop();
      } catch (e) {
        loading.hide();
        await Navigator.of(context).push(
          route((ctx) => SendToWalletConfirmPage(error: e)),
        );
      } finally {
        loading.hide();
      }
    }
  }

  double get withdrawMxc {
    var total = 0.0;
    gatewaySelection.forEach((key, value) =>
        total += gatewaysMap[key].miningFuel.toDouble() * value);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAndActionAppBar(
        // action: IconButton(
        //   icon: Icon(
        //     Icons.filter_list,
        //   ),
        //   onPressed: onFilter,
        //   color: blackColor,
        // ),
        title: FlutterI18n.translate(context, 'send_to_wallet'),
        onPress: () => Navigator.of(context).pop(),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      addFuelMessage(),
                      SizedBox(height: 19),
                      selectAll(),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => gatewayItem(gateways[i]),
                    childCount: gateways?.length ?? 0,
                  ),
                ),
                if (gateways?.isEmpty ?? false)
                  SliverFillRemaining(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        right: 46,
                        left: 46,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          FlutterI18n.translate(
                              context, 'send_to_wallet_dont_have_miners'),
                          textAlign: TextAlign.center,
                          style: kMiddleFontOfGrey,
                        ),
                      ),
                    ),
                  )
                else if (isLoading && gateways == null)
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(healthColor),
                        backgroundColor: healthColor20,
                      ),
                    ),
                  )
                else if (isLoading)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(healthColor),
                          backgroundColor: healthColor20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(height: 0.5, color: greyColorShade200),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    '${Tools.priceFormat(withdrawMxc, range: 2)} MXC',
                    style: kVeryBigFontOfBlack.copyWith(color: healthColor),
                  ),
                ),
                SizedBox(height: 9),
                Center(
                  child: Text(
                    FlutterI18n.translate(context, 'send_amount'),
                    style: kMiddleFontOfGrey,
                  ),
                ),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PrimaryButton(
                      onTap: () => onNext(context),
                      minHeight: 46,
                      buttonTitle: FlutterI18n.translate(context, 'next'),
                      bgColor: healthColor,
                      minWidth: 0,
                      textStyle: kBigFontOfWhite,
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
