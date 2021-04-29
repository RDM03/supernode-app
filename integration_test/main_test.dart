import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:supernodeapp/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('passing test', (WidgetTester tester) async {
      await app.main();
      await tester.pumpAndSettle();
      expect(1 + 1, equals(2));
    });
  });

}
