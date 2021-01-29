import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/theme/font.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    ConfirmState state, Dispatch dispatch, ViewService viewService) {
  return withdrawConfirm(state, dispatch, viewService);
}

Widget withdrawConfirm(
    ConfirmState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(FlutterI18n.translate(_ctx, 'withdraw'),
          onTap: () => Navigator.pop(viewService.context)),
      SizedBox(height: 40),
      Center(
        child: Text(
          FlutterI18n.translate(_ctx, 'confirm_withdrawal'),
          textAlign: TextAlign.center,
          style: Theme.of(_ctx).textTheme.headline6,
        ),
      ),
      SizedBox(height: 7),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: Text(
            FlutterI18n.translate(_ctx, 'check_recipient_address'),
            textAlign: TextAlign.center,
            style: kSmallFontOfGrey,
          ),
        ),
      ),
      SizedBox(height: 40),
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'amount') + ':'),
              Text('${state.amount} ${state.tokenName}'),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'fee') + ':'),
              Text(state.fee + ' MXC'),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'recepient') + ':'),
              Text(state.address),
            ],
          ),
        ],
      ),
      StreamBuilder<Duration>(
        stream: timeLeftStream(state.confirmTime),
        builder: (ctx, snap) {
          if (snap.data == null) return Container();
          final dur = snap.data;
          if (dur.isNegative) {
            return state.isEnabled
                ? submitButton(
                    FlutterI18n.translate(_ctx, 'submit_request'),
                    onPressed: () => dispatch(WithdrawActionCreator
                        .onEnterSecurityWithdrawContinue()),
                    key: ValueKey('submitButton'),
                  )
                : submitButton(
                    FlutterI18n.translate(_ctx, 'required_2FA'),
                    onPressed: () =>
                        dispatch(WithdrawActionCreator.onGotoSet2FA()),
                    key: ValueKey('2faButton'),
                  );
          }
          return submitButton(
            FlutterI18n.translate(_ctx, 'submit') + ' (${dur.inSeconds})',
            key: ValueKey('submitButtonTimeout'),
            onPressed: null,
          );
        },
      ),
    ],
  );
}

Stream<Duration> timeLeftStream(DateTime time) async* {
  Duration difference() => time?.difference(DateTime.now());
  final stream = Stream.periodic(Duration(seconds: 1)).map((_) => difference());
  final diff = difference();
  if (diff == null) {
    yield null;
  } else {
    yield difference();
    yield* stream;
  }
}
