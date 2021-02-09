import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';

import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    @required this.cacheRepository,
    @required this.supernodeUsername,
    @required bool supernodeUsed = false,
    @required bool parachainUsed = false,
  }) : super(HomeState(
          tabIndex: 0,
          supernodeUsed: supernodeUsed,
          parachainUsed: parachainUsed,
        ));

  final CacheRepository cacheRepository;
  final String supernodeUsername;

  void changeTab(int tab) => emit(state.copyWith(tabIndex: tab));

  void saveSNCache(String key, dynamic value, {String userKey}) {
    cacheRepository
        .saveUserData(userKey ?? 'user_$supernodeUsername', {key: value});
  }

  Map<String, dynamic> loadSNCache([String key]) {
    return cacheRepository.loadUserData(key ?? 'user_$supernodeUsername') ?? {};
  }
}
