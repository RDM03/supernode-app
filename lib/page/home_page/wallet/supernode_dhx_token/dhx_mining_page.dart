import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/time.dart';
import 'package:supernodeapp/common/utils/tools.dart';
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
  final ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollCtrl.addListener(() {
      ScrollPosition position = scrollCtrl.positions.last;
      if (position.pixels + 300 > position.maxScrollExtent) {
        if (!mounted) return;
        context.read<SupernodeDhxCubit>().getBondInfo();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAppBar(
        title: FlutterI18n.translate(context, 'dhx_mining'),
        onPress: () => Navigator.pop(context),
      ),
      backgroundColor: backgroundColor,
      body: PageBody(
        children: [
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
              child: Container(
                height: 600,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: SingleChildScrollView(
                    controller: scrollCtrl,
                    reverse: true,
                    child: BlocBuilder<SupernodeDhxCubit, SupernodeDhxState>(
                        buildWhen: (a, b) => a.calendarInfo != b.calendarInfo,
                        builder: (context, state) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: calendar(context, state.calendarInfo)))),
              )),
        ]));
  }
}

List<Widget> calendar(
    BuildContext context, Map<String, List<CalendarModel>> calendarInfo) {
  List<Widget> calendarList = [];

  calendarInfo.forEach((key, items) {
    calendarList.add(Flex(
      direction: Axis.horizontal,
      children: [
        Text('  ${TimeUtil.getMYAbb(context, items.first.date, withApostrophe: true)}',
            style: kPrimaryBigFontOfBlack),
        Expanded(
            child: Text(
          countTotalMonth(items),
          style: kBigFontOfBlue.copyWith(fontSize: 20),
          textAlign: TextAlign.right,
        )),
        SizedBox(
          width: 10,
        )
      ],
    ));

    calendarList.add(GridView.count(
      crossAxisCount: 7,
      childAspectRatio: (1 / 2),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: getCalendar(items),
    ));
  });

  calendarList.add(smallColumnSpacer());
  calendarList.add(Text(FlutterI18n.translate(context, 'bonding_calendar_note'),
      style: kSmallFontOfBlack));

  return calendarList;
}

String countTotalMonth(List<CalendarModel> calendarList) {
  double total = calendarList.fold(
      0, (previousValue, item) => previousValue + item.minedAmount);

  return '+${Tools.priceFormat(total)} DHX / month';
}

List<Widget> getCalendar(List<CalendarModel> calendarList) {
  int filledItemNum = calendarList.first.date.weekday;
  List<CalendarModel> list = [];

  if(filledItemNum != 7){
    for (int i = 0; i < filledItemNum; i++) {
      list.insert(0, CalendarModel(date: null));
    }
  }

  for (int i = 0; i < calendarList.length; i++) {
    list.add(calendarList[i]);
  }
  return list.map((e) => _CalendarElement(e)).toList();
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
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Visibility(
              visible: model.unbondAmount > 0,
              child: Image.asset(AppImages.iconUnbond,
                width: 14,
                color: Colors.red),
            ),
            Text(
                '${model.date != null ? (7 - today.difference(model.date).inDays) : ""}',
                style: (model.unbondAmount > 0)
                    ? kMiddleFontOfBlack
                    : kMiddleFontOfWhite,
                softWrap: false,
                overflow: TextOverflow.fade)
          ]),
          Container(
              height: 25,
              width: double.infinity,
              decoration: getDecoration(),
              child: Center(
                  child: Text('${model.date != null ? model.date.day : ''}',
                      style: (model.today)
                          ? kMiddleFontOfWhite
                          : kMiddleFontOfBlack,
                      softWrap: false,
                      overflow: TextOverflow.fade))),
          Text(
              ((model.minedAmount > 0 && model.date != null)
                      ? '+${Tools.priceFormat(model.minedAmount, range: Tools.max3DecimalPlaces(model.minedAmount))}'
                      : '') +
                  ((model.today)
                      ? FlutterI18n.translate(context, 'today')
                      : ''),
              style: kSmallFontOfBlack,
              softWrap: false,
              overflow: TextOverflow.fade),
          model.date != null ? Divider(thickness: 1) : Container(),
        ]);
  }
}
