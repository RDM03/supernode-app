import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/page_content.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'actions.dart';

class DhxMiningPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
        title: FlutterI18n.translate(context, 'dhx_mining'),
        onPress: () => Navigator.pop(context),
      ),
      backgroundColor: backgroundColor,
      body: PageBody(children: [
        smallColumnSpacer(),
        SupernodeDhxMineActions(),
        PanelFrame(
            child: Column(
              children: [
                middleColumnSpacer(),
                NumberMinersAndMPower(),
                smallColumnSpacer(),
                SupernodeDhxTokenCardContent(miningPageVersion: true),
              ],
            )),
      ])
    );
  }

}