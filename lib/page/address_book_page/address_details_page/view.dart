import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/column_spacer.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    AddressDetailsState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  return pageFrame(
    scaffoldKey: state.scaffoldKey,
    context: viewService.context,
    children: [
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
      ),
      bigColumnSpacer(),
      Container(
        child: Text(
          FlutterI18n.translate(_ctx, 'address_book_control_desc'),
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
      SizedBox(height: 40),
      _titled(
        FlutterI18n.translate(_ctx, 'address'),
        state.entity.address,
        trailing: SizedBox(
          width: 30,
          child: IconButton(
            key: ValueKey('copyButton'),
            icon: Icon(Icons.content_copy),
            onPressed: () => dispatch(AddressDetailsActionCreator.onCopy()),
          ),
        ),
      ),
      middleColumnSpacer(),
      _titled(FlutterI18n.translate(_ctx, 'name'), state.entity.name),
      middleColumnSpacer(),
      _titled(FlutterI18n.translate(_ctx, 'memo'), state.entity.memo),
      SizedBox(height: 40),
      GestureDetector(
        key: ValueKey('deleteButton'),
        child: Text(
          FlutterI18n.translate(_ctx, 'delete_address'),
          style: kMiddleFontOfRed.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
        onTap: () => dispatch(AddressDetailsActionCreator.onDelete()),
      )
    ],
  );
}

Widget _titled(String title, String content, {Widget trailing}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: kMiddleFontOfBlack,
      ),
      SizedBox(
        height: 2,
      ),
      Row(
        children: [
          Expanded(
            child: SelectableText(
              content,
              style: kMiddleFontOfGrey,
            ),
          ),
          if (trailing != null) trailing,
        ],
      )
    ],
  );
}
