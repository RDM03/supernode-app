import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/wrap.dart';

part 'state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  LoginState._();

  factory LoginState({
    @Default(false) bool supernodeListVisible,
    @Default(false) bool obscureText,
    @nullable Supernode selectedSuperNode,
    @Default(0) int showTestNodesCounter,
    @Default(Wrap.pending()) Wrap<Map<String, List<Supernode>>> supernodes,
    @Default(false) bool showLoading,
    @nullable LoginResult result,
  }) = _LoginState;

  bool get showTestNodes => showTestNodesCounter % 7 == 0;
}

enum LoginResult { home, signUp, resetPassword }
