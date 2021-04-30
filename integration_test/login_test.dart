import 'package:dotenv/dotenv.dart' show load, env;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test_driver/finders.dart' show f;
import '../test_driver/utils.dart' show delay, canTap, isPresent;

loginPageTests(String server, String password) {

    testWidgets('login help bubble works', (WidgetTester tester) async {
      print('STARTING ' + server + ' TESTING');
      await tester.tap(f['landingLogin']);
      print('CLICK QUESTION CIRCLE');
      await tester.tap(f['questionCircle']);
      // find solution for testing all languages
      expect(f['helpTextFinder'], findsOneWidget);
      await tester.tap(f['infoDialog']);
    });

    testWidgets('can login', (WidgetTester tester) async {
      print('LOCATING THE MXC LOGO');
      if (server == 'MXCtest' || server == 'MXCbuild') {
        print('LOADED, BEGINNING THE TAP');
        for (var i = 0; i < 7; i++) {
          await tester.tap(f['logoFinder']);
          delay(20);
          print('TAP ${i + 1}');
        }
      }
      print('LETS SELECT THAT SERVER');
      await tester.tap(f['menuFinder']);
      // await delay(2000);
      // var openMenuState = await canTap(find.byKey(Key(server)), tester);
      // if (openMenuState == false) {
      //   await tester.scrollUntilVisible(find.byKey(Key(server)));
      //   openMenuState = await canTap(find.byKey(Key(server)), tester);
      // }
      print('DELAY');
      await delay(2000);

      // if (await openMenuState == true) {
      //   print('SERVER SELECTED');
      // } else {
      //   print("OOPS THE MENU CLOSED, I'LL JUST OPEN THAT UP FOR YOU");
      //   await tester.tap(f['menuFinder']);
      //   await delay(2000);
      //   await tester.tap(find.byKey(Key(server)));
      //   await delay(2000);
      //   print('SERVER SELECTED, TIME TO ENTER CREDENTIALS');
      // }
      // await tester.enterText(f['emailFieldFinder'], env['DRIVE_TESTING_USER']);
      // print('ENTERED EMAIL ADDRESS');
      // await tester.tap(f['passwordFieldFinder']);
      // print('TAPPED PASSWORD FIELD');
      // await tester.enterText(f['passwordFieldFinder'], password);
      // print('THE MOMENT HAS COME, WILL IT WORK?');
      // await tester.tap(f['loginFinder']);
      // print('HOUSTON, WE ARE LOGGED IN');
      // expect(await tester.getText(f['homeProfile']),
      //     'Hi, ' + env['DRIVE_TESTING_USER']);
    });
}

