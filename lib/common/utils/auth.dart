import 'package:flutter/scheduler.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/main.dart';

import 'navigator.dart';

Future<void> _pushMaintenance() async {
  if (!isCurrent(navigatorKey.currentState, 'under_maintenance_page')) {
    await navigatorKey.currentState.pushNamed('under_maintenance_page');
  }
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
