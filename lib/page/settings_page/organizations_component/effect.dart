import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/tip.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/organization.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/reg.dart';

import 'action.dart';
import 'state.dart';

Effect<OrganizationsState> buildEffect() {
  return combineEffects(<Object, Effect<OrganizationsState>>{
    OrganizationsAction.onUpdate: _onUpdate,
  });
}

OrganizationDao _buildOrganizationDao(Context<OrganizationsState> ctx) {
  return ctx.context.read<SupernodeRepository>().organization;
}

void _onUpdate(Action action, Context<OrganizationsState> ctx) {
  var curState = ctx.state;

  if ((curState.formKey.currentState as FormState).validate()) {
    showDialog(
        context: ctx.context,
        builder: (context) {
          return AlertDialog(
              title: Text(FlutterI18n.translate(context, 'profile_setting')),
              content: Text(
                  FlutterI18n.translate(context, 'sure_switch_organization')),
              actions: [
                FlatButton(
                  child: Text(FlutterI18n.translate(context, 'switch')),
                  onPressed: () => _updateData(ctx),
                ),
                FlatButton(
                  child: Text(FlutterI18n.translate(context, 'cancel')),
                  onPressed: () => Navigator.of(ctx.context).pop(),
                ),
              ]);
        });
  }
}

void _updateData(Context<OrganizationsState> ctx) async {
  Navigator.of(ctx.context).pop(); //exit alertlog

  var curState = ctx.state;

  String id = curState.selectedOrgId;
  String name = curState.orgNameCtl.text;
  String displayName = curState.orgDisplayCtl.text;

  if (Reg.isEmpty(id) != null) {
    tip(ctx.context, FlutterI18n.translate(ctx.context, 'select_organization'));
    return;
  }
  final loading = Loading.show(ctx.context);

  Map data = {
    "id": id,
    "organization": {
      "id": id,
      "name": name,
      "displayName": displayName,
      "canHaveGateways": true
    }
  };

  OrganizationDao dao = _buildOrganizationDao(ctx);

  dao.update(data).then((res) {
    mLog('update', res);
    loading.hide();

    tip(ctx.context, FlutterI18n.translate(ctx.context, 'update_success'),
        success: true);
    ctx.context.read<SupernodeCubit>().setOrganizationId(id);
  }).catchError((err) {
    loading.hide();
    // tip(ctx.context,'OrganizationDao update: $err');
  });
}
