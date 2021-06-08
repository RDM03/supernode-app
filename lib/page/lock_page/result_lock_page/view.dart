import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/page/done.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/title.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

import 'state.dart';

Widget buildView(
    ResultLockPageState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('lockAmountView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
        context: viewService.context,
        scrollable: false,
        margin: EdgeInsets.only(top: 60),
        children: [
          pageNavBar(
            FlutterI18n.translate(context, state.title),
            leadingWidget: SizedBox(),
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(height: 10),
          title(FlutterI18n.translate(context, 'confirmed')),
          done(color: colorSupernodeDhx),
          SizedBox(height: 30),
          Visibility(
            visible: state.transactionId.isNotEmpty,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    FlutterI18n.translate(context, 'transaction_id') +
                        ': ' +
                        state.transactionId,
                    style: kPrimaryBigFontOfBlack,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              FlutterI18n.translate(context, state.content),
              key: Key('congratsMiningText'),
              style: kBigFontOfGrey,
              textAlign: TextAlign.center,
            ),
          )
        ],
        floatingActionButton: PrimaryButton(
            key: ValueKey('submitButton'),
            padding: kRoundRow1005,
            buttonTitle: FlutterI18n.translate(context, 'done'),
            bgColor: colorSupernodeDhx,
            minWidth: double.infinity,
            onTap: () => Navigator.pop(viewService.context, true))),
  );
}
