import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/security/ethereum_utils.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AddAddressState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return pageFrame(context: viewService.context, children: [
    pageNavBar(
      FlutterI18n.translate(_ctx, 'address_book'),
      leadingWidget: GestureDetector(
        key: ValueKey('navBackButton'),
        child: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onTap: () => Navigator.of(_ctx).pop(),
      ),
      actionWidget: Icon(Icons.center_focus_weak),
      onTap: () => dispatch(AddAddressActionCreator.onQr()),
    ),
    bigColumnSpacer(),
    Form(
      key: state.formKey,
      child: Column(children: <Widget>[
        Container(
          child: Text(
            FlutterI18n.translate(_ctx, 'address_book_desc'),
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        SizedBox(height: 40),
        TextFieldWithTitle(
          key: ValueKey('addressTextField'),
          title: FlutterI18n.translate(_ctx, 'address'),
          validator: (v) => v != null
              ? null && Ethereum.isValidEthAddress(v)
              : FlutterI18n.translate(_ctx, 'invalid_address'),
          controller: state.addressController,
        ),
        smallColumnSpacer(),
        TextFieldWithTitle(
          key: ValueKey('nameTextField'),
          title: FlutterI18n.translate(_ctx, 'name'),
          validator: (v) => v != null && v.isNotEmpty
              ? null
              : FlutterI18n.translate(_ctx, 'invalid_name'),
          controller: state.nameController,
        ),
        smallColumnSpacer(),
        TextFieldWithTitle(
          key: ValueKey('memoTextField'),
          title: FlutterI18n.translate(_ctx, 'memo'),
          controller: state.memoController,
        ),
      ]),
    ),
    submitButton(
      FlutterI18n.translate(_ctx, 'update'),
      onPressed: () => dispatch(AddAddressActionCreator.onSave()),
      key: ValueKey('nameTextField'),
    )
  ]);
}
