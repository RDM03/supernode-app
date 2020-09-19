import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

class AddAddressState implements Cloneable<AddAddressState> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();

  @override
  AddAddressState clone() {
    return AddAddressState()
      ..formKey = formKey
      ..addressController = addressController
      ..nameController = nameController
      ..memoController = memoController;
  }
}

AddAddressState initState(Map<String, dynamic> args) {
  return AddAddressState();
}
