import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/settings_page/organizations_component/state.dart';

import 'wallet_list_adapter/wallet_item_component/state.dart';

enum Token {MXC, DHX}

class WalletState extends MutableSource implements Cloneable<WalletState> {

  bool expandedView = false;
  List<Token> displayTokens = [Token.MXC];
  Token selectedToken = Token.MXC;
  bool isFirstRequest = true;
  bool loading = true;

  /// labels for data being loaded ['balance', 'balanceDHX', 'stakeAmount', 'totalRevenue', 'lockedAmount']
  Set loadingMap = {};
  bool loadingHistory = true;
  Map<Token, int> activeTabToken = {Token.MXC: 0, Token.DHX: 0};
  bool isSetDate1 = false;
  bool isSetDate2 = false;

  int selectedIndexBtn1 = -1;
  int selectedIndexBtn2 = -1;

  String firstTime = '';
  String secondTime = '';

  List<OrganizationsState> organizations = [];

  //amount
  double balance = 0; // MXC
  double balanceDHX = 0;

  //stake
  double stakedAmount = 0;
  double totalRevenue = 0; // MXC
  double lockedAmount = 0;
  double totalRevenueDHX = 0;

  //withdraw
  double withdrawFee = 0;

  List<dynamic> get _currentList => (selectedToken == Token.MXC)
    ? activeTabToken[selectedToken] == 0 ? walletList : stakeList
    : activeTabToken[selectedToken] == 0 ? stakeDHXList : transactions;

  List<StakeItemState> stakeList = [];
  List<WalletItemState> walletList = [];
  List<StakeDHXItemState> stakeDHXList = [];
  List<WalletItemState> transactions = [];

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
      ..displayTokens = displayTokens
      ..selectedToken = selectedToken
      ..isFirstRequest = isFirstRequest
      ..loading = loading
      ..loadingMap = loadingMap
      ..loadingHistory = loadingHistory
      ..walletList = walletList
      ..stakeList = stakeList
      ..stakeDHXList = stakeDHXList
      ..transactions = transactions
      ..organizations = organizations
      ..activeTabToken = activeTabToken
      ..isSetDate1 = isSetDate1
      ..isSetDate2 = isSetDate2
      ..selectedIndexBtn1 = selectedIndexBtn1
      ..selectedIndexBtn2 = selectedIndexBtn2
      ..balance = balance
      ..balanceDHX = balanceDHX
      ..stakedAmount = stakedAmount
      ..totalRevenue = totalRevenue
      ..lockedAmount = lockedAmount
      ..totalRevenueDHX =totalRevenueDHX
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
