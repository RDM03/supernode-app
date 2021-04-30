import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supernodeapp/main.dart' as app;
import 'package:dotenv/dotenv.dart' show env, load;
import 'login_test.dart' show loginPageTests;
import '../test_driver/finders.dart' show f;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('app boot test', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();
    });
    testWidgets('login help bubble works', (WidgetTester tester) async {
      print('STARTING TESTING');
      await tester.tap(f['landingLogin']);
      print('CLICK QUESTION CIRCLE');
      await tester.tap(f['questionCircle']);
      // find solution for testing all languages
      expect(f['helpTextFinder'], findsOneWidget);
      await tester.tap(f['infoDialog']);
    });
    //await dispose();
  });
}