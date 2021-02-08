import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/server_info.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:toast/toast.dart';

import 'state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    this.supernodeRepository
  }) : super(SettingsState());//TODO initial state value

  final SupernodeRepository supernodeRepository;

  Future<void> initState() async {
  }

  ServerInfoDao _buildServerInfoDao() {
    return supernodeRepository.serverInfo;
  }

  Future<void> initAboutPage() async {
    PackageInfo.fromPlatform().then(
            (info) => emit(state.copyWith(info: info)));

    _buildServerInfoDao().appServerVersion().then(
            (info) => emit(state.copyWith(mxVersion: info.version)));
  }

  Future<void> checkForUpdate(BuildContext ctx) async {
    updateDialog(ctx).then((isLatest) {
      if (!isLatest) {
        Toast.show(FlutterI18n.translate(ctx, 'tip_latest_version'), ctx,
            duration: 5);
      }
    });
  }

  Future<void> toBeImplemented() async {
    //TODO delete
  }
}
