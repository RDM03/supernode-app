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
    @Default(true) bool obscureText,
    @nullable Supernode selectedSuperNode,
    @Default(0) int showTestNodesCounter,
    @Default(Wrap.pending()) Wrap<Map<String, List<Supernode>>> supernodes,
    @nullable String email,
    @nullable String userId,
    @nullable String jwtToken,
    @Default(false) bool showLoading,
    @Default(false) bool showWeChatLoginOption,
    @nullable String errorMessage,
    @nullable LoginResult loginResult,
    @nullable SignupResult signupResult,
  }) = _LoginState;

  bool get showTestNodes =>
      (showTestNodesCounter % 7 == 0) && (showTestNodesCounter != 0);
}

enum LoginResult { home, resetPassword, wechat }
enum SignupResult { home, verifyEmail, registration, addGateway }
