import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';

import 'action.dart';
import 'state.dart';
import 'wallet_list_adapter/wallet_item_component/state.dart';

Reducer<WalletState> buildReducer() {
  return asReducer(
    <Object, Reducer<WalletState>>{
      WalletAction.loadingHistory: _loadingHistory,
      WalletAction.tab: _tab,
      WalletAction.tabController: _tabController,
      WalletAction.isSetDate: _isSetDate,
      WalletAction.updateSelectedButton: _updateSelectedButton,
      WalletAction.updateStakeList: _updateStakeList,
      WalletAction.updateWalletList: _updateWalletList,
      WalletAction.withdrawFee: _withdrawFee,
      WalletAction.firstTime: _firstTime,
      WalletAction.secondTime: _secondTime,
      WalletAction.saveLastSearch: _saveLastSearch
    },
  );
}

WalletState _loadingHistory(WalletState state, Action action) {
  bool toogle = action.payload;

  final WalletState newState = state.clone();

  return newState..loadingHistory = toogle;
}

WalletState _tab(WalletState state, Action action) {
  int tabIndex = action.payload;

  final WalletState newState = state.clone();

  if (state.tabIndex == tabIndex) {
    return state;
  }

  return newState
    ..tabIndex = tabIndex
    ..selectedIndexBtn1 = -1
    ..selectedIndexBtn2 = -1
    ..isSetDate1 = false
    ..isSetDate2 = false
    ..tabHeight = tabIndex == 0 ? 100 : 140;
}

WalletState _tabController(WalletState state, Action action) {
  dynamic controller = action.payload;

  final WalletState newState = state.clone();

  return newState..tabController = controller;
}

WalletState _isSetDate(WalletState state, Action action) {
  final WalletState newState = state.clone();

  if (state.tabIndex == 0 && !state.isSetDate1) {
    return newState
      ..selectedIndexBtn1 = 2
      ..isSetDate1 = !state.isSetDate1;
  } else if (state.tabIndex == 1 && !state.isSetDate2) {
    return newState
      ..selectedIndexBtn2 = 2
      ..isSetDate2 = !state.isSetDate2;
  }

  return state;
}

WalletState _updateSelectedButton(WalletState state, Action action) {
  int index = action.payload;

  final WalletState newState = state.clone();

  if (state.tabIndex == 0) {
    return newState
      ..isSetDate1 = false
      ..isSetDate2 = false
      ..selectedIndexBtn1 = index;
  }

  return newState
    ..isSetDate1 = false
    ..isSetDate2 = false
    ..selectedIndexBtn2 = index;
}

WalletState _updateStakeList(WalletState state, Action action) {
  Map data = action.payload;
  String sourceType = data['type'];
  final type = sourceType.split(' ')[0];

  final sourceList =
      (data['list'] as List).map((e) => StakeHistoryEntity.fromMap(e)).toList();
  final entityList = [];

  if (type == 'STAKE') {
    entityList.addAll(sourceList.where((e) => e.type == 'STAKING'));
  } else if (type == 'UNSTAKE') {
    entityList.addAll(sourceList.where((e) => e.type == 'UNSTAKING'));
  } else {
    entityList.addAll(sourceList);
  }

  final list = entityList.map((e) => StakeItemState(e, type)).toList();

  list.sort(
      (a, b) => b.historyEntity.timestamp.compareTo(a.historyEntity.timestamp));
  if (list.length > 0) {
    list[list.length - 1] = list[list.length - 1].copyWith(isLast: true);
  }

  final WalletState newState = state.clone();

  return newState
    ..isFirstRequest = false
    ..stakeList = list;
}

WalletState _updateWalletList(WalletState state, Action action) {
  Map data = action.payload;
  String sourceType = data['type'];
  final type = sourceType.split(' ')[0];
  List<WalletItemState> list = [];

  final sourceList =
      (data['list'] as List).map((e) => WalletItemState.fromMap(e));
  if (type == 'STAKE') {
    list.addAll(sourceList.where((e) => e.type == 'STAKING'));
  } else if (type == 'UNSTAKE') {
    list.addAll(sourceList.where((e) => e.type == 'UNSTAKING'));
  } else if (type == 'DEPOSIT') {
    list.addAll(sourceList.where((e) => e.amount > 0));
  } else if (type == 'WITHDRAW') {
    list.addAll(sourceList.where((e) => e.amount < 0));
  } else {
    list.addAll(sourceList);
  }

  list.forEach((e) => e.type = type);

  list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
  if (list.length > 0) list[list.length - 1].isLast = true;

  final WalletState newState = state.clone();

  return newState
    ..isFirstRequest = false
    ..walletList = list;
}

WalletState _withdrawFee(WalletState state, Action action) {
  double fee = action.payload;

  final WalletState newState = state.clone();

  return newState..withdrawFee = fee;
}

WalletState _firstTime(WalletState state, Action action) {
  String date = action.payload;

  final WalletState newState = state.clone();

  return newState..firstTime = date;
}

WalletState _secondTime(WalletState state, Action action) {
  String date = action.payload;

  final WalletState newState = state.clone();

  return newState..secondTime = date;
}

WalletState _saveLastSearch(WalletState state, Action action) {
  Map data = action.payload;

  final WalletState newState = state.clone();

  return newState
    ..lastSearchData = data['data']
    ..lastSearchType = data['type'];
}
