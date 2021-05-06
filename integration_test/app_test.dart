import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'dhx_wallet_test.dart';
import 'login_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
        as IntegrationTestWidgetsFlutterBinding;

  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  loginPageTests();
  dhxWalletPageTests();
}