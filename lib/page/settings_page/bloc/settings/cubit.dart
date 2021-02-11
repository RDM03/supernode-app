import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:package_info/package_info.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/update_dialog.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/server_info.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/page/home_page/bloc/supernode/user/cubit.dart';
import 'package:toast/toast.dart';

import 'state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
      {this.appCubit,
      this.supernodeUserCubit,
      this.supernodeCubit,
      this.supernodeRepository})
      : super(SettingsState(
            screenShot: false,
            showWechatUnbindConfirmation: false,
            showBindShopifyStep: 0,
            showLoading: false));

  final AppCubit appCubit;
  final SupernodeUserCubit supernodeUserCubit;
  final SupernodeCubit supernodeCubit;
  final SupernodeRepository supernodeRepository;

  Future<void> initState() async {}

  ServerInfoDao _buildServerInfoDao() {
    return supernodeRepository.serverInfo;
  }

  Future<void> initAboutPage() async {
    PackageInfo.fromPlatform().then((info) => emit(state.copyWith(info: info)));

    _buildServerInfoDao()
        .appServerVersion()
        .then((info) => emit(state.copyWith(mxVersion: info.version)));
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

    final locale =
        language == 'auto' ? Localizations.localeOf(context) : Locale(language);
    await FlutterI18n.refresh(context, locale);

    appCubit.setLocale(locale);

    _rebuildAllChildren(context);

    emit(state.copyWith(language: language));
  }

  void setScreenShot(bool value) {
    emit(state.copyWith(screenShot: value));
  }

  void onUnbind(String service) {
    emit(
        state.copyWith(showWechatUnbindConfirmation: false, showLoading: true));

    Map data = {"organizationId": supernodeCubit.state.orgId, "service": service};

    supernodeRepository.user.unbindExternalUser(data).then((res) {
      emit(state.copyWith(showLoading: false));
      if (service == ExternalUser.weChatService) {
        supernodeUserCubit.removeWeChatUser();
      } else if (service == ExternalUser.shopifyService) {
        supernodeUserCubit.removeShopifyUser();
      }
    }).catchError((err) {
      emit(state.copyWith(showLoading: false));
      //tip(ctx.context, 'Unbind: $err');
    });
  }

  void showWechatUnbindConfirmation(bool confirm) {
    emit(state.copyWith(showWechatUnbindConfirmation: confirm));
  }

  void bindShopifyStep(int step) {
    if (step == 0 || step == 1) emit(state.copyWith(showBindShopifyStep: step));
    //TODO else
    //TODO exception;
  }

  void shopifyEmail(
      String email, String languageCode, String countryCode) {
    emit(state.copyWith(showLoading: true));
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }

    Map apiData = {
      "email": email,
      "language": languageCode,
      "organizationId": supernodeCubit.state.orgId
    };

    supernodeRepository.user.verifyExternalEmail(apiData).then((res) {
      emit(state.copyWith(showBindShopifyStep: 2, showLoading: false));
    }).catchError((err) {
      emit(state.copyWith(showLoading: false));
      //tip(ctx.context, 'verifyExternalEmail: $err');
    });
  }

  void shopifyEmailVerification(String verificationCode) {
    if (verificationCode.isNotEmpty) {
      emit(state.copyWith(showLoading: true));

      Map apiData = {"organizationId": supernodeCubit.state.orgId, "token": verificationCode};

      supernodeRepository.user.confirmExternalEmail(apiData).then((res) {
        emit(state.copyWith(showBindShopifyStep: 3, showLoading: false));
      }).catchError((err) {
        emit(state.copyWith(showLoading: false));
        //tip(ctx.context, 'confirmExternalEmail: $err');
      });
    }
  }

  void update(String username, String email) {
    //TODO if ((curState.formKey.currentState as FormState).validate()) {
    emit(state.copyWith(showLoading: true));

    Map data = {
      "id": supernodeCubit.state.session.userId,
      "username": username,
      "email": email,
      "sessionTTL": 0,
      "isAdmin": true,
      "isActive": true,
      "note": ""
    };

    supernodeRepository.user.update({"user": data}).then((res) async {
      String jwt = res['jwt'];
      if (jwt != null && jwt.isNotEmpty) {
        supernodeCubit.setSupernodeSession(
          supernodeCubit.state.session.copyWith(
            token: jwt,
            username: username,
          ),
        );
        //ctx.dispatch(ProfileActionCreator.jwtUpdate(data));
      }
      await supernodeUserCubit.refreshUser();
      emit(state.copyWith(showLoading: false));
    }).catchError((err) {
      emit(state.copyWith(showLoading: false));
      //TODO tip(ctx.context, 'UserDao update: $err');
    });
  }
}
