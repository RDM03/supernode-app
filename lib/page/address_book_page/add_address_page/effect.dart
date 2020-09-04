import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:majascan/majascan.dart';
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/utils/storage_manager_native.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'action.dart';
import 'state.dart';

Effect<AddAddressState> buildEffect() {
  return combineEffects(<Object, Effect<AddAddressState>>{
    AddAddressAction.onSave: _onSave,
    AddAddressAction.onQr: _onQr,
  });
}

void _onSave(Action action, Context<AddAddressState> ctx) async {
  if (!ctx.state.formKey.currentState.validate()) return;
  ctx.state.formKey.currentState.save();
  final addresses = StorageManager.addressBook();
  addresses.add(AddressEntity(
    address: ctx.state.addressController.text,
    memo: ctx.state.memoController.text,
    name: ctx.state.nameController.text,
  ));
  StorageManager.setAddressBook(addresses);
  Navigator.of(ctx.context).pop();
}

void _onQr(Action action, Context<AddAddressState> ctx) async {
  String qrResult = await MajaScan.startScan(
      title: FlutterI18n.translate(ctx.context, 'scan_code'),
      barColor: buttonPrimaryColor,
      titleColor: backgroundColor,
      qRCornerColor: buttonPrimaryColor,
      qRScannerColor: buttonPrimaryColorAccent);
  ctx.dispatch(AddAddressActionCreator.setAddress(qrResult));
}
