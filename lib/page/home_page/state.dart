import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState({
    @required int tabIndex,
    PageRoute routeTo,
  }) = _HomeState;
}
