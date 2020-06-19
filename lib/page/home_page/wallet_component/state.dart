import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/daos/time_dao.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'wallet_list_adapter/wallet_item_component/state.dart';

class WalletState extends MutableSource implements Cloneable<WalletState> {

  bool loading = true;
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

  List<WalletItemState> list = [];

  @override
  Object getItemData(int index){
    list[index].fee = withdrawFee;
    return list[index];
  }

  @override
  String getItemType(int index) => 'item';

  @override
  int get itemCount => list?.length ?? 0;

  @override
  void setItemData(int index, Object data) => list[index] = data; 

  @override
  WalletState clone() {
    return WalletState()
      ..loading = loading
      ..loadingHistory= loadingHistory
      ..tabController = tabController
      ..list = list ?? []
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
      ..secondTime = secondTime;
  }
}

WalletState initState(Map<String, dynamic> args) {
  return WalletState();
}
