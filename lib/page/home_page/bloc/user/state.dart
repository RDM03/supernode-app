import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/page/supernode_repository.dart';

part 'state.freezed.dart';

class Wrap<T> {
  final T value;
  final bool loading;
  final dynamic error;

  const Wrap(
    this.value, {
    this.loading = false,
    this.error,
  }) : assert(!loading || (loading && error == null),
            'Error cannot be set when loading == true');

  const Wrap.pending() : this(null, loading: true);

  Wrap<T> withError(dynamic error) => Wrap(
        value,
        loading: false,
        error: error,
      );

  Wrap<T> withValue(T value) => Wrap(
        value,
        loading: false,
        error: null,
      );

  Wrap<T> withLoading() => Wrap(
        value,
        loading: true,
        error: null,
      );

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Wrap<T> &&
        o.value == value &&
        o.loading == loading &&
        o.error == error;
  }

  @override
  int get hashCode => value.hashCode ^ loading.hashCode ^ error.hashCode;
}

@freezed
abstract class UserState with _$UserState {
  factory UserState({
    @required String username,
    @required String userId,
    @required String orgId,
    List<dynamic>
        geojsonList, // RETHINK.TODO If anyone can remove dynamic, please do it
    @Default(Wrap.pending()) Wrap<double> balance,
    @Default(Wrap.pending()) Wrap<double> stakedAmount,
    @Default(Wrap.pending()) Wrap<double> lockedAmount,
    @Default(Wrap.pending()) Wrap<double> gatewaysRevenue,
    @Default(Wrap.pending()) Wrap<double> gatewaysRevenueUsd,
    @Default(Wrap.pending()) Wrap<double> devicesRevenue,
    @Default(Wrap.pending()) Wrap<double> devicesRevenueUsd,
    @Default(Wrap.pending()) Wrap<double> totalRevenue,
    @Default(Wrap.pending()) Wrap<int> gatewaysTotal,
    @Default(Wrap.pending()) Wrap<int> devicesTotal,
  }) = _UserState;
}

class UserCubit extends Cubit<UserState> {
  UserCubit({
    String username,
    String userId,
    String orgId,
    this.supernodeRepository,
  }) : super(UserState(
          username: username, // RETHINK.TODO
          userId: userId,
          orgId: orgId,
        ));

  final SupernodeRepository supernodeRepository;

  Future<void> initState() async {
    var data = LocalStorageDao.loadUserData('user_${state.username}');
    data ??= {};

    final newState = state.copyWith(
      balance: Wrap(data['balance'], loading: true),
      gatewaysRevenue: Wrap(data['miningIncome'], loading: true),
      stakedAmount: Wrap(data['stakedAmount'], loading: true),
      totalRevenue: Wrap(data['totalRevenue'], loading: true),
      gatewaysTotal: Wrap(data['gatewaysTotal'], loading: true),
      gatewaysRevenueUsd: Wrap(data['usd_gateway'], loading: true),
    );

    emit(newState);
    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshBalance(),
      refreshGateways(),
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
        'userId': state.userId,
        'orgId': state.orgId,
        'currency': '',
      });
      final value = balanceData['balance'];
      emit(state.copyWith(balance: Wrap(value)));
      _saveCache('balance', value);
    } catch (e) {
      emit(state.copyWith(balance: state.balance.withError(e)));
    }
  }

  Future<void> refreshGatewaysRevenue() async {
    emit(state.copyWith(gatewaysRevenue: state.gatewaysRevenue.withLoading()));
    try {
      final gatewaysRevenueData =
          await supernodeRepository.wallet.miningIncome({
        'userId': state.userId,
        'orgId': state.orgId,
        'currency': '',
      });
      final value = gatewaysRevenueData['miningIncome'];
      emit(state.copyWith(gatewaysRevenue: Wrap(value)));
      final valueUsd = await _convertUsd(value);
      emit(state.copyWith(gatewaysRevenueUsd: Wrap(valueUsd)));
      _saveCache('miningIncome', value);
    } catch (e) {
      emit(state.copyWith(gatewaysRevenue: state.gatewaysRevenue.withError(e)));
    }
  }

  Future<void> refreshStakedAmount() async {
    emit(state.copyWith(stakedAmount: state.stakedAmount.withLoading()));
    try {
      final res = await supernodeRepository.stake.activestakes({
        'orgId': state.orgId,
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
      _saveCache('stakedAmount', value);
    } catch (e) {
      emit(state.copyWith(stakedAmount: state.stakedAmount.withError(e)));
    }
  }

  Future<void> refreshGateways() async {
    emit(state.copyWith(gatewaysTotal: state.gatewaysTotal.withLoading()));
    try {
      final res = await supernodeRepository.gateways
          .list({"organizationID": state.orgId, "offset": 0, "limit": 10});

      int total = int.parse(res['totalCount']);

      emit(state.copyWith(gatewaysTotal: Wrap(total)));
      _saveCache('gatewaysTotal', total);
    } catch (e) {
      emit(state.copyWith(gatewaysTotal: state.gatewaysTotal.withError(e)));
    }
  }

  Future<void> refreshTotalRevenue() async {
    emit(state.copyWith(totalRevenue: state.totalRevenue.withLoading()));
    try {
      final res = await supernodeRepository.stake.revenue({
        'orgId': state.orgId,
        'till': DateTime.now().add(Duration(days: 1)).toUtc().toIso8601String()
      });

      final value = Tools.convertDouble(res['amount']);

      emit(state.copyWith(totalRevenue: Wrap(value)));
      _saveCache('totalRevenue', value);
    } catch (e) {
      emit(state.copyWith(totalRevenue: state.totalRevenue.withError(e)));
    }
  }

  Future<void> refreshGatewaysLocations() async {
    List geojsonList = [];

    //local data
    geojsonList = await supernodeRepository.gatewaysLocation.listFromLocal();
    Map localGeojsonMap = LocalStorageDao.loadUserData('geojson');
    localGeojsonMap ??= {};

    if (localGeojsonMap['data'] != null && localGeojsonMap['data'].length > 0) {
      geojsonList.addAll(localGeojsonMap['data']);
    }

    emit(state.copyWith(geojsonList: state.geojsonList));
  }

  Future<double> _convertUsd(double value) async {
    final data = await supernodeRepository.wallet.convertUSD({
      'userId': state.userId,
      'orgId': state.orgId,
      'currency': '',
      'mxcPrice': '${value == 0.0 ? value.toInt() : value}'
    });
    return double.parse(data['mxcPrice']);
  }

  void _saveCache(String key, dynamic value) {
    LocalStorageDao.saveUserData('user_${state.username}', {key: value});
  }
}
