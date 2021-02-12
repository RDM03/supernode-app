import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    @required this.cacheRepository,
    @required this.supernodeUsername,
    bool supernodeUsed = false,
    bool parachainUsed = false,
  }) : super(
          HomeState(
            tabIndex: 0,
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

  void changeTab(int tab) => emit(state.copyWith(tabIndex: tab));

  void addSupernodeDhx() {
    saveSNCache(CacheRepository.walletDHX, true);
    emit(state.copyWith(
      displayTokens: {...state.displayTokens, Token.supernodeDhx}.toList(),
    ));
  }

  void addSupernodeBtc() {
    saveSNCache(CacheRepository.walletBTC, true);
    emit(state.copyWith(
      displayTokens: {...state.displayTokens, Token.btc}.toList(),
    ));
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
        displayTokens: [...state.displayTokens, Token.supernodeDhx],
      ));
    }
    final btcUsed = data[CacheRepository.walletDHX] ?? false;
    if (btcUsed) {
      emit(state.copyWith(
        displayTokens: [...state.displayTokens, Token.btc],
      ));
    }
  }

  Map<String, dynamic> loadSNCache([String key]) {
    return cacheRepository.loadUserData(key ?? 'user_$supernodeUsername') ?? {};
  }
}
