import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(
    ListUnstakeState state, Dispatch dispatch, ViewService viewService) {
  var context = viewService.context;

  return Scaffold(
    body: Container(
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
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Text(FlutterI18n.translate(context, 'unstake'),
                  style: kBigFontOfBlack),
            ],
          ),
          SizedBox(height: 30),
          Text(
            FlutterI18n.translate(context, 'choose_unstake'),
            style: kMiddleFontOfGrey,
          ),
          SizedBox(height: 20),
          panelFrame(
            rowTop: EdgeInsets.zero,
            child: state.isLoading
                ? LoadingList()
                : (state.stakes.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
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
                          );
                        },
                      )
                    : empty(context)),
          ),
        ],
      ),
    ),
  );
}
