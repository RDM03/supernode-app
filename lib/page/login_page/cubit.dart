import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/page/login_page/state.dart';
import 'package:fluwx/fluwx.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    this.dao,
    this.appCubit,
    this.supernodeCubit,
  }) : super(LoginState());

  void setSuperNodeListVisible(bool val) =>
      emit(state.copyWith(supernodeListVisible: val));

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

  Future<void> initState() async {
    await Future.wait([
      loadSupernodes(),
      loadWeChat(),
    ]);
  }

  Future<void> loadSupernodes() async {
    final supernodes = await dao.loadSupernodes();
    final byRegion = <String, List<Supernode>>{};
    for (final s in supernodes.values) {
      if (byRegion[s.region] == null) byRegion[s.region] = [];
      byRegion[s.region].add(s);
    }
    emit(state.copyWith(supernodes: Wrap(byRegion)));
  }

  Future<void> loadWeChat() async {
    await registerWxApi(
      appId: Config.WECHAT_APP_ID,
      doOnAndroid: true,
      doOnIOS: true,
      universalLink: "https://your.univerallink.com/link/",
    );
    final result = await isWeChatInstalled;
    emit(state.copyWith(showWeChatLoginOption: result));
  }

  Future<void> login(String username, String password) async {
    if (state.selectedSuperNode == null) return;
    emit(state.copyWith(showLoading: true));
    try {
      supernodeCubit.setSupernode(state.selectedSuperNode);
      final res = await dao.main.user.login(username, password);
      final jwt = res.jwt;

      appCubit.setDemo(false);
      supernodeCubit.setOrganizationId('todo');
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

      setResult(LoginResult.home);
    } finally {
      emit(state.copyWith(showLoading: false));
    }
  }

  Future<void> demoLogin() async {
    emit(state.copyWith(showLoading: true));
    try {
      appCubit.setDemo(true);
      supernodeCubit.setOrganizationId('todo');
      supernodeCubit.setSupernodeSession(SupernodeSession(
        userId: -1,
        username: 'username',
        token: 'demo-token',
        password: 'demo-password',
        node: Supernode.demo,
      ));

      setResult(LoginResult.home);
    } finally {
      emit(state.copyWith(showLoading: false));
    }
  }

  Future<void> signUp() async {
    final res = await checkMaintenance(state.selectedSuperNode);
    if (!res) return;
    appCubit.setDemo(false);
    supernodeCubit.setSupernode(state.selectedSuperNode);
    setResult(LoginResult.signUp);
  }

  Future<void> forgotPassword() async {
    final res = await checkMaintenance(state.selectedSuperNode);
    if (!res) return;
    appCubit.setDemo(false);
    supernodeCubit.setSupernode(state.selectedSuperNode);
    setResult(LoginResult.resetPassword);
  }

  void setResult(LoginResult result) => emit(state.copyWith(result: result));
}
