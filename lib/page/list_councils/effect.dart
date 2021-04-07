import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';
import 'package:supernodeapp/common/repositories/supernode_repository.dart';
import 'action.dart';
import 'state.dart';

Effect<ListCouncilsState> buildEffect() {
  return combineEffects(<Object, Effect<ListCouncilsState>>{
    Lifecycle.initState: _onInitState,
  });
}

DhxDao _buildDhxDao(Context<ListCouncilsState> ctx) {
  return ctx.context.read<SupernodeRepository>().dhx;
}

void _onInitState(Action action, Context<ListCouncilsState> ctx) {
  _listCouncils(ctx);
}

Future<void> _listCouncils(Context<ListCouncilsState> ctx) async {
  DhxDao dao = _buildDhxDao(ctx);
  var councils = await dao.listCouncils();
  final councilsMap =
      Map<String, Council>.fromIterable(councils, key: (k) => k.id);
  final joinedCouncils =
      ctx.state.joinedCouncilsId.map((c) => councilsMap[c]).toList();
  ctx.dispatch(ListCouncilsActionCreator.councils(councils, joinedCouncils));
}
