import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/introduction.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/select_picker.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_button.dart';
import 'package:supernodeapp/common/components/text_field/text_field_with_title.dart';
import 'package:supernodeapp/common/utils/log.dart';
import 'package:supernodeapp/common/utils/reg.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    OrganizationsState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  if (state.selectedOrgId != null) {
    dispatch(OrganizationsActionCreator.selectedItem(
        state.list[0].organizationID, state.list[0].organizationName));
  }
  return pageFrame(context: viewService.context, children: [
    pageNavBar(FlutterI18n.translate(_ctx, 'organization_setting'),
        onTap: () => Navigator.of(viewService.context).pop()),
    bigColumnSpacer(),
    Form(
      key: state.formKey,
      child: Column(children: <Widget>[
        TextFieldWithTitle(
          title: FlutterI18n.translate(_ctx, 'organization_name'),
          validator: (value) => _validName(_ctx, value),
          controller: state.orgNameCtl..text,
        ),
        smallColumnSpacer(),
        TextFieldWithTitle(
          title: FlutterI18n.translate(_ctx, 'display_name'),
          validator: (value) => _validName(_ctx, value),
          controller: state.orgDisplayCtl,
        ),
        smallColumnSpacer(),
        textfieldWithButton(
            readOnly: true,
            inputLabel: FlutterI18n.translate(_ctx, 'organization_list'),
            isDivider: false,
            icon: Icons.expand_more,
            controller: state.orgListCtl,
            onTap: () => _selectItem(viewService.context,
                data: state.list,
                onSelected: (id, name) => dispatch(
                    OrganizationsActionCreator.selectedItem(id, name)))),
      ]),
    ),
    introduction(FlutterI18n.translate(_ctx, 'switch_organization'), top: 5),
    submitButton(FlutterI18n.translate(_ctx, 'update'),
        onPressed: () => dispatch(OrganizationsActionCreator.onUpdate()))
  ]);
}

String _validName(BuildContext context, String value) {
  String res = Reg.isEmpty(value);
  if (res != null) {
    return FlutterI18n.translate(context, res);
  }

  return null;
}

void _selectItem(context, {List data, Function onSelected}) {
  List idArr = [];
  List displayNameArr = data.map((item) {
    idArr.add(item.organizationID);
    return item.organizationName;
  }).toList();

  selectPicker(context, data: displayNameArr, onSelected: (index) {
    mLog('organizationName', index);
    onSelected(idArr[index], displayNameArr[index]);
  });
}
