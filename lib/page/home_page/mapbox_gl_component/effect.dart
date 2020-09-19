import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/dao.dart';
import 'package:supernodeapp/common/daos/gateways_dao.dart';
import 'package:supernodeapp/common/daos/gateways_location_dao.dart';
import 'package:supernodeapp/common/daos/local_storage_dao.dart';
import 'package:supernodeapp/data/super_node_bean.dart';
import 'package:supernodeapp/global_store/store.dart';
import 'package:supernodeapp/page/home_page/action.dart';

import 'action.dart';
import 'state.dart';

Effect<MapboxGlState> buildEffect() {
  return combineEffects(<Object, Effect<MapboxGlState>>{
    Lifecycle.initState: _initState,
  });
}

void _initState(Action action, Context<MapboxGlState> ctx) {
  _gatewaysLocationsFromRemote(ctx);
}


Future<void> _gatewaysLocationsFromRemote(Context<MapboxGlState> ctx) async {
  Map<String, List<SuperNodeBean>> superNodes = GlobalStore.state.superModel.superNodesByCountry;
  GatewaysLocationDao gatewayLocationDao = GatewaysLocationDao();
  List geojsonList = [];
  List allGeojsonList = [];

  //remote data
  Dao dao = Dao();
  List superNodesKeys = superNodes.keys.toList();

  for(int i = 0;i < superNodesKeys.length;i++){
    String key = superNodesKeys[i];
    if(key.toLowerCase() == 'test'){
      Map localGeojsonMap = LocalStorageDao.loadUserData('geojson');

      if((localGeojsonMap['data'] == null && geojsonList.length > 0) || (localGeojsonMap['data'] != null && localGeojsonMap['data'].length > 0 && geojsonList.length > 0 && localGeojsonMap['data'].length != geojsonList.length)){
        LocalStorageDao.saveUserData('geojson', 'data', geojsonList);
        
        allGeojsonList = await gatewayLocationDao.listFromLocal();
        allGeojsonList.addAll(geojsonList);
        ctx.dispatch(HomeActionCreator.geojsonList(allGeojsonList));
      }

      return;
    }

    List nodes = superNodes[key];
    for(int j = 0;j < nodes.length;j++){
      if(nodes[j].region.toLowerCase() != 'test'){
        print(nodes[j].url + GatewaysApi.locations);
        var res = await dao.get(
          url: nodes[j].url + GatewaysApi.locations
        );

        //the link of ausn.matchx.io returns null
        if(res != null && res['result'] != null && res['result'].length > 0){
          List geojsonRes = gatewayLocationDao.geojsonList(res['result']);
          geojsonList.addAll(geojsonRes);
        }

      }
    }
  }
}