import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/common/utils/utils.dart';

import 'action.dart';
import 'state.dart';

Effect<CalculatorListState> buildEffect() {
  return combineEffects(<Object, Effect<CalculatorListState>>{
    CalculatorListAction.onDone: _onDone,
    Lifecycle.initState: _initState,
    Lifecycle.dispose: _dispose,
  });
}

Future<void> _onDone(Action action, Context<CalculatorListState> ctx) async {
  await StorageManager.setSelectedCurrencies(ctx.state.selectedCurrencies);
  Navigator.of(ctx.context).pop();
}

void _initState(Action action, Context<CalculatorListState> ctx) {
  final listener = FishListener(ctx, _searchListener);
  ctx.state.searchController.addListener(listener.listener);
  ctx.dispatch(CalculatorListActionCreator.initListener(listener));
}

void _dispose(Action action, Context<CalculatorListState> ctx) {
  ctx.state.searchController.removeListener(ctx.state.searchListener.listener);
}

void _searchListener(Context<CalculatorListState> ctx) {
  ctx.dispatch(CalculatorListActionCreator.setSearchValue(
    ctx.state.searchController.text,
  ));
}
