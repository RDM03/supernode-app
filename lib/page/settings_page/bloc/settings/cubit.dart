import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/server_info.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/feedback_page/feedback.dart';
import 'package:toast/toast.dart';

import 'state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    this.appCubit,
    this.supernodeRepository
  }) : super(SettingsState(screenShot: false));//TODO initial state value

  final AppCubit appCubit;
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

  void _rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  Future<void> updateLanguage(String language, BuildContext context) async {
    if (language == state.language) {
      return;
    }

    final locale = language == 'auto' ? Localizations.localeOf(context) : Locale(language);
    await FlutterI18n.refresh(context, locale);

    appCubit.setLocale(locale);

    _rebuildAllChildren(context);

    emit(state.copyWith(language: language));
  }

  void setScreenShot(bool value) {
    emit(state.copyWith(screenShot: value));
  }

  Future<void> toBeImplemented() async {
    //TODO delete
  }
}
