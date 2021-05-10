import 'package:flutter_test/flutter_test.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

Future<void> dhxWalletPageTests(){
  group('DHX Wallet', () {
    testWidgets('can pub run testget top-up information', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      bool hasLogin = isExisted('login');

      if (hasLogin) {
        await loginPageTests();
      }

      await delay(3);
      if (!isExisted('dhxDashboard')) {
        await pumpAndTap(tester, 'addTokenTitle');
        await pumpAndTap(tester, 'addDHX');
      }

      await delay(3);
      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxDeposit', firstWidget: true);

      await delay(3);
      await pumpUntilFound(tester, findByKey('ethAddressTopUp'));

      if (getEnv('ENVIRONMENT') == 'test') {
        //this is the eth address of text@mxc.org.
        expect(findByText(mxcTestEthAdress), findsOneWidget);
      }
    }, timeout: timeout());

    testWidgets('can submit withdraw request', (WidgetTester tester) async {
      await delay(5);
      await app.main();
      
      await delay(3);
      await pumpAndTap(tester, 'dhxDashboard');
      await pumpAndTap(tester, 'dhxWithdraw' , firstWidget: true);

      await delay(3);
      await pumpAndEnterText(tester, 'withdrawAmountInput','1');
      await pumpAndEnterText(tester, 'sendToAddressInput', mxcTestEthAdress);
      await pumpAndTap(tester, 'requestWithdrawButton');

    }, timeout: timeout());

    // testWidgets('can delete miner', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();
      
    //   await delay(3);

    // }, timeout: timeout());

  //   testWidgets('can lock mxc', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'actionKey');
  //     await delay(2);
  //     await pumpAndTap(tester, 'lockMxcButton' , firstWidget: true);
  //     await delay(2);
  //     await pumpAndTap(tester, 'lock3');
  //     await delay(2);
  //     await pumpAndEnterText(tester, 'lockAmount','1');
  //     await pumpAndTap(tester, 'submitButton1');
  //     await delay(2);
  //     await pumpAndTap(tester, 'councilItem#0');
  //     await delay(2);
  //     await pumpAndTap(tester, 'submitButton2');
  //     //faceId permission
  //     await delay(2);
  //     expect(findByKey('congratsMiningText'), findsOneWidget);

  //     await pumpAndTap(tester, 'submitButton');

  //   }, timeout: timeout());


  //   testWidgets('can bond mxc', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'bondButton' , firstWidget: true);
  //     await delay(2);
  //     await pumpAndEnterText(tester, 'valueTextField','1');

  //     await pumpAndTap(tester, 'confirmButton');
  //     await delay(2);
  //     await pumpAndTap(tester, 'bottom_dialog_item2');

  //     await delay(2);
  //     expect(findByKey('successIcon_true'), findsOneWidget);
  //     await pumpAndTap(tester, 'doneButton');

  //   }, timeout: timeout());

  //   testWidgets('can unbond mxc', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'unbondButton' , firstWidget: true);
  //     await delay(2);
  //     await pumpAndEnterText(tester, 'valueTextField','1');

  //     await pumpAndTap(tester, 'confirmButton');
  //     await delay(2);
  //     await pumpAndTap(tester, 'bottom_dialog_item2');

  //     await delay(2);
  //     expect(findByKey('successIcon_true'), findsOneWidget);
  //     await pumpAndTap(tester, 'doneButton');

  //   }, timeout: timeout());

  //   testWidgets('can simulate DHX mining', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'simulateMiningButton' , firstWidget: true);
  //     await delay(2);
  //     final Finder sliderFinder1 = findByKey('valueSlider').first;
  //     final Finder sliderFinder2 = findByKey('valueSlider').last;
  //     tester.drag(sliderFinder1, Offset(20, 0));
  //     tester.drag(sliderFinder2, Offset(30, 0));

  //     final Finder textfieldFinder1 = findByKey('valueTextField').first;
  //     final Finder textfieldFinder2 = findByKey('valueTextField').last;
  //     tester.enterText(textfieldFinder1, '1');
  //     tester.enterText(textfieldFinder2, '1');

  //   }, timeout: timeout());

  //   testWidgets('can see new lock in mining income', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     expect(findByKey('lockAmountRow'), findsOneWidget);

  //   }, timeout: timeout());

  //   testWidgets('can boost-up mPower', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'boostMpowerTap');

  //     expect(findByKey('IosStyleBottomDialog2'), findsOneWidget);
  //     tester.pageBack();

  //   }, timeout: timeout());

  //   testWidgets('can boost-up mPower to lock', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'boostMpowerTap');
  //     await delay(2);
  //     await pumpAndTap(tester, 'lockPageTap');

  //     await delay(3);
  //     expect(findByKey('lockMxcTitle'), findsOneWidget);
  //     tester.pageBack();

  //   }, timeout: timeout());

  //   testWidgets('can boost-up mPower to shop', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'boostMpowerTap');
  //     await delay(2);
  //     await pumpAndTap(tester, 'shopM2proTap');

  //     await delay(3);
  //     expect(canLaunch(shopM2proURL), true);
  //     tester.pageBack();
      
  //   }, timeout: timeout());

  //   testWidgets('can boost-up mPower to learn more', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'boostMpowerTap');
  //     await delay(2);
  //     await pumpAndTap(tester, 'tutorialTitleTap');

  //     await delay(3);
  //     expect(findByKey('tutorialPg2Title'), true);
  //     tester.pageBack();

  //   }, timeout: timeout());

  //   testWidgets('can view bonding history', (WidgetTester tester) async {
  //     await delay(5);
  //     await app.main();
      
  //     await delay(3);
  //     await pumpAndTap(tester, 'bondingHistoryText');

  //     if (isExisted('dhx_stake_0')) {
  //       expect(findByKey('dhx_stake_0'), findsOneWidget);
  //     } else {
  //       expect(findByKey('noData'), findsOneWidget);
  //     }

  //   }, timeout: timeout());

  });

}