import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  factory HomeState({
    @required int tabIndex,
  }) = _HomeState;
}

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(tabIndex: 0));

  void changeTab(int tab) => emit(state.copyWith(tabIndex: tab));
}
