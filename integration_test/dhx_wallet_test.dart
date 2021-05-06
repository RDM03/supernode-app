import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

dhxWalletPageTests(){
  group('DHX Wallet', () {
    testWidgets('can get top-up information', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      if (!isExisted('dhxDashboard')) {
        await pumpAndTap(tester,'addTokenTitle');
        await pumpAndTap(tester,'addDHX');
      }

      await delay(3);
      await pumpAndTap(tester,'dhxDashboard');
      await pumpAndTap(tester,'dhxDeposit');

      await delay(3);
      await pumpUntilFound(tester,findByKey('ethAddressTopUp'));
      
      expect(findByText('5FErYFbRFsQJyMVP4sMYCpFih6nYY4B1pSYKR2eB4TeqZ13J'), findsOneWidget);
    });
  });

}