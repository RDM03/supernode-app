import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';

import 'state.dart';

class SupernodeUserCubit extends Cubit<SupernodeUserState> {
  SupernodeUserCubit({
    this.supernodeRepository,
    this.cacheRepository,
    this.user,
    this.orgId,
    this.homeCubit,
  }) : super(SupernodeUserState(
          username: user.username,
        ));

  final HomeCubit homeCubit;
  final SupernodeUser user;
  final String orgId;
  final SupernodeRepository supernodeRepository;
  final CacheRepository cacheRepository;

  Future<void> initState() async {
    var data = homeCubit.loadCache();

    final newState = state.copyWith(
      balance: Wrap(data['balance']?.toDouble(), loading: true),
      gatewaysRevenue: Wrap(data['miningIncome']?.toDouble(), loading: true),
      stakedAmount: Wrap(data['stakedAmount']?.toDouble(), loading: true),
      totalRevenue: Wrap(data['totalRevenue']?.toDouble(), loading: true),
      gatewaysRevenueUsd: Wrap(data['usd_gateway']?.toDouble(), loading: true),
    );

    emit(newState);

    if (await PermissionUtil.getLocationPermission()) {
      emit(state.copyWith(locationPermissionsGranted: true));
    }
    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshBalance(),
      refreshGatewaysLocations(),
      refreshGatewaysRevenue(),
      refreshStakedAmount(),
      refreshTotalRevenue(),
    ]);
  }

  Future<void> refreshBalance() async {
    emit(state.copyWith(balance: state.balance.withLoading()));
    try {
      final balanceData = await supernodeRepository.wallet.balance({
        'userId': user.userId,
        'orgId': orgId,
        'currency': '',
      });
      final value = Tools.convertDouble(balanceData['balance']);
      emit(state.copyWith(balance: Wrap(value)));
      homeCubit.saveCache('balance', value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(balance: state.balance.withError(e)));
    }
  }

  Future<void> refreshGatewaysRevenue() async {
    emit(state.copyWith(gatewaysRevenue: state.gatewaysRevenue.withLoading()));
    try {
      final gatewaysRevenueData =
          await supernodeRepository.wallet.miningIncome({
        'userId': user.userId,
        'orgId': orgId,
        'currency': '',
      });
      final value = Tools.convertDouble(gatewaysRevenueData['miningIncome']);
      emit(state.copyWith(gatewaysRevenue: Wrap(value)));
      final valueUsd = await _convertUsd(value);
      emit(state.copyWith(gatewaysRevenueUsd: Wrap(valueUsd)));
      homeCubit.saveCache('miningIncome', value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(gatewaysRevenue: state.gatewaysRevenue.withError(e)));
    }
  }

  Future<void> refreshStakedAmount() async {
    emit(state.copyWith(stakedAmount: state.stakedAmount.withLoading()));
    try {
      final res = await supernodeRepository.stake.activestakes({
        'orgId': orgId,
      });

      double value = 0;
      if (res.containsKey('actStake') && res['actStake'] != null) {
        final list = res['actStake'] as List;
        var sum = Decimal.zero;
        for (final stake in list) {
          final stakeAmount = Decimal.parse(stake['amount']);
          sum += stakeAmount;
        }
        value = sum.toDouble();
      }

      emit(state.copyWith(stakedAmount: Wrap(value)));
      homeCubit.saveCache('stakedAmount', value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(stakedAmount: state.stakedAmount.withError(e)));
    }
  }

  Future<void> refreshTotalRevenue() async {
    emit(state.copyWith(totalRevenue: state.totalRevenue.withLoading()));
    try {
      final res = await supernodeRepository.stake.revenue({
        'orgId': orgId,
        'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String()
      });

      final value = Tools.convertDouble(res['amount']);

      emit(state.copyWith(totalRevenue: Wrap(value)));
      homeCubit.saveCache('totalRevenue', value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(totalRevenue: state.totalRevenue.withError(e)));
    }
  }

  Future<void> refreshGatewaysLocations() async {
    List geojsonList = [];

    //local data
    geojsonList = await supernodeRepository.gatewaysLocation.listFromLocal();
    Map localGeojsonMap = cacheRepository.loadUserData('geojson');
    localGeojsonMap ??= {};

    if (localGeojsonMap['data'] != null && localGeojsonMap['data'].length > 0) {
      geojsonList.addAll(localGeojsonMap['data']);
    }

    emit(state.copyWith(geojsonList: state.geojsonList));
  }

  Future<double> _convertUsd(double value) async {
    final data = await supernodeRepository.wallet.convertUSD({
      'userId': user.userId,
      'orgId': orgId,
      'currency': '',
      'mxcPrice': '${value == 0.0 ? value.toInt() : value}'
    });
    return double.parse(data['mxcPrice']);
  }
}
