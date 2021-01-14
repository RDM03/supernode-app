import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/repositories/storage_repository.dart';

class AddressBookState implements Cloneable<AddressBookState> {
  List<AddressEntity> addresses;
  bool selectionMode;

  @override
  AddressBookState clone() {
    return AddressBookState()
      ..addresses = addresses
      ..selectionMode = selectionMode;
  }
}

AddressBookState initState(Map<String, dynamic> args) {
  args ??= {};
  return AddressBookState()
    ..addresses = null
    ..selectionMode = args['selection'] ?? false;
}
