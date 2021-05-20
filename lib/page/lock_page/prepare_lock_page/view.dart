import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/utils/dhx.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PrepareLockState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return GestureDetector(
    key: Key('lockAmountView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
      context: viewService.context,
      children: [
        pageNavBar(
          FlutterI18n.translate(_ctx, 'lock_mxc'),
          leadingWidget: SizedBox(),
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
                style: Theme.of(_ctx).textTheme.bodyText1.copyWith(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              padding: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: state.iconColor,
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
                    style:
                        kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    FlutterI18n.translate(_ctx, 'lock_tip_detailed')
                        .replaceFirst(
                            '{0}', (state.boostRate * 100).toStringAsFixed(0))
                        .replaceFirst('{1}', state.months.toString()),
                    textAlign: TextAlign.left,
                    style: kMiddleFontOfGrey,
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
                  style: kBigFontOfBlack,
                ),
                Text(
                  FlutterI18n.translate(_ctx, 'current_balance'),
                  style: kSmallFontOfGrey,
                ),
              ],
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text(
                '${state.balance ?? '??'} MXC',
                textAlign: TextAlign.right,
                maxLines: 2,
                style: kBigFontOfBlack,
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
                          valueColor: AlwaysStoppedAnimation(Color(0xFF4665EA)),
                          backgroundColor: Color(0xFF4665EA).withOpacity(0.2),
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
                            activeColor: Color(0xFF4665EA),
                            inactiveColor: Color(0xFF4665EA).withOpacity(0.2),
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
                    style: kSmallFontOfGrey,
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
                  child: Text(
                    '50%',
                    style: kSmallFontOfGrey,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    '100%',
                    style: kSmallFontOfGrey,
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
              focusedBorderColor: colorSupernodeDhx,
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
                  style: kBigFontOfBlack,
                ),
                Text(
                  FlutterI18n.translate(_ctx, 'current_m2proto_own'),
                  style: kSmallFontOfGrey,
                ),
              ],
            ),
            SizedBox(width: 30),
            Expanded(
              child: Text(
                state.minersOwned?.toString() ?? '??',
                textAlign: TextAlign.right,
                maxLines: 2,
                style: kBigFontOfBlack,
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
                  style: kBigFontOfBlack,
                ),
                Text(
                  FlutterI18n.translate(_ctx, 'total_mpower'),
                  style: kSmallFontOfGrey,
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
                    style: kBigFontOfBlack,
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
                style: kBigFontOfBlack,
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
                    style: kBigFontOfBlack.copyWith(color: colorSupernodeDhx),
                  );
                },
              ),
            ),
          ],
        ),
      ],
      floatingActionButton: PrimaryButton(
        key: ValueKey('submitButton'),
        padding: kRoundRow105,
        buttonTitle: FlutterI18n.translate(_ctx, 'next'),
        bgColor: colorSupernodeDhx,
        minWidth: double.infinity,
        onTap: () => dispatch(PrepareLockActionCreator.onConfirm())
      )
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
