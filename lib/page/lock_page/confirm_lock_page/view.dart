import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ConfirmLockState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('lockAmountView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
      context: viewService.context,
      scaffoldKey: state.scaffoldKey,
      children: [
        pageNavBar(FlutterI18n.translate(context, 'dhx_mining')),
        SizedBox(height: 35),
        SizedBox(
          width: double.infinity,
          child: Text(
            FlutterI18n.translate(context, 'mining'),
            style: kPrimaryBigFontOfBlack,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          width: double.infinity,
          child: Text(
            FlutterI18n.translate(context, 'mining_confirm_tip')
              ..replaceAll('{0}', '24'),
            style: kMiddleFontOfGrey,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'mining_start_date')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '2020-01-01'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'mining_end_date')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '2022-01-01'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'amount')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '1234567 MXC'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(),
        SizedBox(height: 10),
        Text(
          FlutterI18n.translate(context, 'mining_boost'),
          style: kPrimaryBigFontOfBlack,
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'mining_duration')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '24 Month'),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '40 %'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'miner_owner')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '1'),
                textAlign: TextAlign.right,
              ),
            ),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, '100 %'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Text(FlutterI18n.translate(context, 'council')),
            Expanded(
              child: Text(
                FlutterI18n.translate(context, 'Council Name'),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        SizedBox(height: 35),
        Row(
          children: [
            Text(
              FlutterI18n.translate(context, 'potential_m_power'),
              style: kBigFontOfBlack,
            ),
            SizedBox(width: 30),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Color(0x4665EA).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  '1500 Mil mPower',
                  style: kMiddleFontOfBlack,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text(
              FlutterI18n.translate(context, 'avg_dhx_daily_revenue'),
              style: kBigFontOfBlack,
            ),
            SizedBox(width: 30),
            Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Color(0x4665EA).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Center(
                child: Text(
                  FlutterI18n.translate(context, 'coming'),
                  style: kMiddleFontOfGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        submitButton(
          FlutterI18n.translate(context, 'proceed'),
          onPressed: () => _proceed(state.scaffoldKey.currentState),
          key: ValueKey('submitButton'),
        )
      ],
    ),
  );
}

_proceed(ScaffoldState scaffoldState) {
  showCupertinoModalPopup(
    context: scaffoldState.context,
    builder: (ctx) => CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(ctx, 'dhx_mining'),
            style: kBigFontOfBlue,
          ),
          SizedBox(height: 16),
          Text(
            FlutterI18n.translate(ctx, 'lock_confirm_message')
                .replaceAll('{0}', '123123')
                .replaceAll('{1}', '24')
                .replaceAll('{2}', '1724**.com'),
            style: kMiddleFontOfBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text(
            FlutterI18n.translate(ctx, 'proceed_anyway'),
            style: kBigFontOfBlue,
          ),
          onPressed: () => Navigator.of(ctx).pushNamed('result_lock_page',
              arguments: {'isDemo': true, 'transactionId': 'txid'}),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'got_it'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ),
  );
}
