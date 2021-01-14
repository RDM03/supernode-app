import '../topup.model.dart';
import 'demo.dart';
import '../topup.dart';

class DemoTopupDao extends DemoDao implements TopupDao {
  @override
  Future account(Map data) {
    return Future.value({"activeAccount": "0x00000000000000"});
  }

  @override
  Future<List<TopupEntity>> history(Map data) {
    return Future.value({
      "count": "100",
      "topupHistory": [
        {
          "txHash":
              "0xb4ba1aa0a2133cdaece522fe7965c3225c2ccab8402250693563d4d38af57771",
          "timestamp": "2020-04-22T10:57:00Z",
          "amount": "100"
        },
        {
          "txHash":
              "0xd702c218a1f3e6249842ce25add6662a4d3069701cd63ee2c96704c70932c333",
          "timestamp": "2020-04-22T11:00:50Z",
          "amount": "20"
        },
        {
          "txHash":
              "0x3d24f8f19851040e3693f9b7cc106bf2a66f0073646d71e24ce0cf9be705fc5a",
          "timestamp": "2020-05-18T15:56:35Z",
          "amount": "20"
        },
        {
          "txHash":
              "0xc92119d43d3a4769842af0f67414f33ce14457fffccfc4640158fd81729b5a77",
          "timestamp": "2020-07-29T12:06:06Z",
          "amount": "20"
        }
      ]
    }).then((value) => (value['topupHistory'] as List)
        .map((e) => TopupEntity.fromMap(e))
        .toList());
  }
}
