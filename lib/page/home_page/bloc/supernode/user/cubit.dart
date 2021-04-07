import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/permission_utils.dart';
import 'package:supernodeapp/common/repositories/cache_repository.dart';
import 'package:supernodeapp/common/repositories/shared/dao/supernode.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.model.dart';
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
    this.session,
    this.orgId,
    this.homeCubit,
  }) : super(SupernodeUserState(
          username: session.username,
        ));

  final HomeCubit homeCubit;
  final SupernodeSession session;
  final String orgId;
  final SupernodeRepository supernodeRepository;
  final CacheRepository cacheRepository;

  Future<void> initState() async {
    var data = homeCubit.loadSNCache();

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

    // get geojsonList from cache
    List geojsonList = [];
    geojsonList = await supernodeRepository.gatewaysLocation.listFromLocal();
    Map localGeojsonMap = cacheRepository.loadUserData('geojson');
    localGeojsonMap ??= {};

    if (localGeojsonMap['data'] != null && localGeojsonMap['data'].length > 0) {
      geojsonList.addAll(localGeojsonMap['data']);
    }
    emit(state.copyWith(geojsonList: geojsonList));

    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshUser(),
      refreshBalance(),
      refreshGatewaysLocations(),
      refreshGatewaysRevenue(),
      refreshStakedAmount(),
      refreshTotalRevenue(),
    ]);
  }

  void removeWeChatUser() {
    emit(state.copyWith(weChatUser: null));
  }

  void removeShopifyUser() {
    emit(state.copyWith(shopifyUser: null));
  }

  Future<void> refreshUser() async {
    emit(state.copyWith(isAdmin: state.isAdmin.withLoading()));
    emit(state.copyWith(organizations: state.organizations.withLoading()));
    try {
      final profile = await supernodeRepository.user.profile();
      final email = profile.user.email;
      final isAdmin = profile.user.isAdmin;
      final organizations = profile.organizations;
      final wechatUser = profile.externalUserAccounts.firstWhere(
          (e) => e.service == ExternalUser.weChatService,
          orElse: () => null);
      final shopifyUser = profile.externalUserAccounts.firstWhere(
          (e) => e.service == ExternalUser.shopifyService,
          orElse: () => null);
      emit(state.copyWith(
        email: email,
        isAdmin: Wrap(isAdmin),
        organizations: Wrap(organizations),
        weChatUser: wechatUser,
        shopifyUser: shopifyUser,
      ));
      emit(state.copyWith(organizations: Wrap(organizations)));
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(isAdmin: state.isAdmin.withError(e)));
      emit(state.copyWith(organizations: state.organizations.withError(e)));
    }
  }

  Future<void> refreshBalance() async {
    emit(state.copyWith(balance: state.balance.withLoading()));
    try {
      final balanceData = await supernodeRepository.wallet.balance({
        'userId': session.userId,
        'orgId': orgId,
        'currency': '',
      });
      final value = Tools.convertDouble(balanceData['balance']);
      emit(state.copyWith(balance: Wrap(value)));
      homeCubit.saveSNCache('balance', value);
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
        'userId': session.userId,
        'orgId': orgId,
        'currency': '',
      });
      final value = Tools.convertDouble(gatewaysRevenueData['miningIncome']);
      emit(state.copyWith(gatewaysRevenue: Wrap(value)));
      final valueUsd = await _convertUsd(value);
      emit(state.copyWith(gatewaysRevenueUsd: Wrap(valueUsd)));
      homeCubit.saveSNCache('miningIncome', value);
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
      homeCubit.saveSNCache('stakedAmount', value);
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
      homeCubit.saveSNCache('totalRevenue', value);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(totalRevenue: state.totalRevenue.withError(e)));
    }
  }

  Future<void> refreshGatewaysLocations() async {
    final supernodesMap = await supernodeRepository.loadSupernodes();
    final supernodes = <String, List<Supernode>>{};
    List geojsonList = [];
    List allGeojsonList = [];

    for (final s in supernodesMap.values) {
      if (supernodes[s.region] == null) supernodes[s.region] = [];
      supernodes[s.region].add(s);
    }
    List superNodesKeys = supernodes.keys.toList();

    for (int i = 0; i < superNodesKeys.length; i++) {
      String key = superNodesKeys[i];
      if (key.toLowerCase() == 'test') {
        Map localGeojsonMap = homeCubit.loadSNCache('geojson');
        localGeojsonMap ??= {};

        if ((localGeojsonMap['data'] == null && geojsonList.length > 0) ||
            (localGeojsonMap['data'] != null &&
                localGeojsonMap['data'].length > 0 &&
                geojsonList.length > 0 &&
                localGeojsonMap['data'].length != geojsonList.length)) {
          homeCubit.saveSNCache('data', geojsonList, userKey: 'geojson');

          allGeojsonList =
              await supernodeRepository.gatewaysLocation.listFromLocal();
          allGeojsonList.addAll(geojsonList);
          emit(state.copyWith(geojsonList: allGeojsonList));
        }

        return;
      }

      // List nodes = supernodes[key];
      // for (int j = 0; j < nodes.length; j++) {
      //   if (nodes[j].region.toLowerCase() != 'test') {
      //     var res = await supernodeRepository.client
      //         .get(url: nodes[j].url + GatewaysApi.locations);

      //     if (res != null &&
      //         res['result'] != null &&
      //         res['result'].length > 0) {
      //       List geojsonRes =
      //           supernodeRepository.gatewaysLocation.geojsonList(res['result']);
      //       geojsonList.addAll(geojsonRes);
      //     }
      //   }
      // }
    }
  }

  Future<double> _convertUsd(double value) async {
    final data = await supernodeRepository.wallet.convertUSD({
      'userId': session.userId,
      'orgId': orgId,
      'currency': '',
      'mxcPrice': '${value == 0.0 ? value.toInt() : value}'
    });
    return double.parse(data['mxcPrice']);
  }
}
