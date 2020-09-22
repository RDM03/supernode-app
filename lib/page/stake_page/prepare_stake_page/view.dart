import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PrepareStakeState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return GestureDetector(
    onTap: () => FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
      context: viewService.context,
      children: [
        pageNavBar(FlutterI18n.translate(_ctx, 'stake'),
            onTap: () => Navigator.pop(viewService.context, {'result': state.resSuccess,'balance': state.balance})),
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
                    state.stakeName ??
                        FlutterI18n.translate(_ctx, 'x_month_stake')
                            .replaceFirst('{0}', state.months.toString()),
                    textAlign: TextAlign.left,
                    style: kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    state.months == null
                        ? FlutterI18n.translate(_ctx, 'staking_trade_tip_regular')
                        : (FlutterI18n.translate(
                                _ctx,
                                state.marketingBoost <= 0
                                    ? 'staking_trade_tip_2_ver2'
                                    : 'staking_trade_tip_2')
                            .replaceFirst('{0}', state.marketingBoost.toString())
                            .replaceFirst('{1}', state.months.toString())),
                    textAlign: TextAlign.left,
                    style: kMiddleFontOfGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              Text(
                FlutterI18n.translate(_ctx, 'estimated_rate'),
                style: kSmallFontOfGrey.copyWith(
                  color: Color(0xFF1C1478),
                ),
              ),
              SizedBox(height: 2),
              Text(
                '+${state.estimatedRate}%',
                style: kBigFontOfDarkBlue.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 3),
              Text(
                FlutterI18n.translate(_ctx, 'boost_formula')
                    .replaceFirst('{0}', state.boostRate.toString()),
                style: kSmallFontOfGrey,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        SizedBox(height: 40),
        Row(
          children: [
            _infoCircle(FlutterI18n.translate(_ctx, 'stake_now'),
                _dateFmt(DateTime.now())),
            Expanded(
              child: Container(
                height: 2,
                color: Color(0xFFEBEFF2),
              ),
            ),
            _infoCircle(FlutterI18n.translate(_ctx, 'gains_start'),
                _dateFmt(DateTime.now())),
            Expanded(
              child: Container(
                height: 2,
                color: Color(0xFFEBEFF2),
              ),
            ),
            _infoCircle(
              FlutterI18n.translate(_ctx, 'gains_stop'),
              state.months == null
                  ? FlutterI18n.translate(_ctx, 'flex')
                  : _dateFmt(state.endDate, true),
            ),
            Expanded(
              child: Container(
                height: 2,
                color: Color(0xFFEBEFF2),
              ),
            ),
            _infoCircle(
              FlutterI18n.translate(_ctx, 'liquidate'),
              state.months == null
                  ? FlutterI18n.translate(_ctx, 'flex')
                  : _dateFmt(state.endDate, true),
            ),
          ],
        ),
        Form(
          key: state.formKey,
          child: Container(
            margin: const EdgeInsets.only(top: 40),
            child: TextFieldWithTitle(
              title: FlutterI18n.translate(_ctx, 'stake_amount'),
              keyboardType: TextInputType.number,
              validator: (value) => onValidAmount(_ctx, value, state.balance),
              controller: state.amountCtl,
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Text(
                FlutterI18n.translate(_ctx, 'current_balance'),
                style: kSmallFontOfGrey,
              ),
            ),
            Text(Tools.priceFormat(state.balance,range: 2) + ' MXC'),
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
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: state.amountCtl,
                  builder: (ctx, val, _) {
                    var parcedVal = double.tryParse(val.text);
                    var percent = 0.0;
                    if (parcedVal != null) {
                      percent = parcedVal / state.balance;
                      if (percent > 1) percent = 1;
                    }
                    return Slider(
                      value: percent,
                      activeColor: Color(0xFF1C1478),
                      inactiveColor: Color(0xFF1C1478).withOpacity(0.2),
                      onChanged: (v) {
                        final balanceVal =
                            (state.balance * v * 100).floorToDouble() / 100;
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
        SizedBox(
          height: 30,
        ),
        submitButton(submitText(_ctx, state),
            onPressed: () => dispatch(PrepareStakeActionCreator.onConfirm()))
      ],
    )
  );
}

String _dateFmt(DateTime date, [bool withYear = false]) {
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final year = date.year.toString().substring(2);
  var str = '$month-$day';
  if (withYear) str += '-$year';
  return str;
}

_infoCircle(String text, String date) {
  return Container(
    width: 60,
    child: Column(
      children: [
        Text(
          text,
          style: kSmallFontOfBlack,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 14),
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Color(0xFF1C1478),
              width: 3,
            ),
          ),
        ),
        SizedBox(height: 14),
        Text(
          date,
          style: kSmallFontOfGrey,
        ),
      ],
    ),
  );
}

String submitText(BuildContext ctx, PrepareStakeState state) {
  return FlutterI18n.translate(ctx, 'confirm_stake');
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
