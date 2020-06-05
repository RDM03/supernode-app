import 'package:fish_redux/fish_redux.dart';

enum QRCodeAction { onContinue }

class QRCodeActionCreator {
  static Action onContinue() {
    return const Action(QRCodeAction.onContinue);
  }
}