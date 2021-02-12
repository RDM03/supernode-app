import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

part 'state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState({
    @required int tabIndex,
    PageRoute routeTo,
    bool supernodeUsed,
    bool parachainUsed,
    @required List<Token> displayTokens,
  }) = _HomeState;
}
