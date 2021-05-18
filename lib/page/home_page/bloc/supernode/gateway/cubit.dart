import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'parser.dart';

import 'state.dart';

class GatewayCubit extends Cubit<GatewayState> {
  final Map<int, Comparator<GatewayItem>> sortGatewaysFuntions = {
    1: (a, b) => a.miningFuelHealth.compareTo(b.miningFuelHealth),
    2: (a, b) => b.miningFuelHealth.compareTo(a.miningFuelHealth),
    3: (a, b) => a.health.compareTo(b.health),
    4: (a, b) => b.health.compareTo(a.health),
  };

  GatewayCubit({
    this.homeCubit,
    this.supernodeRepository,
    this.orgId,
  }) : super(GatewayState());

  final HomeCubit homeCubit;
  final SupernodeRepository supernodeRepository;
  final String orgId;

  Future<void> initState() async {
    var data = homeCubit.loadSNCache();

    final newState = state.copyWith(
      gatewaysTotal: Wrap(data['gatewaysTotal']?.toInt(), loading: true),
    );

    emit(newState);
    await refresh();
  }

  Future<void> refresh() async {
    await Future.wait([
      refreshGateways(),
    ]);
  }

  Future<void> refreshGateways() async {
    emit(state.copyWith(
      gatewaysTotal: state.gatewaysTotal.withLoading(),
      gateways: state.gateways.withLoading(),
      health: state.health.withLoading(),
      uptimeHealth: state.uptimeHealth.withLoading(),
      miningFuelHealth: state.miningFuelHealth.withLoading(),
      miningFuel: state.miningFuel.withLoading(),
      miningFuelMax: state.miningFuelMax.withLoading(),
    ));

    //Miner Health
    List<MinerHealthResponse> listMinersHealth = [];
    try {
      listMinersHealth = await supernodeRepository.gateways.minerHealth({"orgId": orgId});

      double avgHealth = 0;
      double avgUptimeHealth = 0;
      double avgMiningFuelHealth = 0;
      double sumMiningFuel = 0;
      double sumMiningFuelMax = 0;

      for (MinerHealthResponse minerHealth in listMinersHealth) {
        if (minerHealth.id == 'health_score') {
          avgHealth = minerHealth.health;
          avgUptimeHealth = minerHealth.uptimeHealth;
          avgMiningFuelHealth = minerHealth.miningFuelHealth;
        } else {
          sumMiningFuel += minerHealth.miningFuel;
          sumMiningFuelMax += minerHealth.miningFuelMax;
        }
      }

      emit(
        state.copyWith(
          health: Wrap(avgHealth),
          uptimeHealth: Wrap(avgUptimeHealth),
          miningFuelHealth: Wrap(avgMiningFuelHealth),
          miningFuel: Wrap(sumMiningFuel),
          miningFuelMax: Wrap(sumMiningFuelMax),
        ),
      );
      //TODO homeCubit.saveSNCache('gatewaysTotal', total);
    } catch (e, s) {
      logger.e('minerHealth error', e, s);
      emit(state.copyWith(
        health: state.health.withError(e),
        uptimeHealth: state.uptimeHealth.withError(e),
        miningFuelHealth: state.miningFuelHealth.withError(e),
        miningFuel: state.miningFuel.withError(e),
        miningFuelMax: state.miningFuelMax.withError(e),
      ));
    }

    //Gateways
    try {
      final res = await supernodeRepository.gateways
          .list({"organizationID": orgId, "offset": 0, "limit": 10});

      int total = int.parse(res['totalCount']);
      final List<GatewayItem> gateways = parseGateways(res, listMinersHealth);

      emit(
        state.copyWith(
          gatewaysTotal: Wrap(total),
          gateways: Wrap(gateways),
        ),
      );
      homeCubit.saveSNCache('gatewaysTotal', total);
    } catch (e, s) {
      logger.e('refresh error', e, s);
      emit(state.copyWith(
        gatewaysTotal: state.gatewaysTotal.withError(e),
        gateways: state.gateways.withError(e),
      ));
    }
  }

  Future<void> deleteGateway(String gatewayId) async {
    try {
      await supernodeRepository.gateways.deleteGateway(gatewayId);

      refreshGateways();
    } catch (e, s) {
      logger.e('rdelete gateway error', e, s);
    }
  }

  void sortGateways(int index) {
    if (state.gateways.value == null)
      return;

    emit(state.copyWith(gateways: state.gateways.withLoading()));
    final List<GatewayItem> gatewaysList = state.gateways.value;
    if (index >= sortGatewaysFuntions.keys.reduce(min) && index <= sortGatewaysFuntions.keys.reduce(max))
      gatewaysList.sort(sortGatewaysFuntions[index]);
    emit(state.copyWith(gateways: Wrap(gatewaysList)));
  }
}
