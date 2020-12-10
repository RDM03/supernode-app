import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/images.dart';
import 'package:supernodeapp/configs/sys.dart';
import 'package:supernodeapp/page/lock_page/mining_info.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'state.dart';

Widget buildView(LockState state, Dispatch dispatch, ViewService viewService) {
  var context = viewService.context;

  return Scaffold(
    key: state.scaffoldKey,
    body: SafeArea(
      child: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 235, 239, 242),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: GestureDetector(
                    key: Key('backButton'),
                    child: Icon(Icons.arrow_back_ios),
                    onTap: () => Navigator.of(context).pop(),
                  ),
                ),
                Expanded(
                  child: Text(
                    FlutterI18n.translate(context, 'lock_mxc'),
                    style: kBigFontOfBlack,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
              ],
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: FlutterI18n.translate(context, 'lock_tip'),
                    style: kMiddleFontOfGrey,
                  ),
                  WidgetSpan(
                    child: SizedBox(width: 10),
                  ),
                  TextSpan(
                      text: FlutterI18n.translate(context, 'learn_more'),
                      style: kMiddleFontOfBlueLink,
                      recognizer: TapGestureRecognizer()
                      // ..onTap = () =>
                      //     _showBottomSheet(state.scaffoldKey.currentState),
                      ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Text(FlutterI18n.translate(context, 'dhx_lock'),
                    style: kBigFontOfBlack),
                GestureDetector(
                  onTap: () => _showInfoDialog(context),
                  child: Padding(
                    key: Key("questionCircle"),
                    padding: EdgeInsets.all(s(5)),
                    child: Image.asset(AppImages.questionCircle, height: s(20)),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _lockCard(
                    key: ValueKey('lock24'),
                    state: state,
                    context: context,
                    dispatch: dispatch,
                    months: 24,
                    color: lock24Color,
                    boostText: state.boost24m == null
                        ? null
                        : '+${round(state.boost24m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    first: true,
                    boostRate: state.boost24m,
                  ),
                  _lockCard(
                    key: ValueKey('lock12'),
                    state: state,
                    context: context,
                    months: 12,
                    color: lock12Color,
                    boostText: state.boost12m == null
                        ? null
                        : '${round(state.boost12m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    boostRate: state.boost12m,
                  ),
                  _lockCard(
                    key: ValueKey('lock9'),
                    state: state,
                    context: context,
                    months: 9,
                    color: lock9Color,
                    boostText: state.boost9m == null
                        ? null
                        : '${round(state.boost9m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    boostRate: state.boost9m,
                  ),
                  _lockCard(
                    key: ValueKey('lock3'),
                    state: state,
                    context: context,
                    months: 3,
                    color: lock3Color,
                    boostText: state.boost3m == null
                        ? null
                        : '${round(state.boost3m)}% ' +
                            FlutterI18n.translate(context, 'mining_boost'),
                    boostRate: state.boost3m,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

void _showInfoDialog(BuildContext context) {
  showInfoDialog(
    context,
    IosStyleBottomDialog2(
      context: context,
      child: Column(
        children: [
          Image.asset(AppImages.infoMXCVault, height: s(80)),
          Padding(
            key: Key('helpText'),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              FlutterI18n.translate(context, 'info_mxc_vault'),
              style: TextStyle(
                color: Colors.black,
                fontSize: s(16),
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

// TODO
// void _showBottomSheet(ScaffoldState scaffoldState) {
//   scaffoldState.showBottomSheet(
//     (ctx) => Padding(
//       padding: EdgeInsets.only(
//         left: 20,
//         right: 20,
//         top: 50,
//       ),
//       child: Container(
//         color: Colors.white,
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           children: [
//             Expanded(
//               child: DhxMiningInfo(),
//             )
//           ],
//         ),
//       ),
//     ),
//     backgroundColor: Colors.black.withOpacity(0.8),
//   );
// }

int round(double v) {
  return (v * 100).round();
}

Widget _lockCard({
  BuildContext context,
  LockState state,
  int months,
  Color color,
  String boostText,
  double boostRate,
  bool first = false,
  Dispatch dispatch,
  Key key,
}) {
  return panelFrame(
    rowTop: first ? EdgeInsets.only(top: 10) : null,
    child: ListTile(
      key: key,
      onTap: () async {
        if (boostRate == null) return;
        await Navigator.of(context).pushNamed('prepare_lock_page', arguments: {
          'isDemo': state.isDemo,
          'balance': state.balance,
          'months': months,
          'boostRate': boostRate,
          'iconColor': color,
        });
      },
      leading: Container(
        height: 44,
        width: 44,
        alignment: Alignment.center,
        child: Text(
          months?.toString() ?? '~',
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
        ),
        padding: EdgeInsets.only(top: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
      title: Text(
        FlutterI18n.translate(context, 'dhx_month_lock')
            .replaceFirst('{0}', months.toString()),
      ),
      subtitle: Text(
        boostText == null ? '...' : boostText,
        style: kMiddleFontOfBlack.copyWith(
          color: Color(0xFF1C1478),
          fontWeight: FontWeight.w600,
        ),
        key: Key('setBoost'),
      ),
    ),
  );
}
