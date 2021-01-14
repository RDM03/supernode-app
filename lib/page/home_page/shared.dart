import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';

Future<void> openSettings(BuildContext context) {
  return Navigator.pushNamed(
    context,
    'settings_page',
    arguments: {
      'user': context.read<SupernodeCubit>().state.user,
      //'organizations': organizations, // RETHINK.TODO
      'isDemo': context.read<AppCubit>().state.isDemo,
    },
  );
}

void saveCache(String key, dynamic value,
    {@required String username, @required CacheRepository cacheRepository}) {
  cacheRepository.saveUserData('user_$username', {key: value});
}
