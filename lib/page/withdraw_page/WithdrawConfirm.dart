import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/cubit.dart';
import 'package:supernodeapp/page/withdraw_page/bloc/state.dart';
import 'package:supernodeapp/theme/font.dart';

class WithdrawConfirm extends StatelessWidget {
  final String feeCurrency;

  WithdrawConfirm(this.feeCurrency);

  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      children: [
        pageNavBar(
            FlutterI18n.translate(context, 'withdraw'),
            onTap: () => Navigator.pop(context),
            leadingWidget: GestureDetector(
                key: ValueKey('navBackButton'),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onTap: () => context.read<WithdrawCubit>().backToForm()
            )
        ),
        xbigColumnSpacer(),
        Center(
          child: Text(
            FlutterI18n.translate(context, 'confirm_withdrawal'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        middleColumnSpacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              FlutterI18n.translate(context, 'check_recipient_address'),
              textAlign: TextAlign.center,
              style: kMiddleFontOfBlack,
            ),
          ),
        ),
        xbigColumnSpacer(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(FlutterI18n.translate(context, 'amount')),
                BlocBuilder<WithdrawCubit, WithdrawState>(
                    buildWhen: (a, b) => a.amount != b.amount,
                    builder: (ctx, st) => Text('${st.amount} ${st.token.name}', style: kBigFontOfBlack)),
              ],
            ),
            middleColumnSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(FlutterI18n.translate(context, 'fee')),
                BlocBuilder<WithdrawCubit, WithdrawState>(
                    buildWhen: (a, b) => a.fee != b.fee,
                    builder: (ctx, st) => Text('${st.fee} $feeCurrency', style: kBigFontOfBlack)),
              ],
            ),
            middleColumnSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(FlutterI18n.translate(context, 'recipient')),
                BlocBuilder<WithdrawCubit, WithdrawState>(
                    buildWhen: (a, b) => a.address != b.address,
                    builder: (ctx, st) => Text(st.address, style: kBigFontOfBlack)),
              ],
            ),
          ],
        ),
        xbigColumnSpacer(),
        BlocBuilder<WithdrawCubit, WithdrawState>(
          buildWhen: (a, b) => a.amount != b.amount,
          builder: (ctx, st) => StreamBuilder<Duration>(
            stream: timeLeftStream(st.confirmTime),
            builder: (ctx, snap) {
              if (snap.data == null) return Container();
              final dur = snap.data;
              if (dur.isNegative) {
                return context.read<WithdrawCubit>().state.isEnabled
                    ? PrimaryButton(
                  minWidth: double.infinity,
                  buttonTitle: FlutterI18n.translate(context, 'submit_request'),
                  onTap: () => context.read<WithdrawCubit>().gotoWithdrawSecurityCode(),
                  bgColor: st.token.color,
                  key: ValueKey('submitButton'),
                )
                    : PrimaryButton(
                  minWidth: double.infinity,
                  buttonTitle: FlutterI18n.translate(context, 'required_2FA'),
                  onTap: () => Navigator.pushNamed(context, 'set_2fa_page', arguments: {'isEnabled': null}).then((_) {
                    context.read<WithdrawCubit>().requestTOTPStatus();
                  }),
                  bgColor: st.token.color,
                  key: ValueKey('2faButton'),
                );
              }
              return PrimaryButton(
                minWidth: double.infinity,
                buttonTitle: FlutterI18n.translate(context, 'submit') + ' (${dur.inSeconds})',
                onTap: () => 'doNothing',
                bgColor: st.token.color,
                key: ValueKey('submitButtonTimeout'),
              );
            },
          ),
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
}