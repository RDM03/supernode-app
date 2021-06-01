import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';
import 'login_test.dart';

Future<void> dhxWalletPageTests() {
  Future<void> goToDhxDashboard(WidgetTester tester) async {
    if (!isExisted('dhxDashboard')) {
      if (!isExisted('addTokenTitle')) {
        await loginTest(tester);
      }

      await pumpAndTap(tester, 'addTokenTitle');
      await pumpAndTap(tester, 'addDHX');
    }

    await delay(2);
    await pumpAndTap(tester, 'dhxDashboard');
  }

  group('DHX Wallet', () {
    testWidgets('can get top-up information', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await goToDhxDashboard(tester);
      await pumpAndTap(tester, 'dhxDeposit');

      await delay(3);
      await pumpUntilFound(tester, findByKey('ethAddressTopUp'));

      if (getEnv('ENVIRONMENT') == 'test') {
        //this is the eth address of text@mxc.org.
        expect(findByText(mxcTestDhxAddress), findsOneWidget);
      }
    }, timeout: timeout());

    testWidgets('can submit withdraw request', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await delay(3);
      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxWithdraw', firstWidget: true);

      await delay(3);
      await pumpAndEnterText(tester, 'withdrawAmountInput', '1');
      await pumpAndEnterText(tester, 'sendToAddressInput', mxcTestDhxAddress);
      await pumpAndTap(tester, 'requestWithdrawButton');

      await delay(32);
      await pumpAndTap(tester, 'submitButton');

      // THe following page need the six digit the Verification Code,
      // do not know to how to get it.
      // I suggest that it can value fixed the Verification Code for the test.
    }, timeout: timeout());

    // testWidgets('can delete miner', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();

    //   await delay(3);

    // }, timeout: timeout());

    testWidgets('can lock mxc', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxMine', firstWidget: true);
      await pumpAndTap(tester, 'actionKey');

      await pumpAndTap(tester, 'lockMxcButton', firstWidget: true);
      await pumpAndTap(tester, 'lock3');
      await delay(2);

      await pumpAndEnterText(tester, 'lockAmount', '1');
      await pumpAndTap(tester, 'submitButton');
      await pumpAndTap(tester, 'councilItem#0');
      await pumpAndTap(tester, 'submitButton1');
      await delay(32);
      await pumpAndTap(tester, 'submitButton2');

      //faceId permission
      // delay(3);
      // expect(findByKey('congratsMiningText'), findsOneWidget);
    }, timeout: timeout());

    testWidgets('can bond mxc', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxMine', firstWidget: true);
      await pumpAndTap(tester, 'actionKey');

      await pumpAndTap(tester, 'bondButton', firstWidget: true);
      await pumpAndEnterText(tester, 'valueTextField', '1');
      await pumpAndTap(tester, 'confirmButton');

      await delay(2);
      await pumpAndTap(tester, 'bottom_dialog_item2');

      await delay(2);
      expect(findByKey('successIcon_true'), findsOneWidget);
      await pumpAndTap(tester, 'doneButton');
    }, timeout: timeout());

    testWidgets('can unbond mxc', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxMine', firstWidget: true);
      await pumpAndTap(tester, 'actionKey');

      await pumpAndTap(tester, 'unbondButton', firstWidget: true);
      await pumpAndEnterText(tester, 'valueTextField', '1');
      await pumpAndTap(tester, 'confirmButton');

      await delay(2);
      await pumpAndTap(tester, 'bottom_dialog_item2');

      await delay(2);
      expect(findByKey('successIcon_true'), findsOneWidget);
      await pumpAndTap(tester, 'doneButton');
    }, timeout: timeout());

    testWidgets('can simulate DHX mining', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxMine', firstWidget: true);
      await pumpAndTap(tester, 'actionKey');

      await pumpAndTap(tester, 'simulateMiningButton', firstWidget: true);
      await delay(2);

      final Finder mxcLockedFinder = findByKey('valueSlider').first;
      await tester.drag(mxcLockedFinder, Offset(20, 0));
      await delay(2);

      final Finder monthsFinder = findByKey('monthsSlider').first;
      await tester.drag(monthsFinder, Offset(30, 0));
      await delay(2);

      final Finder minersAmountFinder = findByKey('minersValueEditor');
      await tester.enterText(minersAmountFinder, '1');
      await delay(3);
    }, timeout: timeout());

    testWidgets('can see new lock in mining income',
        (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await delay(3);
      if (!isExisted('dhxDashboard')) {
        if (!isExisted('addTokenTitle')) {
          await loginTest(tester);
        }

        await pumpAndTap(tester, 'addTokenTitle');
        await pumpAndTap(tester, 'addDHX');
      }

      await delay(2);
      await pumpAndTap(tester, 'dhxDashboard');

      expect(findByKey('lockAmountRow'), findsOneWidget);
    }, timeout: timeout());

    Future<void> simulateMining(WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxMine');
      await pumpAndTap(tester, 'actionKey');

      await pumpAndTap(tester, 'simulateMiningButton');
      await delay(2);

      await tester.dragUntilVisible(findByKey('monthsSlider'),
          findByKey('boostMpowerButton'), Offset(0, 5));
      await delay(2);
      await pumpAndTap(tester, 'boostMpowerButton');
    }

    testWidgets('can boost-up mPower', (WidgetTester tester) async {
      simulateMining(tester);

      await delay(2);
      expect(findByKey('infoDialog'), findsOneWidget);
    }, timeout: timeout());

    testWidgets('can boost-up mPower to lock', (WidgetTester tester) async {
      await simulateMining(tester);

      await pumpAndTap(tester, 'lockPageTap');

      expect(findByKey('lock24'), findsOneWidget);
    }, timeout: timeout());

    testWidgets('can boost-up mPower to shop', (WidgetTester tester) async {
      await simulateMining(tester);

      await pumpAndTap(tester, 'shopM2proTap');

      delay(5);
      expect(await canLaunch(shopM2proURL), true);
    }, timeout: timeout());

    testWidgets('can boost-up mPower to learn more',
        (WidgetTester tester) async {
      await simulateMining(tester);

      await pumpAndTap(tester, 'tutorialTitleTap');

      await delay(2);
      expect(findByKey('tutorialPage1Title'), findsOneWidget);
    }, timeout: timeout());

    testWidgets('can view bonding history', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'bondingHistoryText');

      if (isExisted('dhx_stake_0')) {
        expect(findByKey('dhx_stake_0'), findsOneWidget);
      } else {
        expect(findByKey('noData'), findsOneWidget);
      }
    }, timeout: timeout());
  });
}
