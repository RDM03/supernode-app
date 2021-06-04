import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/wallet.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/parser.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/gateway/state.dart';
import 'package:supernodeapp/page/miner_detail_page/tabs/miner_health_tab.dart';
import 'package:supernodeapp/page/miner_detail_page/tabs/miner_revenue_tab.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'tabs/miner_data_tab.dart';

class MinerDetailPage extends StatefulWidget {
  final GatewayItem item;

  const MinerDetailPage({Key key, this.item}) : super(key: key);

  @override
  _MinerDetailPageState createState() => _MinerDetailPageState();
}

class _MinerDetailPageState extends State<MinerDetailPage> {
  int selectedTab = 0;
  double downlinkPrice;
  List<GatewayStatisticResponse> frames;
  List<DailyStatistic> stats;
  double totalAmount;
  double averageHealth = 1;
  GatewayItem item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    initStateAsync();
  }

  Future<void> initStateAsync() async {
    await getStatistic();
    await getFrames();
    await getDownlinkPrice();
  }

  Future<void> refreshItem() async {
    final rep = context.read<SupernodeRepository>();

    final listMinersHealth = await rep.gateways
        .minerHealth({"orgId": context.read<SupernodeCubit>().state.orgId});

    final res = await context.read<SupernodeRepository>().gateways.list({
      'organizationID': context.read<SupernodeCubit>().state.orgId,
      'offset': 0,
      'limit': 10,
    }, search: item.id);
    final List<GatewayItem> gateways = parseGateways(res, listMinersHealth);
    if (gateways.isNotEmpty && mounted) {
      setState(() {
        item = gateways.first;
      });
    }
  }

  Future<void> getDownlinkPrice() async {
    downlinkPrice = await context
        .read<SupernodeRepository>()
        .wallet
        .downlinkPrice(context.read<SupernodeCubit>().state.orgId);
    if (mounted) setState(() {});
  }

  Future<void> getFrames() async {
    final res = await context.read<SupernodeRepository>().gateways.frames(
          widget.item.id,
          interval: 'DAY',
          endTimestamp: DateTime.now(),
          startTimestamp: DateTime.now().add(Duration(days: -7)),
        );
    frames = res;
    if (mounted) setState(() {});
  }

  Future<void> getHealth() async {
    final res = await context.read<SupernodeRepository>().gateways.frames(
          widget.item.id,
          interval: 'DAY',
          endTimestamp: DateTime.now(),
          startTimestamp: DateTime.now().add(Duration(days: -7)),
        );
    frames = res;
    if (mounted) setState(() {});
  }

  Future<void> getStatistic() async {
    final res =
        await context.read<SupernodeRepository>().wallet.miningIncomeGateway(
              gatewayMac: widget.item.id,
              orgId: context.read<SupernodeCubit>().state.orgId,
              fromDate: DateTime(2000, 01, 01),
              tillDate: DateTime.now(),
            );
    totalAmount = res.dailyStats.fold<double>(
      0.0,
      (source, v) => source + (double.tryParse(v.amount) ?? 0.0),
    );
    stats = res.dailyStats.skip(max(res.dailyStats.length - 7, 0)).toList();
    averageHealth = res.dailyStats.fold(
            0, (previousValue, element) => previousValue + element.health) /
        res.dailyStats.length;
    if (mounted) setState(() {});
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: PageNavBar(
                text: widget.item.name,
                centerTitle: true,
                actionWidget: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                child: CupertinoSlidingSegmentedControl(
                  groupValue: selectedTab,
                  onValueChanged: (tabIndex) =>
                      setState(() => selectedTab = tabIndex),
                  thumbColor: colorMxc,
                  children: <int, Widget>{
                    0: Text(
                      FlutterI18n.translate(context, 'health'),
                      style: TextStyle(
                        color: (selectedTab == 0) ? Colors.white : Colors.grey,
                      ),
                    ),
                    1: Text(
                      FlutterI18n.translate(context, 'revenue'),
                      style: TextStyle(
                        color: (selectedTab == 1) ? Colors.white : Colors.grey,
                      ),
                    ),
                    2: Text(
                      FlutterI18n.translate(context, 'data'),
                      style: TextStyle(
                        color: (selectedTab == 2) ? Colors.white : Colors.grey,
                      ),
                    ),
                  },
                ),
              ),
            ),
            if (selectedTab == 0)
              MinerHealthTab(
                item: item,
                health: stats,
                averageHealth: averageHealth,
                onRefresh: refreshItem,
              )
            else if (selectedTab == 1)
              MinerRevenueTab(
                item: widget.item,
                revenue: stats,
                totalAmount: totalAmount,
              )
            else if (selectedTab == 2)
              MinerDataTab(
                item: widget.item,
                frames: frames,
                downlinkPrice: downlinkPrice,
              )
          ],
        ),
      ),
    );
  }
}
