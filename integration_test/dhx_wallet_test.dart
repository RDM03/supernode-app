import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';


Future<void> dhxWalletPageTests(){
  group('DHX Wallet', () {
    testWidgets('can get top-up information', (WidgetTester tester) async {
      await delay(5);
      await app.main();

      await delay(3);
      if (!isExisted('dhxDashboard')) {
        await pumpAndTap(tester,'addTokenTitle');
        await pumpAndTap(tester,'addDHX');
      }

      await delay(3);
      await pumpAndTap(tester,'dhxDashboard');
      await pumpAndTap(tester,'dhxDeposit', firstWidget: true);

      await delay(3);
      await pumpUntilFound(tester,findByKey('ethAddressTopUp'));

      if (getEnv('ENVIRONMENT') == 'test') {
        //this is the eth address of text@mxc.org.
        expect(findByText(mxcTestEthAdress),findsOneWidget);
      }
    }, timeout: timeout());

    testWidgets('can submit withdraw request', (WidgetTester tester) async {
      await delay(5);
      await app.main();
      
      await delay(3);
      await pumpAndTap(tester,'dhxDashboard');
      await pumpAndTap(tester,'dhxWithdraw',firstWidget: true);

      await delay(3);
      await pumpAndEnterText(tester,'withdrawAmountInput','1');
      await pumpAndEnterText(tester,'sendToAddressInput',mxcTestEthAdress);
      await pumpAndTap(tester,'requestWithdrawButton');

    }, timeout: timeout());
  });

}