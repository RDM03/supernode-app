import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';

import 'bloc/supernode/user/cubit.dart';

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

Future<void> openSupernodeDeposit(BuildContext context) async {
  final orgId = context.read<SupernodeCubit>().state.orgId;
  final userId = context.read<SupernodeCubit>().state.user.userId;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'deposit_page',
    arguments: {
      'userId': userId,
      'orgId': orgId,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeWithdraw(BuildContext context) async {
  final balance = context.read<SupernodeUserCubit>().state.balance;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'withdraw_page',
    arguments: {
      'balance': balance.value,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
}

Future<void> openSupernodeStake(BuildContext context) async {
  final balance = context.read<SupernodeUserCubit>().state.balance;
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'stake_page',
    arguments: {
      'balance': balance.value,
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

Future<void> openSupernodeUnstake(BuildContext context) async {
  final isDemo = context.read<AppCubit>().state.isDemo;
  await Navigator.of(context).pushNamed(
    'unstake_page',
    arguments: {
      'isDemo': isDemo,
    },
  );
  context.read<SupernodeUserCubit>().refreshBalance();
  context.read<SupernodeUserCubit>().refreshStakedAmount();
}

void saveCache(String key, dynamic value,
    {@required String username, @required CacheRepository cacheRepository}) {
  cacheRepository.saveUserData('user_$username', {key: value});
}
