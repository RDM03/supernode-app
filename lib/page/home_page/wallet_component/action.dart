import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';
import 'package:supernodeapp/page/home_page/wallet_component/state.dart';

enum WalletAction {
  expand,
  selectToken,
  onAddDHX,
  addDHX,
  balanceDHX,
  dataDHX,
  lastMining,
  loadingHistory,
  tab,
  onTab,
  isSetDate,
  onFilter,
  updateSelectedButton,
  updateWalletList,
  updateStakeList,
  withdrawFee,
  firstTime,
  secondTime,
  onStake,
  onUnstake,
  onStakeDetails,
  saveLastSearch,
}

class WalletActionCreator {
  static Action expand(Token t) {
    return Action(WalletAction.expand, payload: t);
  }

  static Action selectToken(Token t) {
    return Action(WalletAction.selectToken, payload: t);
  }

  static Action onAddDHX() {
    return Action(WalletAction.onAddDHX);
  }

  static Action addDHX() {
    return Action(WalletAction.addDHX);
  }

  static Action balanceDHX(double balanceDHX) {
    return Action(WalletAction.balanceDHX, payload: balanceDHX);
  }

  static Action dataDHX(Map data) {
    return Action(WalletAction.dataDHX, payload: data);
  }

  static Action lastMining(double miningPower) {
    return Action(WalletAction.lastMining, payload: miningPower);
  }

  static Action loadingHistory(bool toogle) {
    return Action(WalletAction.loadingHistory, payload: toogle);
  }

  static Action onTab(int index) {
    return Action(WalletAction.onTab, payload: index);
  }

  static Action tab(int index) {
    return Action(WalletAction.tab, payload: index);
  }

  static Action isSetDate() {
    return const Action(WalletAction.isSetDate);
  }

  static Action onFilter(String type) {
    return Action(WalletAction.onFilter, payload: type);
  }

  static Action updateSelectedButton(int index) {
    return Action(WalletAction.updateSelectedButton, payload: index);
  }

  static Action updateWalletList(String type, List list) {
    return Action(WalletAction.updateWalletList,
        payload: {"type": type, "list": list});
  }

  static Action updateStakeList(String type, List list) {
    return Action(WalletAction.updateStakeList,
        payload: {"type": type, "list": list});
  }

  static Action withdrawFee(double fee) {
    return Action(WalletAction.withdrawFee, payload: fee);
  }

  static Action firstTime(String date) {
    return Action(WalletAction.firstTime, payload: date);
  }

  static Action secondTime(String date) {
    return Action(WalletAction.secondTime, payload: date);
  }

  static Action onStake() {
    return Action(WalletAction.onStake);
  }

  static Action onUnstake() {
    return Action(WalletAction.onUnstake);
  }

  static Action onStakeDetails(Stake stake) {
    return Action(WalletAction.onStakeDetails, payload: stake);
  }

  static Action saveLastSearch(Map lastSearchData, String lastSearchType) {
    return Action(WalletAction.saveLastSearch, payload: {
      'data': lastSearchData,
      'type': lastSearchType,
    });
  }
}
