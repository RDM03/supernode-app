import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';

enum AddressBookAction { onSelect, onAdd, onDetails, setAddresses }

class AddressBookActionCreator {
  static Action onSelect(AddressEntity address) {
    return Action(AddressBookAction.onSelect, payload: address);
  }

  static Action onDetails(AddressEntity address) {
    return Action(AddressBookAction.onDetails, payload: address);
  }

  static Action onAdd() {
    return Action(AddressBookAction.onAdd);
  }

  static Action setAddresses(List<AddressEntity> addresses) {
    return Action(AddressBookAction.setAddresses, payload: addresses);
  }
}
