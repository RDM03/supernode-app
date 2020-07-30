import 'package:fish_redux/fish_redux.dart';

enum WalletAction { loadingHistory, tab, onTab, tabController, isSetDate, onFilter, updateSelectedButton, updateWalletList, updateStakeList, withdrawFee, firstTime, secondTime }

class WalletActionCreator {
  static Action loadingHistory(bool toogle) {
    return Action(WalletAction.loadingHistory,payload: toogle);
  }

  static Action onTab(int index) {
    return Action(WalletAction.onTab,payload: index);
  }

  static Action tab(int index) {
    return Action(WalletAction.tab,payload: index);
  }

  static Action tabController(dynamic controller) {
    return Action(WalletAction.tabController,payload: controller);
  }

  static Action isSetDate() {
    return const Action(WalletAction.isSetDate);
  }

  static Action onFilter(String type) {
    return Action(WalletAction.onFilter,payload: type);
  }

  static Action updateSelectedButton(int index) {
    return Action(WalletAction.updateSelectedButton,payload: index);
  }

  static Action updateWalletList(String type,List list) {
    return Action(WalletAction.updateWalletList,payload: {"type": type, "list": list});
  }

  static Action updateStakeList(String type,List list) {
    return Action(WalletAction.updateStakeList,payload: {"type": type, "list": list});
  }

  static Action withdrawFee(double fee) {
    return Action(WalletAction.withdrawFee,payload: fee);
  }

  static Action firstTime(String date) {
    return Action(WalletAction.firstTime,payload: date);
  }

  static Action secondTime(String date) {
    return Action(WalletAction.secondTime,payload: date);
  }

}
