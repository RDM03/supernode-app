import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

Future<void> dhxWalletPageTests(){
  group('can get top-up information', () {
    testWidgets('with DHX Wallet', (WidgetTester tester) async {
      // await tester.pump(Duration(seconds: 3));
      await app.main();
      await tester.pumpAndSettle();

      // await tester.pumpAndSettle(Duration(seconds: 3));

      // final Finder dhxDashboardFinder = find.byKey(Key('dhxDashboard'));

      // var res = dhxDashboardFinder.precache();

      final Finder addTokenTitleFinder = find.byKey(Key('addTokenTitle'));

      expect(addTokenTitleFinder, findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(addTokenTitleFinder);


      // print('---eeee------${res}-------');

      // if(!res){
      //   final Finder addTokenTitleFinder = find.byKey(Key('addTokenTitle'));

      //   await tester.tap(addTokenTitleFinder);
      // }

      // await app.main();
      // await tester.pumpAndSettle();
      // await tester.pumpAndSettle(app.main());

      // final Finder dhxDashboardFinder = find.byKey(Key('dhxDashboard'));

      // await tester.pumpAndSettle();

      // await tester.tap(dhxDashboardFinder);

      // await tester.pumpAndSettle();

      // final Finder dhxDepositFinder = find.byKey(Key('dhxDeposit'));

      // await tester.pumpAndSettle();

      // await tester.tap(dhxDepositFinder);

      // expect(find.byKey(Key('ethAddressTopUp')), findsOneWidget);


      // expect(tester.widget(find.byKey(Key('ethAddressTopUp')).), "1");
    });
  });

}