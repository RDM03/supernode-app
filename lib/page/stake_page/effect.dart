import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/daos/stake_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';
import 'action.dart';
import 'state.dart';

Effect<StakeState> buildEffect() {
  return combineEffects(<Object, Effect<StakeState>>{
    StakeAction.onConfirm: _onConfirm,
  });
}

void _onConfirm(Action action, Context<StakeState> ctx) {
  // Navigator.pushNamed(ctx.context, 'confirm_page');

  var curState = ctx.state;

  if((curState.formKey.currentState as FormState).validate()){
    // List<OrganizationsState> organizationsData = curState.organizations;
    String orgId = GlobalStore.store.getState().settings.selectedOrganizationId;
    int amount = int.parse(curState.amountCtl.text);
    
    StakeDao dao = StakeDao();

    Map data = {
      "orgId": orgId,
      "amount": amount
    };

    void resultPage(String type,dynamic res){
      if(res.containsKey('status')){
        Navigator.pushNamed(ctx.context, 'confirm_page',arguments:{'title': type,'content': res['status']});
        
        ctx.dispatch(StakeActionCreator.resSuccess(res['status'].contains('successful')));
      }else{
        tip(ctx.context,res);
      }
    }

    if(curState.type == 'stake'){
      dao.stake(data).then((res) async{
        log(curState.type,res);
        resultPage('stake',res);
      }).catchError((err){
        tip(ctx.context,'StakeDao stake: $err');
      });
    }else{
      dao.unstake(data).then((res) async{
        log(curState.type,res);
        resultPage('unstake',res);
      }).catchError((err){
        tip(ctx.context,'StakeDao stake: $err');
      });
    }
  }
}
