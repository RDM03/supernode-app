import 'dart:async';

import 'package:dotenv/dotenv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/log.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

Future<void> loginPageTests(){
  // group('can login', () {
    // testWidgets('with demo', (WidgetTester tester) async {
    //   await app.main();
    //   await tester.pumpAndSettle();
        
    //   final Finder demologinFinder = find.byKey(Key('demo_login'));
    //   await tester.pumpAndSettle();
    //   await tester.tap(demologinFinder);
    //   await tester.pumpAndSettle();

    //   //allow to use the location
    //   // final Finder locationFinder = find.text('Allow While Using App');
    //   // await tester.pumpAndSettle(Duration(seconds: 3));
    //   // await tester.tap(locationFinder);
    //   // await tester.pumpAndSettle();

    //   expect(find.text('username'), findsOneWidget);

    //   // await tester.pump();
    //   // final Finder addTokenTitleFinder = find.byKey(Key('addTokenTitle'));

    //   // expect(addTokenTitleFinder, findsOneWidget);

    //   // // await tester.pump();
    //   // await tester.tap(addTokenTitleFinder);

    // });

  group('can login', () {
    testWidgets('with supernode', (WidgetTester tester) async {

      await app.main();
      await tester.pumpAndSettle();
    
      bool hasLogin = find.byKey(Key('login')).precache();

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