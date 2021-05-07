import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

Future<void> settingsTests(){

  group('DHX Wallet', () {
    testWidgets('can manage account supernodes', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'settingsButton');
      await pumpAndTap(tester, 'superNodeItem');

      expect(findByKey('usernameText'), findsOneWidget);
    });

    void updateItem(WidgetTester tester, String inputkey, String value) async {
      await pumpAndEnterText(tester, inputkey, value);
      await pumpAndTap(tester, 'updateButton');
      await delay(3);
      
      expect(findByText(value), findsOneWidget);
    }

    testWidgets('can change username', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      updateItem(tester, 'usernameInput', 'test');
      updateItem(tester, 'usernameInput', getEnv('DRIVE_TESTING_USER'));
    });

    testWidgets('can change email', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      updateItem(tester, 'emailInput', 'user@mxc.org');
      updateItem(tester, 'emailInput', getEnv('DRIVE_TESTING_USER'));
    });

    testWidgets('can change organization name', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      updateItem(tester, 'organizationNameInput', 'TestingAccount1');
      updateItem(tester, 'organizationNameInput', 'TestingAccount');
    });


    testWidgets('can change display name', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      updateItem(tester, 'displayNameInput', 'TestingAccount2');
      updateItem(tester, 'displayNameInput', 'TestingAccount12');

      tester.pageBack();
      tester.pageBack();
    });

    // testWidgets('can unbind WeChat', (WidgetTester tester) async {
    //   await delay(5);
    //   await app.main();

    // });

    testWidgets('can enter app settings', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'appSettingsItem');

      delay(2);
      expect(findByKey('appSettingsTitle'), findsOneWidget);
    });

    testWidgets('can change langauge', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'languageItem');

      await pumpAndTap(tester, 'en');
      expect(findByText('Language'), findsOneWidget);

      await pumpAndTap(tester, 'zh_Hans');
      expect(findByText('语音'), findsOneWidget);

      await pumpAndTap(tester, 'autoDetect');

      tester.pageBack();
    });

    // testWidgets('can enable Face ID / Biometric', (WidgetTester tester) async {
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

      if( !isExisted('feedbackButton') ) {
        await pumpAndTap(tester, 'screenshotSwitch');
      }

      await pumpAndTap(tester, 'feedbackButton');
      await pumpAndEnterText(tester, 'feedbackTextfield', 'test: can take screenshot');

      await pumpAndTap(tester, 'submit_feedback_button');

      expect(findByKey('FeedbackResultPage'), findsOneWidget);
    });

    testWidgets('can submit screenshot feedback', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'sendFeedbackButton');
      await pumpAndTap(tester, 'ideaButton');
      
      delay(2);
      tester.pageBack();
    });

    testWidgets('can open address book', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'addressBookItem');

      expect(findByKey('AddressBookPage'), findsOneWidget);
    });

    testWidgets('can add new address', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await pumpAndTap(tester, 'navActionButton');

      await pumpAndEnterText(tester, 'addressTextField', mxcTestEthAdress);
      await pumpAndEnterText(tester, 'nameTextField', getEnv('DRIVE_TESTING_USER'));
      await pumpAndEnterText(tester, 'memoTextField', 'test: can add new address');

      await pumpAndTap(tester, 'updateButton');

      delay(3);

      expect(findByText(mxcTestEthAdress), findsOneWidget);
    });

  });
}