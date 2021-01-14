import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'action.dart';
import 'state.dart';

Effect<AddressDetailsState> buildEffect() {
  return combineEffects(<Object, Effect<AddressDetailsState>>{
    AddressDetailsAction.onDelete: _onDelete,
    AddressDetailsAction.onCopy: _onCopy,
  });
}

void _onDelete(Action action, Context<AddressDetailsState> ctx) async {
  final addresses = ctx.context.read<StorageRepository>().addressBook();
  final equal = addresses.firstWhere((e) => e == ctx.state.entity);

  if (equal != null) {
    addresses.remove(equal);
    ctx.context.read<StorageRepository>().setAddressBook(addresses);
  }

  Navigator.of(ctx.context).pop();
}

void _onCopy(Action action, Context<AddressDetailsState> ctx) async {
  Clipboard.setData(ClipboardData(text: ctx.state.entity.address));

  ctx.state.scaffoldKey.currentState.showSnackBar(
    SnackBar(content: Text(FlutterI18n.translate(ctx.context, 'has_copied'))),
  );
}
