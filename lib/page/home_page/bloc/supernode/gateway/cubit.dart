import 'package:bloc/bloc.dart';
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
    ));
    try {
      final res = await supernodeRepository.gateways
          .list({"organizationID": orgId, "offset": 0, "limit": 10});

      int total = int.parse(res['totalCount']);
      final gateways = parseGateways(res);

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
    final gateways = parseGateways(res);

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
