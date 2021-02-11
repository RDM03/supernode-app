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
  SettingsCubit({
    this.appCubit,
    this.supernodeUserCubit,
    this.supernodeRepository
  }) : super(SettingsState(
      screenShot: false,
      showWechatUnbindConfirmation: false,
      showBindShopifyStep: 0,
      showLoading: false)
  );

  final AppCubit appCubit;
  final SupernodeUserCubit supernodeUserCubit;
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

  void bindShopifyStep(int step) {
    emit(state.copyWith(showBindShopifyStep: step));
  }

  void onUnbind(String service, String orgId) {
    emit(state.copyWith(showWechatUnbindConfirmation: false, showLoading: true));

    Map data = {
      "organizationId": orgId,
      "service": service
    };

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

  void shopifyEmailVerification(String verificationCode, String orgId) {
    //if (verificationCode.isNotEmpty) {
      //final loading = Loading.show(ctx.context);

      Map apiData = {
        "organizationId": orgId,
        "token": verificationCode
      };

      //UserDao dao = _buildUserDao(ctx);

      //dao.confirmExternalEmail(apiData).then((res) {
        //loading.hide();
        emit(state.copyWith(showBindShopifyStep: 3));
        //ctx.dispatch(ProfileActionCreator.bindShopifyStep(3));
      //}).catchError((err) {
        //loading.hide();
        //tip(ctx.context, 'confirmExternalEmail: $err');
      //});
    //}
  }

  void shopifyEmail(String email, String orgId, String languageCode, String countryCode) {
    if (languageCode.contains('zh')) {
      languageCode = '$languageCode$countryCode';
    }

    Map apiData = {
      "email": email,
      "language": languageCode,
      "organizationId": orgId
    };

    //UserDao dao = _buildUserDao(ctx);
    supernodeRepository;

    //dao.verifyExternalEmail(apiData).then((res) {
    //loading.hide();
    emit(state.copyWith(showBindShopifyStep: 2));
    //TODO delete ctx.dispatch(ProfileActionCreator.bindShopifyStep(2));
    //}).catchError((err) {
    //loading.hide();
    //tip(ctx.context, 'verifyExternalEmail: $err');
    //});
    }

  void update(String username, String email) {
    /*if ((curState.formKey.currentState as FormState).validate()) {
      final loading = Loading.show(ctx.context);

      Map data = {
        "id": curState.userId,
        "username": username,
        "email": email,
        "sessionTTL": 0,
        "isAdmin": true,
        "isActive": true,
        "note": ""
      };

      UserDao dao = _buildUserDao(ctx);

      dao.update({"user": data}).then((res) async {
        mLog('update', res);

        String jwt = res['jwt'];
        if (jwt != null && jwt.isNotEmpty) {
          ctx.context.read<SupernodeCubit>().setSupernodeSession(
            ctx.context.read<SupernodeCubit>().state.session.copyWith(
              token: jwt,
              username: username,
            ),
          );
          ctx.dispatch(ProfileActionCreator.jwtUpdate(data));
        }
        await ctx.context.read<SupernodeUserCubit>().refreshUser();
        loading.hide();
        Navigator.of(ctx.context).pop();
      }).catchError((err) {
        loading.hide();
        tip(ctx.context, 'UserDao update: $err');
      });
    }*/
  }
}
