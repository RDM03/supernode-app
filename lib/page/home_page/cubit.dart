import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';

import 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    @required this.cacheRepository,
    @required this.username,
  }) : super(HomeState(tabIndex: 0));

  final CacheRepository cacheRepository;
  final String username;

  void changeTab(int tab) => emit(state.copyWith(tabIndex: tab));

  void saveCache(String key, dynamic value) {
    cacheRepository.saveUserData('user_$username', {key: value});
  }

  Map<String, dynamic> loadCache() {
    return cacheRepository.loadUserData('user_$username') ?? {};
  }
}
