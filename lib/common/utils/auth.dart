import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/main.dart';
import 'package:supernodeapp/page/login_page/view.dart';
import 'package:supernodeapp/route.dart';
import 'dart:convert';

import 'navigator.dart';

Future<void> _pushMaintenance() async {
  if (!isCurrent(navigatorKey.currentState, 'under_maintenance_page')) {
    await navigatorKey.currentState.pushNamed('under_maintenance_page');
  }
}

SupernodeJwt parseJwt(String jwt) {
  if (jwt == null) return null;
  final splitted = jwt.split('.');
  if (splitted.length < 2) return null;
  var encoded = splitted[1];

  // need to add tail, otherwise base64 throws.
  switch (encoded.length % 4) {
    case 1:
      break;
    case 2:
      encoded += "==";
      break;
    case 3:
      encoded += "=";
      break;
  }
  final json = utf8.decode(base64.decode(encoded));
  return SupernodeJwt.fromJson(json);
}

Future<void> logOut(BuildContext context) async {
  context.read<SupernodeCubit>().logout();
  Navigator.of(context)
      .pushAndRemoveUntil(route((_) => LoginPage()), (route) => false);
}

Future<bool> checkMaintenance(Supernode node) async {
  if (node == null) return true;
  if (node.status == 'maintenance') {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _pushMaintenance();
      });
    } else {
      await _pushMaintenance();
    }
    return false;
  } else if (node.status == 'online') {
    print('node online');
  } else if (node.status == null) {
    print('node status not set');
  } else {
    print('node status unknown');
  }
  return true;
}
