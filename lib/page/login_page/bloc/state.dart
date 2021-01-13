import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/data/super_node_bean.dart';

part 'state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  LoginState._();

  factory LoginState({
    @Default(false) bool supernodeListVisible,
    @Default(false) bool obscureText,
    @nullable SuperNodeBean selectedSuperNode,
    @Default(0) int showTestNodesCounter,
    Map<String, List<SuperNodeBean>> superNodes,
    @Default(false) bool showLoading,
    @nullable LoginResult result,
  }) = _LoginState;

  bool get showTestNodes => showTestNodesCounter == 7;
}

enum LoginResult { home, signUp, resetPassword }
