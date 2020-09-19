import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:supernodeapp/common/utils/address_entity.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'action.dart';
import 'state.dart';

Effect<AddressBookState> buildEffect() {
  return combineEffects(<Object, Effect<AddressBookState>>{
    AddressBookAction.onAdd: _onAdd,
    AddressBookAction.onSelect: _onSelect,
    AddressBookAction.onDetails: _onDetails,
  });
}

void _onAdd(Action action, Context<AddressBookState> ctx) async {
  await Navigator.pushNamed(
    ctx.context,
    'add_address_page',
  );
  ctx.dispatch(
      AddressBookActionCreator.setAddresses(StorageManager.addressBook()));
}

void _onSelect(Action action, Context<AddressBookState> ctx) async {
  if (ctx.state.selectionMode) {
    Navigator.of(ctx.context).pop(action.payload);
  } else {
    await _openDetails(action.payload, ctx);
  }
}

void _onDetails(Action action, Context<AddressBookState> ctx) async {
  await _openDetails(action.payload, ctx);
}

Future<void> _openDetails(
    AddressEntity entity, Context<AddressBookState> ctx) async {
  await Navigator.of(ctx.context).pushNamed(
    'address_details_page',
    arguments: {'entity': entity.toMap()},
  );
  ctx.dispatch(
      AddressBookActionCreator.setAddresses(StorageManager.addressBook()));
}
