import 'package:flutter/cupertino.dart' hide Wrap;
import 'package:flutter/material.dart' hide Wrap;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/buttons/secondary_button.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/row_spacer.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/common/components/wallet/date_buttons.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/mxc/cubit.dart';
import 'package:supernodeapp/theme/colors.dart';

class StakeHistoryContent extends StatefulWidget {
  @override
  _StakeHistoryContentState createState() => _StakeHistoryContentState();
}

enum StakeHistoryFilter { stake, unstake }

class _StakeHistoryContentState extends State<StakeHistoryContent> {
  bool isSetDate = false;
  StakeHistoryFilter filter;

  String firstTime = TimeUtil.getDatetime(new DateTime.now(), type: 'date');
  String secondTime = TimeUtil.getDatetime(new DateTime.now(), type: 'date');

  Wrap<List<StakeHistoryEntity>> originalHistory;
  List<StakeHistoryEntity> filteredHistory;

  @override
  void initState() {
    super.initState();
    context.read<SupernodeMxcCubit>().listen((w) {
      if (w.stakes != originalHistory) {
        originalHistory = w.stakes;
        filterHistory();
      }
    });
    originalHistory = context.read<SupernodeMxcCubit>().state.stakes;
    filterHistory();
  }

  void filterHistory() {
    var temp = originalHistory.value;
    if (temp != null) {
      if (filter == null) {
        temp = temp
            .where((e) => e.type == 'STAKING' || e.type == 'UNSTAKING')
            .toList();
      } else {
        temp = temp
            .where((e) => filter == StakeHistoryFilter.stake
            ? e.type == 'STAKING'
            : e.type == 'UNSTAKING')
            .toList();
      }

      temp.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    }
    this.filteredHistory = temp;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SecondaryButton(
                key: ValueKey('stakeKey'),
                isSelected: filter == StakeHistoryFilter.stake,
                buttonTitle:
                    FlutterI18n.translate(context, 'stake').toUpperCase(),
                color: filter == StakeHistoryFilter.stake
                    ? selectedTabColor
                    : Colors.white,
                onTap: () {
                  if (filter == StakeHistoryFilter.stake)
                    setState(() => filter = null);
                  else
                    setState(() => filter = StakeHistoryFilter.stake);
                  filterHistory();
                },
              ),
              smallRowSpacer(),
              SecondaryButton(
                key: ValueKey('unstakeKey'),
                isSelected: filter == StakeHistoryFilter.unstake,
                buttonTitle:
                    FlutterI18n.translate(context, 'unstake').toUpperCase(),
                color: filter == StakeHistoryFilter.unstake
                    ? selectedTabColor
                    : Colors.white,
                onTap: () {
                  if (filter == StakeHistoryFilter.unstake)
                    setState(() => filter = null);
                  else
                    setState(() => filter = StakeHistoryFilter.unstake);
                  filterHistory();
                },
              ),
              smallRowSpacer(),
              SecondaryButton(
                isSelected: isSetDate,
                buttonTitle:
                    FlutterI18n.translate(context, 'set_date').toUpperCase(),
                color: isSetDate ? selectedTabColor : Colors.white,
                icon: Icons.date_range,
                onTap: () {
                  setState(() => isSetDate = !isSetDate);
                },
              )
            ],
          ),
        ),
        if (isSetDate)
          Padding(
            padding: EdgeInsets.only(top: 5),
            child: dateButtons(
              context,
              firstTime: firstTime,
              secondTime: secondTime,
              thirdText: FlutterI18n.translate(context, 'search'),
              firstTimeOnTap: (date) => setState(() => firstTime = date),
              secondTimeOnTap: (date) => setState(() => secondTime = date),
              onSearch: () => filterHistory(),
            ),
          ),
        SizedBox(height: 12),
        PanelFrame(
          margin: EdgeInsets.zero,
          child: filteredHistory == null
              ? LoadingList()
              : (filteredHistory.length != 0
                  ? ListView.builder(
                      itemBuilder: (ctx, i) => StakeItem.fromStake(
                        filteredHistory[i].stake,
                        onTap: () async {
                          await Navigator.of(context).pushNamed(
                            'details_stake_page',
                            arguments: {
                              'stake': filteredHistory[i].stake,
                              'isDemo': context.read<AppCubit>().state.isDemo,
                            },
                          );
                        },
                      ),
                      itemCount: filteredHistory.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    )
                  : Empty()),
        ),
      ],
    );
  }
}
