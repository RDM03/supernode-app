import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/paragraph.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/page/subtitle.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    WithdrawState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  if (state.confirmTime != null)
    return withdrawConfirm(state, dispatch, viewService);

  return pageFrame(context: viewService.context, children: [
    pageNavBar(FlutterI18n.translate(_ctx, 'withdraw'),
        onTap: () => Navigator.pop(viewService.context, state.status)),
    subtitle(FlutterI18n.translate(_ctx, 'current_balance')),
    paragraph('${Tools.priceFormat(state.balance)} MXC'),
    Form(
      // autovalidate: true,
      key: state.formKey,
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: TextFieldWithTitle(
            title: FlutterI18n.translate(_ctx, 'withdraw_amount'),
            textInputAction: TextInputAction.next,
            validator: (value) =>
                _onValidAmount(_ctx, value, state.fee, state.balance),
            controller: state.amountCtl,
          ),
        ),
        smallColumnSpacer(),
        textfieldWithButton(
            //readOnly: true,
            inputLabel: FlutterI18n.translate(_ctx, 'to'),
            buttonLabel: FlutterI18n.translate(_ctx, 'qr_scan'),
            icon: Icons.center_focus_weak,
            // validator: _onValidAddress,
            controller: state.addressCtl,
            onTap: () => dispatch(WithdrawActionCreator.onQrScan())),
      ]),
    ),
    subtitle(FlutterI18n.translate(_ctx, 'current_transaction_fee')),
    paragraph('${state.fee ?? '--'} MXC'),
    SizedBox(height: 40),
    Container(
      child: Text(
        FlutterI18n.translate(_ctx, '24hours_warning'),
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.w400,
          fontSize: 12,
        ),
      ),
    ),
    submitButton(
      FlutterI18n.translate(_ctx, 'submit_request'),
      onPressed: () => dispatch(WithdrawActionCreator.goToConfirmation()),
      key: ValueKey('preconfirmationButton'),
    ),
  ]);
}

Widget withdrawConfirm(
    WithdrawState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;

  return pageFrame(
    context: viewService.context,
    children: [
      pageNavBar(FlutterI18n.translate(_ctx, 'withdraw'),
          onTap: () => Navigator.pop(viewService.context, state.status)),
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
              Text(state.amountCtl.text + ' MXC'),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'fee') + ':'),
              Text(state.fee.toString() + ' MXC'),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(FlutterI18n.translate(_ctx, 'recepient') + ':'),
              Text(state.addressCtl.text),
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

String _onValidAmount(
    BuildContext context, String value, double fee, double balance) {
  String res = Reg.isEmpty(value);
  if (res != null) return FlutterI18n.translate(context, res);

  final amount = int.tryParse(value);

  if (amount == null || amount <= 0) {
    return FlutterI18n.translate(context, 'reg_amount');
  }

  if (amount + fee > balance) {
    return FlutterI18n.translate(context, 'insufficient_balance');
  }

  return null;
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
