import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.model.dart';
part 'app_state.freezed.dart';

@freezed
abstract class AppState with _$AppState {
  factory AppState({
    Locale locale,
    @Default(false) bool isDemo,
    @Default(false) bool showLoading,
    @nullable String error,
  }) = _AppState;
}

@freezed
abstract class SupernodeState with _$SupernodeState {
  SupernodeState._();
  factory SupernodeState({
    SupernodeSession session,
    Supernode selectedNode,
    String orgId,
  }) = _SupernodeState;
}

@freezed
abstract class SupernodeSession with _$SupernodeSession {
  factory SupernodeSession({
    int userId,
    String username,
    String token,
    String password,
    Supernode node,
    @Default(false) bool tfaEnabled,
  }) = _SupernodeSession;
}
