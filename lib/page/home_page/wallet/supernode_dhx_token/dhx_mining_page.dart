import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/cubit.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/dhx/state.dart';
import 'package:supernodeapp/page/home_page/wallet/supernode_dhx_token/page_content.dart';
import 'package:supernodeapp/page/home_page/wallet/token_card.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

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
            whiteCircle(
              child:
                  Icon(Icons.circle, color: Token.supernodeDhx.color, size: 12),
            ),
            Text(FlutterI18n.translate(context, "today"),
                style: kSmallFontOfBlack),
            Spacer(),
            whiteCircle(
              child: Icon(Icons.circle,
                  color: Token.supernodeDhx.color.withOpacity(0.2), size: 12),
            ),
            Text(FlutterI18n.translate(context, 'cool_off'),
                style: kSmallFontOfBlack),
            Spacer(),
            whiteCircle(
              child: Image.asset(AppImages.iconUnbond,
                  scale: 2.2, color: Colors.red),
            ),
            Text(FlutterI18n.translate(context, 'unbonded'),
                style: kSmallFontOfBlack)
          ]),
          smallColumnSpacer(),
          PanelFrame(
            margin: const EdgeInsets.all(0.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                    buildWhen: (a, b) =>
                        a.calendarBondInfo != b.calendarBondInfo,
                    builder: (context, state) => (state.calendarBondInfo !=
                                null &&
                            state.calendarBondInfo.length > 0)
                        ? Padding(
                            padding: kOuterRowTop5,
                            child: Text(
                                '   ${Tools.dateMonthYearFormat(state.calendarBondInfo[0].date)}'
                                '${(state.calendarBondInfo[0].date.month != state.calendarBondInfo[state.calendarBondInfo.length - 1].date.month) ? ' - ' + Tools.dateMonthYearFormat(state.calendarBondInfo[state.calendarBondInfo.length - 1].date) : ''}',
                                style: kPrimaryBigFontOfBlack))
                        : SizedBox(),
                  ),
                  smallColumnSpacer(),
                  BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                    buildWhen: (a, b) =>
                        a.calendarBondInfo != b.calendarBondInfo,
                    builder: (context, state) => GridView.count(
                      crossAxisCount: 7,
                      childAspectRatio: (1 / 2),
                      shrinkWrap: true,
                      children: state.calendarBondInfo
                          .map((e) => _CalendarElement(e))
                          .toList(),
                    ),
                  ),
                  Divider(thickness: 2),
                  smallColumnSpacer(),
                  Text(FlutterI18n.translate(context, 'bonding_calendar_note'),
                      style: kSmallFontOfBlack),
                ],
              ),
            ),
          ),
          middleColumnSpacer(),
        ]));
  }

  Widget whiteCircle({Widget child}) {
    return Container(
        width: 14,
        height: 14,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: child);
  }
}

class _CalendarElement extends StatelessWidget {
  final CalendarModel model;

  _CalendarElement(this.model);

  @override
  Widget build(BuildContext context) {
    final Radius radius = Radius.circular(12);
    DateTime today = DateTime.now();
    today = DateTime.utc(today.year, today.month, today.day);

    BoxDecoration getDecoration() {
      if (model.today)
        return BoxDecoration(
            color: Token.supernodeDhx.color, shape: BoxShape.circle);
      if (model.left || model.right || model.middle)
        return BoxDecoration(
            color: Token.supernodeDhx.color.withOpacity(0.2),
            borderRadius: BorderRadius.horizontal(
                left: (model.left) ? radius : Radius.zero,
                right: (model.right) ? radius : Radius.zero),
            shape: BoxShape.rectangle);
      return BoxDecoration();
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(thickness: 2),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(AppImages.iconUnbond,
                scale: 1.5,
                color: (model.unbondAmount > 0) ? Colors.red : Colors.white),
            Text('${7 - today.difference(model.date).inDays}',
                style: (model.unbondAmount > 0)
                    ? kMiddleFontOfBlack
                    : kMiddleFontOfWhite)
          ]),
          Container(
              height: 25,
              width: double.infinity,
              decoration: getDecoration(),
              child: Center(
                  child: Text('${model.date.day}',
                      style: (model.today)
                          ? kMiddleFontOfWhite
                          : kMiddleFontOfBlack))),
          Text(
              ((model.minedAmount > 0)
                      ? '+${Tools.priceFormat(model.minedAmount, range: Tools.max3DecimalPlaces(model.minedAmount))}'
                      : '') +
                  ((model.today)
                      ? FlutterI18n.translate(context, 'today')
                      : ''),
              style: kSmallFontOfBlack),
        ]);
  }
}
