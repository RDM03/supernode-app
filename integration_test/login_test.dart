import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

Future<void> loginPageTests(){
  group('can login', () {
    testWidgets('with demo', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();
        
      final Finder demologinFinder = find.byKey(Key('demo_login'));
      await tester.pumpAndSettle();
      await tester.tap(demologinFinder);
      await tester.pumpAndSettle();

      //allow to use the location
      // final Finder locationFinder = find.text('Allow While Using App');
      // await tester.pumpAndSettle(Duration(seconds: 3));
      // await tester.tap(locationFinder);
      // await tester.pumpAndSettle();

      expect(find.text('username'), findsOneWidget);

      // await tester.pump();
      // final Finder addTokenTitleFinder = find.byKey(Key('addTokenTitle'));

      // expect(addTokenTitleFinder, findsOneWidget);

      // // await tester.pump();
      // await tester.tap(addTokenTitleFinder);

    });
  });

}