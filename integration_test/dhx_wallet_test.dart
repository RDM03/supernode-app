import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supernodeapp/main.dart' as app;

import 'common.dart';

dhxWalletPageTests(){
  group('can get top-up information', () {
    testWidgets('with DHX Wallet', (WidgetTester tester) async {
      await delay(3);
      await app.main();

      await pumpAndTap(tester,'addTokenTitle');

      await idle(tester);
    });
  });

}