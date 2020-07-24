import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/security/biometrics.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/users_dao.dart';
import 'package:supernodeapp/common/daos/wallet_dao.dart';
import 'package:supernodeapp/common/daos/withdraw_dao.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'action.dart';
import 'state.dart';

Effect<WithdrawState> buildEffect() {
  return combineEffects(<Object, Effect<WithdrawState>>{
    Lifecycle.initState: _initState,
    WithdrawAction.onQrScan: _onQrScan,
    WithdrawAction.onEnterSecurityWithdrawContinue: _onEnterSecurityWithdrawContinue,
    WithdrawAction.onGotoSet2FA: _onGotoSet2FA,
    WithdrawAction.onSubmit: _onSubmit,
  });
}

void _initState(Action action, Context<WithdrawState> ctx) async{
  // Future.delayed(Duration(seconds: 3),() async{
    await _withdrawFee(ctx);
    await _requestTOTPStatus(ctx);
  // });
}

Future<void> _requestTOTPStatus(Context<WithdrawState> ctx) async{
  UserDao dao = UserDao();

  Map data = {};

  try{
    var res = await dao.getTOTPStatus(data);
    mLog('totp', res);

    if ((res as Map).containsKey('enabled')) {
      ctx.dispatch(WithdrawActionCreator.isEnabled(res['enabled']));
    }
  } catch(err){
    tip(ctx.context, '$err');
  }
}

Future<void> _withdrawFee(Context<WithdrawState> ctx) async{

  try{
    WithdrawDao dao = WithdrawDao();
    var res = await dao.fee();
    mLog('WithdrawDao fee', res);

    if ((res as Map).containsKey('withdrawFee')) {
      ctx.dispatch(WithdrawActionCreator.fee(Tools.convertDouble(res['withdrawFee'])));
    }
  } catch(err){
    tip(ctx.context, 'WithdrawDao fee: $err');
  }
  
}

void _onQrScan(Action action, Context<WithdrawState> ctx) async {
  String qrResult = await MajaScan.startScan(
      title: FlutterI18n.translate(ctx.context, 'scan_code'),
      barColor: buttonPrimaryColor,
      titleColor: backgroundColor,
      qRCornerColor: buttonPrimaryColor,
      qRScannerColor: buttonPrimaryColorAccent);
  mLog('_onQrScan', qrResult);
  ctx.dispatch(WithdrawActionCreator.address(qrResult));
}

void _onEnterSecurityWithdrawContinue(Action action, Context<WithdrawState> ctx) async {
  //showLoading(ctx.context);

  final formValid = (ctx.state.formKey.currentState as FormState).validate();
  if (!formValid) {
    return;
  }

  Navigator.push(
    ctx.context,
    MaterialPageRoute(
        maintainState: false,
        fullscreenDialog: false,
        builder: (context) {
          return ctx.buildComponent('enterSecurityCodeWithdraw');
        }),
  );
}

void _onGotoSet2FA(Action action, Context<WithdrawState> ctx) async {
  Navigator.pushNamed(ctx.context, 'set_2fa_page', arguments: {'isEnabled': false}).then((_) {
    _requestTOTPStatus(ctx);
  });
  //Navigator.of(viewService.context).pushNamed('set_2fa_page', arguments:{'isEnabled': false})
}

void _onSubmit(Action action, Context<WithdrawState> ctx) async {
  var curState = ctx.state;
  double balance = curState.balance;
  String amount = curState.amountCtl.text;
  String address = curState.addressCtl.text;
  // OrganizationsState org = curState.organizations.first;
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  List<String> codes = curState.listCtls.map((code) => code.text).toList();
  
  final formValid = (curState.formKey.currentState as FormState).validate();
  if (!formValid) {
    return;
  }

  if ((curState.formKey.currentState as FormState).validate()) {
    if (address.trim().isEmpty) {
      tip(ctx.context, 'The field of "To" is required.');
      return;
    }

    Biometrics.authenticate(
      ctx.context,
      authenticateCallback: () {
        WithdrawDao dao = WithdrawDao();
        Map data = {
          "orgId": orgId,
          "amount": amount,
          "ethAddress": address,
          "availableBalance": balance,
          "otp_code": codes.join('')
        };
        showLoading(ctx.context);
        dao.withdraw(data).then((res) async{
          hideLoading(ctx.context);
          mLog('withdraw', res);

          if (res.containsKey('status') && res['status']) {
            Navigator.pushNamed(ctx.context, 'confirm_page',
                arguments: {'title': 'withdraw', 'content': 'withdraw_submit_tip'});
            await _updateBalance(ctx);
            ctx.dispatch(WithdrawActionCreator.status(true));
          } else {
            ctx.dispatch(WithdrawActionCreator.status(false));
            // tip(ctx.context, res);
          }
        }).catchError((err) {
          hideLoading(ctx.context);
          ctx.dispatch(WithdrawActionCreator.status(false));
          // tip(ctx.context, 'WithdrawDao withdraw: $err');
        });
      },
    );
  }
}

Future<void> _updateBalance(Context<WithdrawState> ctx) async{
  WalletDao dao = WalletDao();
  var settingsData = GlobalStore.store.getState().settings;
  String userId = settingsData.userId;
  String orgId = settingsData.selectedOrganizationId;

  try{
     Map data = {'userId': userId, 'orgId': orgId};

    var res = await dao.balance(data);
    mLog('balance', res);

    double balance = Tools.convertDouble(res['balance']);
    ctx.dispatch(WithdrawActionCreator.balance(balance));
  }catch(err){
    // tip(ctx.context, 'WalletDao balance: $err');
  }

}
