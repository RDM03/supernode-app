import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

import 'state.dart';

class LoginCubit extends Cubit<LoginState> {
  static const SUPER_NODES = "assets/others/super_node.json";

  LoginCubit({
    this.dao,
    this.appCubit,
    this.supernodeCubit,
  }) : super(LoginState());

  void setSuperNodeListVisible(bool val) => (val)
      ? emit(state.copyWith(supernodeListVisible: val))
      : emit(
          state.copyWith(showTestNodesCounter: 0, supernodeListVisible: val));

  void setObscureText(bool val) => emit(state.copyWith(obscureText: val));

  void setSelectedSuperNode(Supernode val) =>
      emit(state.copyWith(selectedSuperNode: val));

  void increaseTestCounter() {
    final newCount = state.showTestNodesCounter + 1;
    print(newCount);
    emit(state.copyWith(showTestNodesCounter: newCount));
  }

  final SupernodeRepository dao;
  final AppCubit appCubit;
  final SupernodeCubit supernodeCubit;

  StreamSubscription _weChatSubscription;

  Future<void> initState() async {
    await Future.wait([
      loadSupernodes(),
      loadWeChat(),
    ]);
  }

  @override
  Future<void> close() async {
    super.close();
    _weChatSubscription?.cancel();
  }

  Future<void> loadSupernodes() async {
    await _loadLocalSupernodes();

    try {
      final supernodes = await dao.loadSupernodes();
      final byRegion = <String, List<Supernode>>{};
      for (final s in supernodes.values) {
        if (byRegion[s.region] == null) byRegion[s.region] = [];
        byRegion[s.region].add(s);
      }
      emit(state.copyWith(supernodes: Wrap(byRegion)));
    } catch (e) {
      //loading network supernodes failed
    }
  }

  @override
  Future<void> _loadLocalSupernodes() async {
    final byRegion = <String, List<Supernode>>{};
    Supernode s;

    Map<String, dynamic> nodes =
        jsonDecode(await rootBundle.loadString(SUPER_NODES));
    for (var k in nodes.keys) {
      s = Supernode(
        name: k,
        logo: nodes[k]["logo"],
        region: nodes[k]["region"],
        url: nodes[k]["url"],
        status: nodes[k]['status'],
      );
      if (byRegion[s.region] == null) byRegion[s.region] = [];
      byRegion[s.region].add(s);
    }
    emit(state.copyWith(supernodes: Wrap(byRegion)));
  }

