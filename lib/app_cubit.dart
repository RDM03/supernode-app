import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.model.dart';

import 'app_state.dart';

class SupernodeCubit extends Cubit<SupernodeState> {
  SupernodeCubit({
    SupernodeUser user,
    String orgId,
  }) : super(SupernodeState(
          user: user,
          orgId: orgId,
          selectedNode: user?.node,
        ));

  void setSupernode(Supernode supernode) =>
      emit(state.copyWith(selectedNode: supernode));

  void setSupernodeUser(SupernodeUser user) => emit(state.copyWith(user: user));

  void setOrganizationId(String orgId) => emit(state.copyWith(orgId: orgId));

  void setSupernodeToken(String token) => emit(state.copyWith.user(
        token: token,
      ));

  void logout() => emit(state.copyWith(
        user: null,
        orgId: null,
      ));
}

class AppCubit extends Cubit<AppState> {
  AppCubit({bool isDemo = false}) : super(AppState(isDemo: isDemo));

  void setDemo(bool val) => emit(state.copyWith(isDemo: val));
}
