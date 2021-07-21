import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/utils/dhx.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PrepareLockState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return GestureDetector(
    key: Key('lockAmountView'),
    onTap: () =>
        FocusScope.of(viewService.context).unfocus(),
    child: pageFrame(
      context: viewService.context,
      children: [
        pageNavBar(FlutterI18n.translate(_ctx, 'dhx_mining'),
            onTap: () => Navigator.pop(viewService.context,
                {'result': state.resSuccess, 'balance': state.balance})),
        SizedBox(height: 30),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              width: 44,
              alignment: Alignment.center,
              child: Text(
                state.months == null ? '~' : state.months.toString(),
                style: FontTheme.of(_ctx).veryBig.button.bold(),
              ),
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.iconColor ?? ColorsTheme.of(_ctx).dhxBlue,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FlutterI18n.translate(_ctx, 'dhx_month_lock')
                        .replaceFirst('{0}', state.months.toString()),
                    textAlign: TextAlign.left,
                    style: FontTheme.of(_ctx)
                        .big()
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    FlutterI18n.translate(_ctx, 'lock_tip_detailed')
                        .replaceFirst(
                            '{0}', (state.boostRate * 100).toStringAsFixed(0))
                        .replaceFirst('{1}', state.months.toString()),
                    textAlign: TextAlign.left,
                    style: FontTheme.of(_ctx).middle.secondary(),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FlutterI18n.translate(_ctx, 'lock_amount'),
                  style: FontTheme.of(_ctx).big(),
                ),
                Text(
                  FlutterI18n.translate(_ctx, 'current_balance'),
                  style: FontTheme.of(_ctx).small.secondary(),
                ),
              ],
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text(
                '${state.balance ?? '??'} MXC',
                textAlign: TextAlign.right,
                maxLines: 2,
                style: FontTheme.of(_ctx).big(),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children: [
            SizedBox(
              height: 25,
              child: SliderTheme(
                data: SliderThemeData(
                  trackShape: CustomTrackShape(),
                  trackHeight: 5,
                ),
                child: state.balance == null
                    ? Center(
                        child: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            ColorsTheme.of(_ctx).dhxBlue,
                          ),
                          backgroundColor: ColorsTheme.of(_ctx).dhxBlue20,
                        ),
                      )
                    : ValueListenableBuilder<TextEditingValue>(
                        valueListenable: state.amountCtl,
                        builder: (ctx, val, _) {
                          var parcedVal = double.tryParse(val.text);
                          var percent = 0.0;
                          if (parcedVal != null) {
                            percent = parcedVal / state.balance;
                            if (percent > 1) percent = 1;
                          }
                          return Slider(
                            key: ValueKey('lockAmountSlider'),
                            value: percent,
                            activeColor: ColorsTheme.of(_ctx).dhxBlue,
                            inactiveColor: ColorsTheme.of(_ctx).dhxBlue20,
                            onChanged: (v) {
                              final balanceVal =
                                  (state.balance * v * 100).floorToDouble() /
                                      100;
                              state.amountCtl.text = balanceVal.toString();
                            },
                          );
                        },
                      ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '0%',
                    style: FontTheme.of(_ctx).small.secondary(),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    '50%',
                    style: FontTheme.of(_ctx).small.secondary(),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    '100%',
                    style: FontTheme.of(_ctx).small.secondary(),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: 16),
        Form(
          key: state.formKey,
          child: Container(
            child: PrimaryTextField(
              key: ValueKey('lockAmount'),
              keyboardType: TextInputType.number,
              validator: (value) => onValidAmount(_ctx, value, state.balance),
              controller: state.amountCtl,
              suffixText: 'MXC',
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FlutterI18n.translate(_ctx, 'number_of_miner'),
                  style: FontTheme.of(_ctx).big(),
                ),
                Text(
                  FlutterI18n.translate(_ctx, 'current_m2proto_own'),
                  style: FontTheme.of(_ctx).small.secondary(),
                ),
              ],
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text(
                state.minersOwned?.toString() ?? '??',
                textAlign: TextAlign.right,
                maxLines: 2,
                style: FontTheme.of(_ctx).big(),
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  FlutterI18n.translate(_ctx, 'potential_mining_power'),
                  style: FontTheme.of(_ctx).big(),
                ),
                Text(
                  FlutterI18n.translate(_ctx, 'total_mpower'),
                  style: FontTheme.of(_ctx).small.secondary(),
                ),
              ],
            ),
            SizedBox(width: 30),
            Expanded(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: state.amountCtl,
                builder: (ctx, val, _) {
                  final amount = double.tryParse(val.text);
                  final mPower = amount == null || state.minersOwned == null
                      ? null
                      : calculateMiningPower(amount, state.minersOwned,
                          monthsToBoost(state.months));
                  return Text(
                    '${mPower?.toStringAsFixed(0) ?? '??'} mPower',
                    key: ValueKey('mPowerText'),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: FontTheme.of(_ctx).big(),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Divider(),
        Row(
          children: [
            Expanded(
              child: Text(
                FlutterI18n.translate(_ctx, 'avg_dhx_daily_revenue'),
                style: FontTheme.of(_ctx).big(),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: state.amountCtl,
                builder: (ctx, val, _) {
                  final amount = double.tryParse(val.text);
                  final dailyReturn = calculateDhxDaily(
                    minersCount: state.minersOwned,
                    months: state.months,
                    mxcLocked: amount,
                    yesterdayTotalDHX: state.yesterdayTotalDHX,
                    yesterdayTotalMPower: state.yesterdayTotalMPower,
                  );
                  return Text(
                    (dailyReturn == null || dailyReturn.isNaN
                        ? '??'
                        : '${Tools.priceFormat(dailyReturn, range: 2)} DHX'),
                    key: ValueKey('dailyReturnText'),
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    style: FontTheme.of(_ctx).big(),
                  );
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        submitButton(
          FlutterI18n.translate(_ctx, 'next'),
          onPressed: () => dispatch(PrepareLockActionCreator.onConfirm()),
          key: ValueKey('submitButton'),
        )
      ],
    ),
  );
}

String onValidAmount(BuildContext context, String value, double balance) {
  String res = Reg.isEmpty(value);
  if (res != null) return FlutterI18n.translate(context, res);

  final parsed = double.tryParse(value);
  if (parsed <= 0) {
    return FlutterI18n.translate(context, 'reg_amount');
  }

  if (parsed > balance) {
    return FlutterI18n.translate(context, 'insufficient_balance');
  }

  return null;
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
