import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.model.dart';

import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({bool isDemo = false}) : super(AppState(isDemo: isDemo));

  void setDemo(bool val) => emit(state.copyWith(isDemo: val));
  void setLoading(bool val) => emit(state.copyWith(showLoading: val));
  void setLocale(Locale locale) => emit(state.copyWith(locale: locale));
  void setError(String error) => emit(state.copyWith(error: ErrorInfo(error)));
  void setSuccess(String success) => emit(state.copyWith(success: SuccessInfo(success)));
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

class DataHighwayCubit extends Cubit<DataHighwayState> {
  DataHighwayCubit({
    DataHighwaySession session,
    String orgId,
  }) : super(DataHighwayState(
          session: session,
        ));

  void setDataHighwaySession(DataHighwaySession session) => emit(
        state.copyWith(session: session),
      );

  void logout() => emit(state.copyWith(session: null));
}
