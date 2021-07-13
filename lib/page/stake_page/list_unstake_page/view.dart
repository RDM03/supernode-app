import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'state.dart';

Widget buildView(
    ListUnstakeState state, Dispatch dispatch, ViewService viewService) {
  var context = viewService.context;

  return Scaffold(
    body: Container(
      key: Key('unstakePage'),
      constraints: BoxConstraints.expand(),
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 235, 239, 242),
      ),
      child: ListView(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () => Navigator.of(context).pop(),
              key: ValueKey('backButton'),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(FlutterI18n.translate(context, 'unstake'),
                  style: FontTheme.of(context).big()),
            ],
          ),
          SizedBox(height: 30),
          Text(
            FlutterI18n.translate(context, 'choose_unstake'),
            style: FontTheme.of(context).middle.secondary(),
          ),
          SizedBox(height: 20),
          PanelFrame(
            rowTop: EdgeInsets.zero,
            child: state.isLoading
                ? LoadingList()
                : (state.stakes.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        key: ValueKey('stakesList'),
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemCount: state.stakes.length,
                        itemBuilder: (_, i) {
                          final stake = state.stakes[i];
                          return StakeItem.fromStake(
                            stake,
                            isLast: state.stakes.length - 1 == i,
                            onTap: () async {
                              final res = await Navigator.of(context)
                                  .pushNamed('details_stake_page', arguments: {
                                'stake': stake,
                                'isDemo': state.isDemo,
                              });
                              if (res ?? false) {
                                Navigator.of(context).pop(true);
                              }
                            },

                            // changed id to index for automated tests, should be changed back when tests can be stake specific
                            // use ${stake.id} instead of i

                            key: ValueKey('stakeItem_$i'),
                          );
                        },
                      )
                    : Empty()),
          ),
        ],
      ),
    ),
  );
}
