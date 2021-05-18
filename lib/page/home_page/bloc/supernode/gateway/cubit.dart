import 'package:bloc/bloc.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/gateways.model.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'package:supernodeapp/common/wrap.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'parser.dart';

import 'state.dart';

class GatewayCubit extends Cubit<GatewayState> {
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
      ageSeconds: state.ageSeconds.withLoading(),
      health: state.health.withLoading(),
      miningFuel: state.miningFuel.withLoading(),
      miningFuelHealth: state.miningFuelHealth.withLoading(),
      miningFuelMax: state.miningFuelMax.withLoading(),
    ));

    //Miner Health
    List<MinerHealthResponse> listMinersHealth = [];
    try {
      listMinersHealth = await supernodeRepository.gateways.minerHealth({"orgId": orgId});

      double avgAgeSeconds = 0;
      double avgHealth = 0;
      double avgMiningFuel = 0;
      double avgMiningFuelHealth = 0;
      double avgMiningFuelMax = 0;

      for (MinerHealthResponse minerHealth in listMinersHealth) {
        avgAgeSeconds += minerHealth.ageSeconds;
        avgHealth += minerHealth.health;
        avgMiningFuel += minerHealth.miningFuel;
        avgMiningFuelMax += minerHealth.miningFuelMax;
      }

      avgAgeSeconds /= listMinersHealth.length;
      avgHealth /= listMinersHealth.length;
      avgMiningFuel /= listMinersHealth.length;
      avgMiningFuelMax /= listMinersHealth.length;
      avgMiningFuelHealth = avgMiningFuel / avgMiningFuelMax;

      emit(
        state.copyWith(
          ageSeconds: Wrap(avgAgeSeconds.round()),
          health: Wrap(avgHealth),
          miningFuel: Wrap(avgMiningFuel),
          miningFuelHealth: Wrap(avgMiningFuelHealth),
          miningFuelMax: Wrap(avgMiningFuelMax),
        ),
      );
      //TODO homeCubit.saveSNCache('gatewaysTotal', total);
    } catch (e, s) {
      logger.e('minerHealth error', e, s);
      emit(state.copyWith(
        ageSeconds: state.ageSeconds.withError(e),
        health: state.health.withError(e),
        miningFuel: state.miningFuel.withError(e),
        miningFuelHealth: state.miningFuelHealth.withError(e),
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

  Future<List<GatewayItem>> loadNextPage(int page) async {
    final res = await supernodeRepository.gateways
        .list({"organizationID": orgId, "offset": page, "limit": 10});

    final total = int.parse(res['totalCount']);
    final gateways = parseGateways(res, []);

    emit(
      state.copyWith(
        gatewaysTotal: Wrap(total),
        gateways: Wrap([...state.gateways.value, ...gateways]),
      ),
    );

    return gateways;
  }

  Future<void> deleteGateway(String gatewayId) async {
    try {
      await supernodeRepository.gateways.deleteGateway(gatewayId);

      refreshGateways();
    } catch (e, s) {
      logger.e('rdelete gateway error', e, s);
    }
  }

}
