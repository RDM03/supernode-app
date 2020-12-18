import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/demo/dhx_dao.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/settings_page/state.dart';
import 'action.dart';
import 'state.dart';

Effect<ListCouncilsState> buildEffect() {
  return combineEffects(<Object, Effect<ListCouncilsState>>{
    Lifecycle.initState: _onInitState,
  });
}

DhxDao _buildDhxDao(Context<ListCouncilsState> ctx) =>
    ctx.state.isDemo ? DemoDhxDao() : DhxDao();

void _onInitState(Action action, Context<ListCouncilsState> ctx) {
  _listCouncils(ctx);
}

Future<void> _listCouncils(Context<ListCouncilsState> ctx) async {
  SettingsState settingsData = GlobalStore.store.getState().settings;
  final selectedOrgId = settingsData.selectedOrganizationId;
  DhxDao dao = _buildDhxDao(ctx);
  var councils = await dao.listCouncils();
  var stakes = await dao.listStakes(organizationId: selectedOrgId);
  final councilsMap =
      Map<String, Council>.fromIterable(councils, key: (k) => k.id);
  final joinedCouncilIds = stakes.map((e) => e.councilId).toSet();
  final joinedCouncils = joinedCouncilIds.map((c) => councilsMap[c]).toList();
  ctx.dispatch(ListCouncilsActionCreator.councils(councils, joinedCouncils));
}
