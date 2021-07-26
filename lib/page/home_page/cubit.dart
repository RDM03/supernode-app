import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  static const int HOME_TAB = 0;
  static const int WALLET_TAB = 1;
  static const int MINER_TAB = 2;
  static const int DEVICE_TAB = 3;

  HomeCubit({
    @required this.cacheRepository,
    @required this.supernodeUsername,
    bool supernodeUsed = false,
    bool parachainUsed = false,
  }) : super(
          HomeState(
            tabIndex: HOME_TAB,
            supernodeUsed: supernodeUsed,
            parachainUsed: parachainUsed,
            displayTokens: [
              if (supernodeUsed) Token.mxc,
              if (parachainUsed) Token.parachainDhx,
            ],
          ),
        );

  final CacheRepository cacheRepository;
  final String supernodeUsername;

  // it aims to refresh translations of home page 
  void updateTab() {
    int originalTab = state.tabIndex;
    Token originalToken = state.walletSelectedToken;

    int changeTab = HOME_TAB;

    if(originalTab == HOME_TAB){
      changeTab = WALLET_TAB;
    }

    emit(state.copyWith(tabIndex: changeTab));
    emit(state.copyWith(tabIndex: originalTab, walletSelectedToken: originalToken));
  }

  void changeTab(int tab, {Token walletSelToken}) {
    if (tab == WALLET_TAB)
      emit(state.copyWith(tabIndex: tab, walletSelectedToken: walletSelToken));
    else
      emit(state.copyWith(tabIndex: tab));
  }

  void toggleSupernodeDhx() {
    if (state.displayTokens.contains(Token.supernodeDhx)) {
      saveSNCache(CacheRepository.walletDHX, false);
      emit(state.copyWith(
          displayTokens: state.displayTokens
              .where((t) => (t != Token.supernodeDhx))
              .toList()));
    } else {
      saveSNCache(CacheRepository.walletDHX, true);
      emit(state.copyWith(
        displayTokens: orderMxcDhxBtcParachain(
            [...state.displayTokens, Token.supernodeDhx]),
      ));
    }
  }

  void toggleSupernodeBtc() {
    if (state.displayTokens.contains(Token.btc)) {
      saveSNCache(CacheRepository.walletBTC, false);
      emit(state.copyWith(
          displayTokens:
              state.displayTokens.where((t) => (t != Token.btc)).toList()));
    } else {
      saveSNCache(CacheRepository.walletBTC, true);
      emit(state.copyWith(
        displayTokens:
            orderMxcDhxBtcParachain([...state.displayTokens, Token.btc]),
      ));
    }
  }

  void saveSNCache(String key, dynamic value, {String userKey}) {
    cacheRepository
        .saveUserData(userKey ?? 'user_$supernodeUsername', {key: value});
  }

  Future<void> initState() async {
    final data = loadSNCache();
    final dhxUsed = data[CacheRepository.walletDHX] ?? false;
    if (dhxUsed) {
      emit(state.copyWith(
        displayTokens: orderMxcDhxBtcParachain(
            [...state.displayTokens, Token.supernodeDhx]),
      ));
    }
    final btcUsed = data[CacheRepository.walletDHX] ?? false;
    if (btcUsed) {
      emit(state.copyWith(
        displayTokens:
            orderMxcDhxBtcParachain([...state.displayTokens, Token.btc]),
      ));
    }
  }

  Map<String, dynamic> loadSNCache([String key]) {
    return cacheRepository.loadUserData(key ?? 'user_$supernodeUsername') ?? {};
  }
}

List<Token> orderMxcDhxBtcParachain(List<Token> list) {
  final List<Token> listSorted = [];
  if (list.contains(Token.mxc)) listSorted.add(Token.mxc);
  if (list.contains(Token.supernodeDhx)) listSorted.add(Token.supernodeDhx);
  if (list.contains(Token.btc)) listSorted.add(Token.btc);
  if (list.contains(Token.parachainDhx)) listSorted.add(Token.parachainDhx);

  return listSorted;
}
