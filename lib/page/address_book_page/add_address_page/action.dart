import 'package:fish_redux/fish_redux.dart';

enum AddAddressAction { onQr, onSave, setAddress }

class AddAddressActionCreator {
  static Action onQr() {
    return const Action(AddAddressAction.onQr);
  }

  static Action onSave() {
    return const Action(AddAddressAction.onSave);
  }

  static Action setAddress(String address) {
    return Action(AddAddressAction.setAddress, payload: address);
  }
}
