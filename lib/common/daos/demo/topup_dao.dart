import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';

class DemoTopupDao extends DemoDao implements TopupDao {
  @override
  Future account(Map data) {
    return Future.value({"activeAccount": "string"});
  }

  @override
  Future history(Map data) {
    return Future.value({
      "count": "100",
      "topupHistory": [
        {
          "amount": 0,
          "createdAt": "2020-04-15T13:01:41.617Z",
          "txHash": "12345612346123456",
        },
        {
          "amount": 10,
          "createdAt": "2020-04-15T13:01:41.617Z",
          "txHash": "12345612346123456",
        }
      ]
    });
  }
}