  Future<void> loadWeChat() async {
    await fluwx.registerWxApi(
        appId: Config.WECHAT_APP_ID,
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://www.mxc.org/mxcdatadash/");
    var wxInstalled = await fluwx.isWeChatInstalled;
    emit(state.copyWith(showWeChatLoginOption: wxInstalled));

    if (wxInstalled) {
      _weChatSubscription = fluwx.weChatResponseEventHandler
          .distinct((a, b) => a == b)
          .listen(handleWeChatEvent);
    }
  }

  Future<void> handleWeChatEvent(fluwx.BaseWeChatResponse res) async {
    if (res is fluwx.WeChatAuthResponse) {
      emit(state.copyWith(showLoading: true));
      try {
        if (res.errCode == 0) {
          Map data = {'code': res.code};
          appCubit.setDemo(false);
          supernodeCubit.setSupernode(state.selectedSuperNode);

          var authWeChatUserRes =
              (Config.WECHAT_APP_ID == Config.WECHAT_APP_ID_DEBUG)
                  ? await dao.user.debugAuthenticateWeChatUser(data)
                  : await dao.user.authenticateWeChatUser(data);

          final jwt = authWeChatUserRes['jwt'];
          supernodeCubit.setSupernodeSession(SupernodeSession(
            node: state.selectedSuperNode,
            token: jwt,
          ));

          if (authWeChatUserRes['bindingIsRequired']) {
            // bind DataDash and WeChat accounts
            setLoginResult(LoginResult.wechat);
          } else {
            final jwt = authWeChatUserRes['jwt'];
            final parsedJwt = parseJwt(jwt);

            supernodeCubit.setSupernodeSession(SupernodeSession(
              username: parsedJwt.username,
              password: '',
              token: jwt,
              userId: parsedJwt.userId,
              node: state.selectedSuperNode,
            ));

            final profile = await dao.main.user.profile();
            supernodeCubit.setOrganizationId(
              profile.organizations.first.organizationID,
            );
            setLoginResult(LoginResult.home);
          }
        } else {
          //tip(res.errStr);
        }
      } catch (err) {
        final maintenance = await checkMaintenance(state.selectedSuperNode);
        if (!maintenance) return;
        String msg;
        try {
          msg = err?.message ?? 'error_tip';
        } catch (e) {
          msg = 'error_tip';
        }
        emit(state.copyWith(errorMessage: msg));
      } finally {
        emit(state.copyWith(showLoading: false));
      }
    }
  }

  Future<void> login(String username, String password) async {
    final maintenance = await checkMaintenance(state.selectedSuperNode);
    if (!maintenance) return;

    if (state.selectedSuperNode == null) return;
    emit(state.copyWith(showLoading: true));
    try {
      supernodeCubit.setSupernode(state.selectedSuperNode);
      final res = await dao.main.user.login(username, password);
      final jwt = res.jwt;

      appCubit.setDemo(false);
      supernodeCubit.setSupernodeSession(SupernodeSession(
        username: username,
        password: password,
        token: jwt,
        userId: res.parsedJwt.userId,
        node: state.selectedSuperNode,
      ));

      final profile = await dao.main.user.profile();
      supernodeCubit.setOrganizationId(
        profile.organizations.first.organizationID,
      );

      setLoginResult(LoginResult.home);
    } catch (err) {
      appCubit.setError(err.toString());
    } finally {
      emit(state.copyWith(showLoading: false));
    }
  }

  Future<void> demoLogin() async {
    emit(state.copyWith(showLoading: true));
    try {
      appCubit.setDemo(true);
      //supernodeCubit.setOrganizationId('todo');
      supernodeCubit.setSupernodeSession(SupernodeSession(
        userId: -1,
        username: 'username',
        token: 'demo-token',
        password: 'demo-password',
        node: Supernode.demo,
      ));

      setLoginResult(LoginResult.home);
    } finally {
      emit(state.copyWith(showLoading: false));
    }
  }

  Future<void> weChatLogin() async {
    if (state.selectedSuperNode == null) return;
    emit(state.copyWith(showLoading: true));
    fluwx.sendWeChatAuth(
        scope: "snsapi_userinfo", state: "wechat_sdk_demo_test");
  }

  Future<void> forgotPassword() async {
    final res = await checkMaintenance(state.selectedSuperNode);
    if (!res) return;
    appCubit.setDemo(false);
    supernodeCubit.setSupernode(state.selectedSuperNode);
    setLoginResult(LoginResult.resetPassword);
  }

  void setLoginResult(LoginResult result) {
    emit(state.copyWith(loginResult: null));
    emit(state.copyWith(loginResult: result));
  }

  /* Sign Up */
  void setSignupResult(SignupResult result) {
    emit(state.copyWith(signupResult: null));
    emit(state.copyWith(signupResult: result));
  }

  Future<void> signupEmail(String email, String lang) async {
    final maintenance = await checkMaintenance(state.selectedSuperNode);
    if (!maintenance) return;

    if (state.selectedSuperNode == null) return;
    emit(state.copyWith(showLoading: true));
    try {
      supernodeCubit.setSupernode(state.selectedSuperNode);
      String language = appCubit.state.locale != null
          ? appCubit.state.locale.languageCode
          : lang;
      Map data = {"email": email, "language": language};
      await dao.main.user.register(data);

      emit(state.copyWith(email: email, showLoading: false));
      setSignupResult(SignupResult.verifyEmail);
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError(err.toString());
    }
  }

  Future<void> verifySignupEmail(String verificationCode) async {
    emit(state.copyWith(showLoading: true));
    Map data = {"token": verificationCode};

    try {
      RegistrationConfirmResponse rcr =
          await dao.main.user.registerConfirm(data);

      emit(state.copyWith(
          jwtToken: rcr.jwt,
          email: rcr.username,
          userId: rcr.id,
          showLoading: false));
      setSignupResult(SignupResult.registration);
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError(err.toString());
    }
  }

  Future<void> registerFinish(String email, String password, String orgName,
      String orgDisplayName) async {
    emit(state.copyWith(showLoading: true));

    Map data = {
      "organizationName": orgName,
      "organizationDisplayName": orgDisplayName,
      "userId": state.userId,
      "password": password
    };

    try {
      appCubit.setDemo(false);

      await dao.main.user.registerFinish(data, state.jwtToken);

      supernodeCubit.setSupernodeSession(SupernodeSession(
        username: email,
        password: password,
        token: state.jwtToken,
        userId: int.tryParse(state.userId),
        node: supernodeCubit.state.selectedNode,
      ));

      final profile = await dao.main.user.profile();
      supernodeCubit.setOrganizationId(
        profile.organizations.first.organizationID,
      );

      emit(state.copyWith(showLoading: false));

      setSignupResult(SignupResult.addGateway);
    } catch (err) {
      emit(state.copyWith(showLoading: false));
      appCubit.setError(err.toString());
    }
    ;
  }
}
