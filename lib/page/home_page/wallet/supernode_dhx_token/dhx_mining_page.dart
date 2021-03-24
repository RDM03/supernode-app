import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/page_content.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'actions.dart';

class DhxMiningPage extends StatefulWidget {
  @override
  _DhxMiningPageState createState() => _DhxMiningPageState();
}

class _DhxMiningPageState extends State<DhxMiningPage> {
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
            ),
          ),
          middleColumnSpacer(),
          Row(children: [
            Text(FlutterI18n.translate(context, 'status'), style: kSmallFontOfBlack),
            Spacer(),
            Icon(Icons.circle, color: Token.supernodeDhx.color, size: 12),
            Text(FlutterI18n.translate(context, "today"), style: kSmallFontOfBlack),
            Spacer(),
            Icon(Icons.circle, color: Token.supernodeDhx.color.withOpacity(0.2), size: 12),
            Text(FlutterI18n.translate(context, 'cool_off'), style: kSmallFontOfBlack),
            Spacer(),
            Image.asset(AppImages.iconUnbond, scale: 1.8, color: Colors.red),
            Text(FlutterI18n.translate(context, 'unbonded'), style: kSmallFontOfBlack)
          ]),
          smallColumnSpacer(),
          PanelFrame(
            rowTop: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Mar '21", style: kBigFontOfBlack,),
                  smallColumnSpacer(),
                  BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                    buildWhen: (a, b) =>
                      a.calendarBondInfo != b.calendarBondInfo,
                    builder: (context, state) => GridView.count(
                      crossAxisCount: 7,
                      childAspectRatio: (1 / 2),
                      shrinkWrap: true,
                      children: state.calendarBondInfo.map((e) => _CalendarElement(e)).toList(),
                    ),
                  ),
                  smallColumnSpacer(),
                  Text(FlutterI18n.translate(context, 'bonding_calendar_note'), style: kSmallFontOfBlack),
                ],
              ),
            ),
          ),
          middleColumnSpacer(),
        ])
    );
  }
}

class _CalendarElement extends StatelessWidget {
  final CalendarModel model;

  _CalendarElement(this.model);

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(12);

    BoxDecoration getDecoration() {
      if (model.left || model.right || model.middle)
        return BoxDecoration(
            color: Token.supernodeDhx.color.withOpacity(0.2),
            borderRadius: BorderRadius.horizontal(
                left: (model.left) ? radius : Radius.zero,
                right: (model.right) ? radius : Radius.zero),
            shape: BoxShape.rectangle
        );
      if (model.today)
        return BoxDecoration(
            color: Token.supernodeDhx.color,
            shape: BoxShape.circle
        );
      return BoxDecoration();
    }

    return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      (model.unbondAmount > 0)
          ? Row(children: [Image.asset(AppImages.iconUnbond, scale: 1.5, color: Colors.red), Text('${model.unbondAmount}', style: kMiddleFontOfBlack)])
          : SizedBox(),
      (model.left)
          ? Text(FlutterI18n.translate(context, 'cool_off'), style: kSmallFontOfDhxColor)
          : SizedBox(),
      Container(
          height: 25,
          width: double.infinity,
          decoration: getDecoration(),
          child: Center(child: Text('${model.day}', style: (model.today) ? kMiddleFontOfWhite : kMiddleFontOfBlack))),
      Text(
          ((model.minedAmount > 0) ? '+${model.minedAmount}' : '') +
              ((model.today) ? FlutterI18n.translate(context, 'today') : ''),
          style: kSmallFontOfBlack),
      Divider(thickness: 2),
    ]);
  }
}