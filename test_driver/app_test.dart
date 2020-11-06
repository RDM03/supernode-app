import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:dotenv/dotenv.dart' show load;

import 'help_bubble_test.dart' show helpBubbleTest;
import 'login_test.dart' show loginPageTests;
import 'logout_test.dart' show logoutTest;
import 'stake_test.dart' show stakingTest;

import 'add_miner_test.dart' show addMinerTest;
import 'delete_miner_test.dart' show deleteMinerTest;

void main() {
  group('Supernode App', () {

    FlutterDriver driver;


    test('check flutter driver health', () async {
      Health health = await driver.checkHealth();
      print(health.status);
    });
    load();
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });
    loginPageTests('MXCbuild');
    stakingTest();
    helpBubbleTest();
    addMinerTest();
    deleteMinerTest();
    logoutTest();

  });


}