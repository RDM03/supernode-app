import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'dhx_wallet_test.dart';
import 'login_test.dart';
import 'settings_test.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  await loginPageTests();
  await dhxWalletPageTests();
  // await settingsTests();
}