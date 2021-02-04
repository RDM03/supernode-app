import 'package:bloc/bloc.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';

import 'state.dart';

class SupernodeBtcCubit extends Cubit<SupernodeBtcState> {
  SupernodeBtcCubit({
    this.supernodeRepository,
    this.orgId,
    this.session,
    this.homeCubit,
  }) : super(SupernodeBtcState());

  final HomeCubit homeCubit;
  final SupernodeSession session;
  final String orgId;
  final SupernodeRepository supernodeRepository;

  Future<void> initState() async {
    var data = homeCubit.loadCache();

    final newState = state.copyWith(
      balance: Wrap(
        data[CacheRepository.balanceBTCKey]?.toDouble(),
        loading: true,
      ),
    );

    emit(newState);
    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshBalance(),
      refreshWithdraws(),
    ]);
  }

  Future<void> refreshBalance() async {
    emit(state.copyWith(balance: state.balance.withLoading()));
    try {
      final balanceData = await supernodeRepository.wallet.balance({
        'userId': session.userId,
        'orgId': orgId,
        'currency': 'BTC',
      });
      final value = double.tryParse(balanceData['balance']);
      emit(state.copyWith(balance: Wrap(value)));
      homeCubit.saveCache(CacheRepository.balanceBTCKey, value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(balance: state.balance.withError(e)));
    }
  }

  Future<void> refreshWithdraws() async {
    emit(state.copyWith(withdraws: state.withdraws.withLoading()));
    try {
      final data = {
        'orgId': orgId,
        'from': DateTime(2000).toUtc().toIso8601String(),
        'till': DateTime.now().toUtc().add(Duration(days: 1)).toIso8601String(),
        'currency': 'BTC',
      };
      var history = await supernodeRepository.withdraw.history(data);
      emit(state.copyWith(withdraws: Wrap(history)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(withdraws: state.withdraws.withError(e)));
    }
  }
}
