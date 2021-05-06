import 'dart:async';

import 'package:dotenv/dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

loginPageTests(){

  group('Authentication', () {
    testWidgets('can login with username/password', (WidgetTester tester) async {

      await app.main();
      await tester.pumpAndSettle();
    
      bool hasLogin = isExisted('login');

      if (DotEnv().env['ENVIRONMENT'] == 'test' && hasLogin) {
        await pumpAndTap(tester,'login');

        await pumpAndTap(tester,'login_title',tapCount: 7);

        await pumpAndTap(tester,'homeSupernodeMenu');
        await pumpAndTap(tester,'Test');
        await pumpAndTap(tester,'MXCtest');

        await pumpAndEnterText(tester,'homeEmail',DotEnv().env['DRIVE_TESTING_USER']);
        await pumpAndEnterText(tester,'homePassword',DotEnv().env['DRIVE_MXCTEST_PASSWORD']);

        await pumpAndTap(tester,'homeLogin');
      }

    });
  });

}