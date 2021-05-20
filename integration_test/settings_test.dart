import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/common/utils/tools.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';
import 'login_test.dart';

Future<void> settingsTests(){

  Future<void> goToSuperNode(WidgetTester tester) async {
    await pumpAndTap(tester, 'settingsButton');
    await pumpAndTap(tester, 'manageAccountItem');
    await pumpAndTap(tester, 'superNodeItem');
  }
  group('DHX Wallet', () {
    testWidgets('can manage account supernodes', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await loginTest(tester);

      await goToSuperNode(tester);

      expect(findByKey('usernameText'), findsOneWidget);
    });

    Future<void> updateValue(WidgetTester tester, String inputkey, String value) async {
      await pumpAndEnterText(tester, inputkey, value);
      await pumpAndTap(tester, 'updateButton');
      await delay(2);
      
      expect(findByText(value).first, findsOneWidget);
    }

    testWidgets('can change username', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await goToSuperNode(tester);

      await updateValue(tester, 'usernameInput', 'test123');
      await updateValue(tester, 'usernameInput', getEnv('DRIVE_TESTING_USER'));
    });

    testWidgets('can change email', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await goToSuperNode(tester);

      await updateValue(tester, 'emailInput', 'user@mxc.org');
      await updateValue(tester, 'emailInput', getEnv('DRIVE_TESTING_USER'));
    });

    testWidgets('can change organization name', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await goToSuperNode(tester);

      await updateValue(tester, 'organizationNameInput', 'TestingAccount123');
      await updateValue(tester, 'organizationNameInput', 'TestingAccount');
    });


    testWidgets('can change display name', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await goToSuperNode(tester);

      await updateValue(tester, 'displayNameInput', 'TestingAccount123');
      await updateValue(tester, 'displayNameInput', 'TestingAccount12');
    });

    // testWidgets('can unbind WeChat', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();

    // });

    testWidgets('can enter app settings', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'settingsButton');
      await pumpAndTap(tester, 'appSettingsItem');

      await delay(2);
      expect(findByKey('appSettingsTitle'), findsOneWidget);
    });

    testWidgets('can change langauge', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'settingsButton');
      await pumpAndTap(tester, 'appSettingsItem');
      await pumpAndTap(tester, 'languageItem');

      await pumpAndTap(tester, 'en');
      expect(findByText('Language'), findsOneWidget);

      await pumpAndTap(tester, 'zh_Hans');
      expect(findByText('语言'), findsOneWidget);

      await pumpAndTap(tester, 'autoDetect');
    });

    // Flutter Test cannot interactive with the native widgets(Location and FaceId etc.).
    // testWidgets('can enable Face IDa / Biometric', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();

    // });

    // testWidgets('can disable Face ID / Biometric', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();

    // });

    testWidgets('can take screenshot', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'settingsButton');
      await pumpAndTap(tester, 'appSettingsItem');

      if( !isExisted('feedbackButton') ) {
        await pumpAndTap(tester, 'screenshotSwitch');
      }

      await delay(2);
      await pumpAndTap(tester, 'feedbackButton');

      // In the ios simulator, the app will crash when you take screenshot.
      // so it can not to run a test for taking screenshot.

      // delay(5);
      // await pumpAndEnterText(tester, 'feedbackTextfield', 'test: can take screenshot');

      // await pumpAndTap(tester, 'submit_feedback_button');

      // expect(findByKey('FeedbackResultPage'), findsOneWidget);
    });

    // In the ios simulator, the app will crash when you take screenshot.
    // so it can not to run a test for taking screenshot.
    // testWidgets('can submit screenshot feedback', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();

    //   await pumpAndTap(tester, 'sendFeedbackButton');
    //   await pumpAndTap(tester, 'ideaButton');
    // });

    testWidgets('can open address book', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'settingsButton');
      await pumpAndTap(tester, 'addressBookItem');

      expect(findByKey('AddressBookPage'), findsOneWidget);
    });

    testWidgets('can add new address', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'settingsButton');
      await pumpAndTap(tester, 'addressBookItem');
      await pumpAndTap(tester, 'navActionButton');

      await pumpAndEnterText(tester, 'addressTextField', mxcTestMxcAddress);
      await pumpAndEnterText(tester, 'nameTextField', getEnv('DRIVE_TESTING_USER'));
      await pumpAndEnterText(tester, 'memoTextField', 'test: can add new address');

      await pumpAndTap(tester, 'updateButton');

      await delay(2);
      expect(findByText(getEnv('DRIVE_TESTING_USER')), findsOneWidget);

      // detele as you add a test address.
      final Finder itemFinder = findByText(Tools.hideHalf(mxcTestMxcAddress));
      await tester.tap(itemFinder);
      await pumpAndTap(tester, 'deleteButton');
    });

  });
}