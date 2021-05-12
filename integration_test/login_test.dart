import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

Future<void> loginTest(WidgetTester tester) async {
  bool hasLogin = isExisted('login');

  if (getEnv('ENVIRONMENT') == 'test' && hasLogin) {
    await pumpAndTap(tester, 'login');

    await pumpAndTap(tester, 'login_title', tapCount: 7);

    await pumpAndTap(tester, 'homeSupernodeMenu');
    await pumpAndTap(tester, 'Test');
    await pumpAndTap(tester, 'MXCtest');

    await pumpAndEnterText(tester, 'homeEmail', getEnv('DRIVE_TESTING_USER'));
    await pumpAndEnterText(tester, 'homePassword', getEnv('DRIVE_MXCTEST_PASSWORD'));

    await pumpAndTap(tester, 'homeLogin');

    await delay(3);
    expect(findByText(getEnv('DRIVE_TESTING_USER')), findsOneWidget);
  }
}

Future<void> loginPageTests(){

  group('Authentication', () {
    testWidgets('can login with username/password', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();
      WidgetController.hitTestWarningShouldBeFatal = true;
    
      await loginTest(tester);

    }, timeout: timeout());
  });

}