import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'wallet_list_adapter/wallet_item_component/state.dart';

enum Token {MXC, DHX}

class WalletState extends MutableSource implements Cloneable<WalletState> {

  bool expandedView = false;
  List<Token> displayTokes = [Token.MXC];
  bool isFirstRequest = true;
  bool loading = true;
  Set loadingMap = {};
  bool loadingHistory = true;
  TabController tabController;
  int tabIndex = 0;
  double tabHeight = 100;
  bool isSetDate1 = false;
  bool isSetDate2 = false;

  int selectedIndexBtn1 = -1;
  int selectedIndexBtn2 = -1;

  String firstTime = '';
  String secondTime = '';

  List<OrganizationsState> organizations = [];

  //amount
  double balance = 0;

  //stake
  double stakedAmount = 0;
  double totalRevenue = 0;

  //withdraw
  double withdrawFee = 0;

  List<dynamic> get _currentList => tabIndex == 0 ? walletList : stakeList;

  List<StakeItemState> stakeList = [];
  List<WalletItemState> walletList = [];

  @override
  Object getItemData(int index) {
    final o = _currentList[index];
    if (o is WalletItemState) {
      o.fee = withdrawFee;
    }
    return o;
  }

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => _currentList?.length ?? 0;

  @override
  void setItemData(int index, Object data) => _currentList[index] = data;

  bool isDemo;

  Map lastSearchData;
  String lastSearchType;

  @override
  WalletState clone() {
    return WalletState()
      ..expandedView = expandedView
      ..displayTokes = displayTokes
      ..isFirstRequest = isFirstRequest
      ..loading = loading
      ..loadingMap = loadingMap
      ..loadingHistory = loadingHistory
      ..tabController = tabController
      ..walletList = walletList
      ..stakeList = stakeList
      ..organizations = organizations
      ..tabIndex = tabIndex
      ..tabHeight = tabHeight
      ..isSetDate1 = isSetDate1
      ..isSetDate2 = isSetDate2
      ..selectedIndexBtn1 = selectedIndexBtn1
      ..selectedIndexBtn2 = selectedIndexBtn2
      ..balance = balance
      ..stakedAmount = stakedAmount
      ..totalRevenue = totalRevenue
      ..withdrawFee = withdrawFee
      ..firstTime = firstTime
      ..secondTime = secondTime
      ..isDemo = isDemo
      ..lastSearchData = lastSearchData
      ..lastSearchType = lastSearchType;
  }
}

WalletState initState(Map<String, dynamic> args) {
  return WalletState();
}
