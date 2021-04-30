import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supernodeapp/main.dart' as app;
import 'package:dotenv/dotenv.dart' show env, load;
import '../test_driver/finders.dart' show f;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('login help bubble works', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();
      await Future.delayed(Duration(seconds: 3)); // wait for loading
      await tester.pumpAndSettle();
      print('STARTING TESTING');
      await tester.tap(f['landingLogin']);
      await tester.pumpAndSettle();
      print('CLICK QUESTION CIRCLE');
      await tester.tap(f['questionCircle']);
      // find solution for testing all languages
      await Future.delayed(Duration(seconds: 1));
      expect(f['helpTextFinder'], findsOneWidget);
      print('will fail');
      await tester.tap(f['infoDialog']);
    });
    //await dispose();
  });
}
