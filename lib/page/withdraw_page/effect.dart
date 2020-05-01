import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/withdraw_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/theme/colors.dart';
// import 'package:qrscan/qrscan.dart' as Scanner;

import 'action.dart';
import 'state.dart';

Effect<WithdrawState> buildEffect() {
  return combineEffects(<Object, Effect<WithdrawState>>{
    WithdrawAction.onQrScan: _onQrScan,
    WithdrawAction.onSubmit: _onSubmit,
  });
}

void _onQrScan(Action action, Context<WithdrawState> ctx) async{
  String qrResult = await MajaScan.startScan(
    title: FlutterI18n.translate(ctx.context, 'scan_code'), 
    barColor: buttonPrimaryColor, 
    titleColor: backgroundColor, 
    qRCornerColor: buttonPrimaryColor,
    qRScannerColor: buttonPrimaryColorAccent
  );
  log('_onQrScan', qrResult);
  ctx.dispatch(WithdrawActionCreator.address(qrResult));
  // return;

  // Navigator.push(ctx.context,
  //   MaterialPageRoute(
  //     maintainState: false,
  //     fullscreenDialog: true,
  //     builder:(context){
  //       return ctx.buildComponent('qrscan');
  //     }
  //   ),
  // ).then((res){
  //   if(res != null){
  //     ctx.dispatch(WithdrawActionCreator.address(res));
  //   }
  // });
}

void _onSubmit(Action action, Context<WithdrawState> ctx) {
  var curState = ctx.state;
  double balance = curState.balance;
  String amount = curState.amountCtl.text;
  String address = curState.addressCtl.text;
  // OrganizationsState org = curState.organizations.first;
  String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;

  if((curState.formKey.currentState as FormState).validate()){
    if(address.trim().isEmpty){
      tip(ctx.context, 'The field of "To" is required.');
      return;
    }

    WithdrawDao dao = WithdrawDao();
    Map data = {
      "orgId": orgId,
      "amount": int.parse(amount),
      "ethAddress": address,
      "availableBalance": balance
    };

    dao.withdraw(data).then((res){
      log('withdraw',res);
      if(res.containsKey('status') && res['status']){
        Navigator.pushNamed(ctx.context, 'confirm_page',arguments:{'title': 'withdraw','content': 'withdraw_submit_tip'});
      }else{
        tip(ctx.context,res);
      }
    }).catchError((err){
      tip(ctx.context,'WithdrawDao withdraw: $err');
    });
  }
}