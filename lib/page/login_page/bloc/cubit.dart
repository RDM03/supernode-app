import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/configs/config.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/supernode_repository.dart';
import 'package:supernodeapp/page/login_page/bloc/state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    this.dao,
    this.appCubit,
  }) : super(LoginState(
            superNodes: GlobalStore.state.superModel.superNodesByCountry));

  void setSuperNodeListVisible(bool val) =>
      emit(state.copyWith(supernodeListVisible: val));

  void setObscureText(bool val) => emit(state.copyWith(obscureText: val));

  void setSelectedSuperNode(SuperNodeBean val) =>
      emit(state.copyWith(selectedSuperNode: val));

  void increaseTestCounter() {
    final newCount = state.showTestNodesCounter + 1;
    print(newCount);
    emit(state.copyWith(showTestNodesCounter: newCount));
  }

  final SupernodeRepository dao;
  final AppCubit appCubit;

  Future<void> login(String username, String password) async {
    if (state.selectedSuperNode == null) return;
    emit(state.copyWith(showLoading: true));
    try {
      final apiRoot = state.selectedSuperNode.url;
      final res = await dao.main.user.login({
        'username': username,
        'password': password,
      });
      final jwt = res['jwt'];
      Dao.token = jwt;

      List<String> users =
          StorageManager.sharedPreferences.getStringList(Config.USER_KEY) ?? [];
      if (!users.contains(username)) {
        users.add(username);
      }
      StorageManager.sharedPreferences.setStringList(Config.USER_KEY, users);
      StorageManager.sharedPreferences.setString(Config.TOKEN_KEY, jwt);
      StorageManager.sharedPreferences.setString(Config.USERNAME_KEY, username);
      StorageManager.sharedPreferences.setString(Config.PASSWORD_KEY, password);
      StorageManager.sharedPreferences.setString(Config.API_ROOT, apiRoot);
      appCubit.setDemo(false);
      appCubit.setNode(state.selectedSuperNode);
      setResult(LoginResult.home);
    } finally {
      emit(state.copyWith(showLoading: false));
    }
  }

  Future<void> demoLogin() async {
    emit(state.copyWith(showLoading: true));
    try {
      final res = await dao.demo.user.login(null);
      final jwt = res['jwt'];
      Dao.token = jwt;
      appCubit.setDemo(true);
      appCubit.setNode(SuperNodeBean(
        logo: 'https://lora.supernode.matchx.io/branding.png',
        name: 'Demo',
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
    setResult(LoginResult.signUp);
  }

  Future<void> forgotPassword() async {
    final res = await checkMaintenance(state.selectedSuperNode);
    if (!res) return;
    appCubit.setDemo(false);
    setResult(LoginResult.resetPassword);
  }

  void setResult(LoginResult result) => emit(state.copyWith(result: result));
}
