import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/data/super_node_bean.dart';

part 'app_state.freezed.dart';

@freezed
abstract class SupernodeState with _$SupernodeState {
  factory SupernodeState({
    SuperNodeBean currentNode,
    String userId,
    String username,
    String orgId,
  }) = _SupernodeState;
}

@freezed
abstract class AppState with _$AppState {
  factory AppState({
    SupernodeState supernode,
    @Default(false) bool isDemo,
  }) = _AppState;
}

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppState());

  void setDemo(bool val) => emit(state.copyWith(isDemo: val));
  void setNode(SuperNodeBean val) =>
      emit(state.copyWith.supernode(currentNode: val));
}
