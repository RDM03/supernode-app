import 'demo.dart';
import '../withdraw.dart';

class DemoWithdrawDao extends DemoDao implements WithdrawDao {
  @override
  Future fee() {
    return Future.value({"withdrawFee": 0});
  }

  @override
  Future<List<WithdrawHistoryEntity>> history(Map data) {
    return Future.value({
      "count": "string",
      "withdrawHistory": [
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0xe064580cf18aa356cfbf0a3a58c6650975cacf2e329887979d79937b8083092e",
          "denyComment": "",
          "amount": "-60",
          "timestamp": "2020-04-30T14:59:12Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0x26a208e09c35f58a8110fd28b78ae311938cba048bf2da81dd6b4e8a5f07d544",
          "denyComment": "",
          "amount": "-80",
          "timestamp": "2020-04-30T20:01:28Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0xcf74d2054d4c4d7e9622aab3f930de4f04181f31fedb26a1eff6b40352cd9f74",
          "denyComment": "",
          "amount": "-40",
          "timestamp": "2020-05-18T15:49:59Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0x49138da2e0bb4decbb4e2f0e7f62da1abd99f0e3883d4c620b0075c82a184aed",
          "denyComment": "",
          "amount": "-40",
          "timestamp": "2020-05-25T15:40:42Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-05-27T16:14:08Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0xfa178b233fdbc2d53a4c26ceec87767fcc8bbb63ca62af6137973b15c118348b",
          "denyComment": "",
          "amount": "-40",
          "timestamp": "2020-06-03T13:05:10Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-04T09:13:18Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0x05d2162455e7bc1b62889bc30f72dd57593aa3f14359a10284cd40efbb0ed11e",
          "denyComment": "",
          "amount": "-28",
          "timestamp": "2020-06-04T10:37:01Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-04T14:23:14Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-04T15:30:03Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-05T09:11:51Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-05T09:47:12Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-05T16:59:03Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-09T09:39:52Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-09T11:37:41Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-09T14:13:07Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-10T16:19:13Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-30T16:03:31Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-06-30T16:06:10Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-07-01T16:36:13Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "REJECTED",
          "txHash": "",
          "denyComment": "",
          "amount": "0",
          "timestamp": "2020-07-16T09:19:57Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "COMPLETED",
          "txHash":
              "0xa45e8708bd17baebec712d38da67fa51aa4242d520e8bb02dc462ad8468a91a6",
          "denyComment": "",
          "amount": "-40",
          "timestamp": "2020-07-28T12:49:00Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "CREATED",
          "txHash": "",
          "denyComment": "",
          "amount": "-40",
          "timestamp": "2020-07-29T11:33:33Z",
          "withdrawFee": "20"
        },
        {
          "txStatus": "CREATED",
          "txHash": "",
          "denyComment": "",
          "amount": "-45",
          "timestamp": "2020-07-29T12:06:54Z",
          "withdrawFee": "20"
        }
      ]
    }).then((value) => (value['withdrawHistory'] as List)
        .map((e) => WithdrawHistoryEntity.fromMap(e))
        .toList());
  }

  @override
  Future withdraw(Map data) {
    return Future.value({"status": true});
  }
}
