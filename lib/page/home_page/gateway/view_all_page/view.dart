import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/dd_body.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/common/components/page/dd_nav.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/page/home_page/gateway/view_all_page/component/bar_chart.dart';
import 'package:supernodeapp/page/home_page/gateway/view_all_page/component/chart_stats.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'bloc/cubit.dart';
import 'bloc/state.dart';
import 'component/tab_indicator.dart';

class ViewAllPage extends StatelessWidget {
  final String minerId;
  final MinerStatsType type;

  const ViewAllPage({
    Key key,
    @required this.minerId,
    this.type = MinerStatsType.uptime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MinerStatsCubit>(
      create: (ctx) => MinerStatsCubit(
        context.read<AppCubit>(),
        context.read<SupernodeCubit>(),
        context.read<SupernodeRepository>(),
        TimeUtil.weekDayShort(context),
        TimeUtil.monthsShort(context),
        TimeUtil.months(context),
        FlutterI18n.translate(context, "day"),
      ),
      child: _ViewAllPage(
        minerId: minerId,
        type: type,
      ),
    );
  }
}

class _ViewAllPage extends StatefulWidget {
  final String minerId;
  final MinerStatsType type;

  const _ViewAllPage({
    Key key,
    @required this.minerId,
    this.type = MinerStatsType.uptime,
  }) : super(key: key);

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<_ViewAllPage>
    with TickerProviderStateMixin {
  Loading loading;
  TabController _tabController;
  List titles = ['uptime', 'revenue', 'frame_received', 'frame_transmitted'];
  List tabs = ['week', 'month', 'year'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    context.read<MinerStatsCubit>().setSelectedType(widget.type);
    Future.wait([
      context.read<MinerStatsCubit>().dispatchData(
          type: widget.type, minerId: widget.minerId, timePeriod: MinerStatsTimePeriod.week)
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<MinerStatsCubit, MinerStatsState>(
            listenWhen: (a, b) => a.showLoading != b.showLoading,
            listener: (ctx, state) async {
              loading?.hide();
              if (state.showLoading) {
                loading = Loading.show(ctx);
              }
            },
          ),
        ],
        child: DDBody(
            child: Flex(direction: Axis.vertical, children: [
          DDNav(hasBack: true, title: titles[widget.type.index]),
          Container(
              margin: kRoundRow1005,
              padding: kRoundRow5,
              height: 40,
              decoration: BoxDecoration(
                color: ColorsTheme.of(context).mxcBlue20,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TabBar(
                isScrollable: false,
                indicatorWeight: 0,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelColor: ColorsTheme.of(context).textLabel,
                indicator: TabIndicator(ColorsTheme.of(context).mxcBlue),
                controller: _tabController,
                tabs: tabs
                    .map((item) =>
                        Tab(text: FlutterI18n.translate(context, item)))
                    .toList(),
                onTap: (index) =>
                  context.read<MinerStatsCubit>().setTabTimePeriod(tabs[index]),
              )),
          BlocBuilder<MinerStatsCubit, MinerStatsState>(
              buildWhen: (a, b) =>
                  a.upperLabel != b.upperLabel
                  || a.statsLabel != b.statsLabel
                  || a.selectedTimePeriod != b.selectedTimePeriod,
              builder: (ctx, state) {
                return DDChartStats(
                  title: context.read<MinerStatsCubit>().getStatsTitle(),
                  subTitle: context.read<MinerStatsCubit>().state.statsLabel,
                  upperLabel: context.read<MinerStatsCubit>().state.upperLabel,
                );
              }),
          Expanded(
              child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: tabs.map((item) {
              return BlocBuilder<MinerStatsCubit, MinerStatsState>(
                  buildWhen: (a, b) =>
                  a.selectedTimePeriod != b.selectedTimePeriod
                      //|| a.originList != b.originList
                      //|| a.originMonthlyList != b.originMonthlyList
                      //|| a.originYearlyList != b.originYearlyList
                      || a.xDataList != b.xDataList
                      || a.xLabelList != b.xLabelList
                      || a.yLabelList != b.yLabelList,
                  builder: (ctx, state) {
                    final xLabel = state.xLabelList
                        .map((item) => FlutterI18n.translate(context, item))
                        .toList();
                    final numBar = context.read<MinerStatsCubit>().getNumBar();
                return state.originList.isEmpty || state.xDataList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : DDBarChart(
                        hasYAxis: true,
                        hasTooltip: true,
                        tooltipData: context
                            .read<MinerStatsCubit>()
                            .getDataByTimePeriod()
                            .map((item) => context
                                .read<MinerStatsCubit>()
                                .getTooltip(item))
                            .toList(),
                        numBar: numBar,
                        xData: state.xDataList,
                        xLabel: xLabel,
                        yLabel: state.yLabelList,
                        notifyGraphBarScroll: (way) =>
                          context.read<MinerStatsCubit>().setChartStats(way)
                );
              });
            }).toList(),
          )),
          DDBoxSpacer(height: SpacerStyle.xbig),
          DDBoxSpacer(height: SpacerStyle.xbig),
        ])));
  }
}
