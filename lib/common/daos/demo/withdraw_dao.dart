import 'package:supernodeapp/common/daos/app_dao.dart';
import 'package:supernodeapp/common/daos/demo/demo_dao.dart';

class DemoWithdrawDao extends DemoDao implements WithdrawDao {
  @override
  Future fee() {
    return Future.value({"withdrawFee": 0});
  }

  @override
  Future history(Map data) {
    return Future.value({
      "count": "string",
      "withdrawHistory": [
        {
          "amount": 0,
          "txSentTime": "2020-03-15T13:01:41.617Z",
          "txStatus": "Success",
          "txHash": "654321123456654321",
          "denyComment": "Success"
        },
        {
          "amount": 1,
          "txSentTime": "2020-05-15T13:01:41.617Z",
          "txStatus": "Fail",
          "txHash": "654321123456654321",
          "denyComment": "string"
        }
      ]
    });
  }

  @override
  Future withdraw(Map data) {
    return Future.value({"status": true});
  }
}
