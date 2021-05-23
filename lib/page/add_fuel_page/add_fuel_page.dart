import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/colored_text.dart';
import 'package:supernodeapp/common/components/pagination_mixin.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/components/slider.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/add_fuel_page/confirm_page.dart';
import 'package:supernodeapp/page/add_fuel_page/proceed_dialog.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/parser.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/utils/extensions.dart';
import 'filter_dialog.dart';

class AddFuelPage extends StatefulWidget {
  const AddFuelPage({
    Key key,
  }) : super(key: key);

  @override
  _AddFuelPageState createState() => _AddFuelPageState();
}

class _AddFuelPageState extends State<AddFuelPage> with PaginationMixin {
  @override
  final scrollController = ScrollController();
  @override
  bool isLoading = false;
  @override
  bool get hasDataToLoad {
    if (forceStopLoading) return false;
    if (totalGateways == null) return true;
    return totalGateways > gateways?.length;
  }

  int totalGateways;
  List<GatewayItem> gateways;
  bool forceStopLoading = false;
  Map<String, double> gatewaySelection = {};

  @override
  Future<void> load() async {
    isLoading = true;
    if (mounted) {
      setState(() {});
    }
    try {
      final supernodeRepository = context.read<SupernodeRepository>();
      final orgId = context.read<SupernodeCubit>().state.orgId;
      final res = await supernodeRepository.gateways.list({
        "organizationID": orgId,
        "offset": gateways?.length ?? 0,
        "limit": 10,
      });
      final listMinersHealth = await supernodeRepository.gateways.minerHealth({
        "orgId": orgId,
      });
      totalGateways = int.parse(res['totalCount']);
      final newGateways = parseGateways(res, listMinersHealth);
      if (newGateways.isEmpty) forceStopLoading = true;
      if (mounted)
        setState(() {
          isLoading = false;
          gateways = [...(gateways ?? []), ...newGateways];
        });
    } finally {
      isLoading = false;
    }
  }

  @override
  void initState() {
    super.initState();
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
            child: Image.asset(AppImages.fuelCircle),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Add Fuel',
                  style: kBigBoldFontOfBlack,
                ),
                Text(
                  'Your miners are like cars, need MXC Fuel to continue mining.',
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
            top: BorderSide(color: Colors.grey.shade200, width: 0.5),
            bottom: BorderSide(color: Colors.grey.shade200, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            SizedBox(width: 20),
            SizedBox(
              child: ButtonTheme(
                padding: EdgeInsets.zero,
                child: PrimaryButton(
                  onTap: () {},
                  buttonTitle: 'Select all',
                  bgColor: healthColor,
                  minWidth: 0,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Fuel all',
                textAlign: TextAlign.right,
                style: kBigFontOfBlack,
              ),
            ),
            SizedBox(width: 5),
            Switch(
              value: false,
              onChanged: (v) {},
              inactiveThumbColor: Colors.grey.shade700,
              activeColor: healthColor,
            ),
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
                      padding: EdgeInsets.only(left: 10, right: 8),
                      child: Icon((gatewaySelection[item.id] ?? 0) > 0
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.name,
                      style: kBigFontOfBlack,
                    ),
                  ),
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
                  SizedBox(width: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: 30,
                child: MxcSliderTheme(
                  child: Slider(
                    value: gatewaySelection[item.id] ?? 0,
                    onChanged: (v) =>
                        setState(() => gatewaySelection[item.id] = v),
                    activeColor: healthColor,
                    inactiveColor: healthColor.withOpacity(0.2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 16),
                Text('To 100% : ', style: kSmallFontOfGrey),
                Text(
                  '1000 MXC',
                  style: kSmallFontOfBlack.copyWith(color: healthColor),
                ),
                Spacer(),
                ColoredText(
                  text: '0 MXC',
                  color: healthColor.withOpacity(0.2),
                  style: kMiddleFontOfBlack,
                  padding: EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          ],
        ),
      );

  void onFilter() {
    showInfoDialog(
      context,
      filterDialog(),
    );
  }

  Future<void> onNext(BuildContext context) async {
    final res = await showCupertinoModalPopup(
          context: context,
          builder: (ctx) => proceedDialog(ctx),
        ) ??
        false;
    if (res) {
      final orgId = context.read<SupernodeCubit>().state.orgId;
      final rep = context.read<SupernodeRepository>();
      final res = await rep.gateways
          .topUpMiningFuel(
            currency: 'ETH_MXC',
            orgId: orgId,
            topUps: gatewaySelection.entries
                .where((e) => e.value > 0)
                .map((e) =>
                    TopUpGatewayRequest((e.value * 10000000).toString(), e.key))
                .toList(),
          )
          .withError();

      if (res.success) {
        await Navigator.of(context).push(route((ctx) => AddFuelConfirmPage()));
      } else {
        await Navigator.of(context).push(
          route((ctx) => AddFuelConfirmPage(error: res.error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAndActionAppBar(
        action: IconButton(
          icon: Icon(
            Icons.filter_list,
          ),
          onPressed: onFilter,
          color: Colors.black,
        ),
        title: 'Add Fuel',
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
                if (isLoading && gateways == null)
                  SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(healthColor),
                        backgroundColor: healthColor.withOpacity(0.2),
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
                          backgroundColor: healthColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ),
                // TODO: No items warning
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Container(height: 0.5, color: Colors.grey.shade200),
                SizedBox(height: 16),
                Center(
                  child: Text(
                    '0 MXC',
                    style: kVeryBigFontOfBlack.copyWith(color: healthColor),
                  ),
                ),
                SizedBox(height: 9),
                Center(
                  child: Text(
                    'Send amount',
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
                      buttonTitle: 'Next',
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
