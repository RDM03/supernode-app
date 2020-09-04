import 'package:fish_redux/fish_redux.dart';

enum AddressDetailsAction { onDelete, onCopy }

class AddressDetailsActionCreator {
  static Action onDelete() {
    return const Action(AddressDetailsAction.onDelete);
  }

  static Action onCopy() {
    return const Action(AddressDetailsAction.onCopy);
  }
}
