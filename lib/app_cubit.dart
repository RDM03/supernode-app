import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.model.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({bool isDemo = false}) : super(AppState(isDemo: isDemo));

  void setDemo(bool val) => emit(state.copyWith(isDemo: val));
  void setLoading(bool val) => emit(state.copyWith(showLoading: val));
  void setLocale(Locale locale) => emit(state.copyWith(locale: locale));
  void setError(String error) => emit(state.copyWith(error: error));
}

class SupernodeCubit extends Cubit<SupernodeState> {
  SupernodeCubit({
    SupernodeSession session,
    String orgId,
  }) : super(SupernodeState(
          session: session,
          orgId: orgId,
          selectedNode: session?.node,
        ));

  void setSupernode(Supernode supernode) => emit(
        state.copyWith(selectedNode: supernode),
      );

  void setSupernodeSession(SupernodeSession session) => emit(
        state.copyWith(session: session),
      );

  void setOrganizationId(String orgId) => emit(
        state.copyWith(orgId: orgId),
      );

  void setSupernodeToken(String token) => emit(
        state.copyWith.session(
          token: token,
        ),
      );

  void logout() => emit(state.copyWith(
        session: null,
        orgId: null,
      ));
}
