import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/loading_tiny.dart';
import 'package:supernodeapp/common/components/page/dd_body.dart';
import 'package:supernodeapp/common/components/page/dd_box_spacer.dart';
import 'package:supernodeapp/common/components/page/dd_nav.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/page/view_all_page/component/bar_chart.dart';
import 'package:supernodeapp/page/view_all_page/component/chart_stats.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'bloc/cubit.dart';
import 'bloc/state.dart';
import 'component/tab_indicator.dart';

class ViewAllPage extends StatefulWidget {
  final String minerId;
  final MinerStatsType type;

  const ViewAllPage({
    Key key,
    @required this.minerId,
    this.type = MinerStatsType.uptime,
  }): super(key: key);

  @override
  _ViewAllPageState createState() => _ViewAllPageState();
}

class _ViewAllPageState extends State<ViewAllPage> with TickerProviderStateMixin {
  Loading loading;
  TabController _tabController;
  List titles = ['uptime', 'revenue', 'frameReceived', 'frameTransmitted'];
  List tabs = ['week', 'month', 'year'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);

    context.read<MinerStatsCubit>().setSelectedType(widget.type);
    context.read<MinerStatsCubit>().dispatchData(
        type: widget.type, 
        minerId: widget.minerId
      );
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
        child: Flex(
          direction: Axis.vertical,
          children: [
            DDNav(
              hasBack: true,
              title: titles[widget.type.index]
            ),
            Container(
              margin: kRoundRow105,
              padding: kRoundRow5,
              height: 40,
              decoration: BoxDecoration(
                color: dartBlueColor.withAlpha(20),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: TabBar(
                isScrollable: false,
                indicatorWeight: 0,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold
                ),
                unselectedLabelColor: Colors.grey,
                indicator: TabIndicator(),
                controller: _tabController,
                tabs: tabs.map((item) => Tab(text: FlutterI18n.translate(context,item))).toList(),
                onTap: (index){
                  context.read<MinerStatsCubit>().tabTime(tabs[index]);

                  context.read<MinerStatsCubit>().dispatchData(
                    type: widget.type, 
                    time: [MinerStatsTime.week,MinerStatsTime.month,MinerStatsTime.year][index],
                    minerId: widget.minerId,
                  );
                },
              )
            ),
            BlocBuilder<MinerStatsCubit, MinerStatsState>(
              // buildWhen: (a, b) => b.originList.isNotEmpty,
              builder: (ctx, state) {
                return DDChartStats(
                  title: context.read<MinerStatsCubit>().getStatsTitle(),
                  subTitle: context.read<MinerStatsCubit>().getStatsSubitle(),
                  startTime: context.read<MinerStatsCubit>().getStartTimeLabel() ?? '--',
                  endTime: context.read<MinerStatsCubit>().getEndTimeLabel() ?? '--',
                );
              }
            ),
            DDBoxSpacer(height: SpacerStyle.big),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: tabs.map((item) {

                  return BlocBuilder<MinerStatsCubit, MinerStatsState>(
                    // buildWhen: (a, b) => b.originList.isNotEmpty,
                    builder: (ctx, state) {
                      return state.originList.isEmpty ?
                      Container() :
                      DDBarChart(
                        hasYAxis: true,
                        numBar: context.read<MinerStatsCubit>().getNumBar(),
                        xData: state.xDataList,
                        xLabel: state.xLabelList,
                        yLabel: state.yLabelList,
                        notifyGraphBarScroll: (way, {scrollController}) {
                          if(scrollController.positions.last.outOfRange &&      
                              scrollController.offset < 0){
                            
                            tip(FlutterI18n.translate(context, 'no_data'),success: true);
                            return;
                          }

                          if (scrollController.positions.last.outOfRange) {

                            context.read<MinerStatsCubit>().dispatchData(
                              type: widget.type, 
                              time: state.selectedTime,
                              minerId: widget.minerId,
                              startTime: state.originList.last.date,
                              endTime: state.originList.first.date
                            );
                          }
                  
                        }
                      );
                    });
                }).toList(),
              )
            ),
            DDBoxSpacer(height: SpacerStyle.xbig),
            DDBoxSpacer(height: SpacerStyle.xbig),
          ]
        )
      )
    );
  }
}