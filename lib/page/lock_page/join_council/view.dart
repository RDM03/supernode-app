import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/page/submit_button.dart';
import 'package:supernodeapp/common/components/text_field/primary_text_field.dart';
import 'package:supernodeapp/common/utils/reg.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    JoinCouncilState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('lockAmountView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
      context: viewService.context,
      scaffoldKey: state.scaffoldKey,
      children: [
        pageNavBar(FlutterI18n.translate(context, 'dhx_mining')),
        SizedBox(height: 30),
        Text(
          FlutterI18n.translate(context, 'join_a_council'),
          style: kPrimaryBigFontOfBlack,
        ),
        SizedBox(height: 4),
        Text(
          FlutterI18n.translate(context, 'join_council_tip_1'),
          style: kMiddleFontOfGrey,
        ),
        SizedBox(height: 4),
        Text(
          FlutterI18n.translate(context, 'join_council_tip_2'),
          style: kMiddleFontOfGrey,
        ),
        link(
          FlutterI18n.translate(context, 'become_council_chair'),
          alignment: Alignment.centerLeft,
          key: ValueKey('becomeCouncilLink'),
          onTap: () => _showBecomeCouncilChair(state.scaffoldKey.currentState),
        ),
        link(
          FlutterI18n.translate(context, 'trigger sorry'),
          alignment: Alignment.centerLeft,
          key: ValueKey('becomeCouncilLink'),
          onTap: () => _showNoCouncils(state.scaffoldKey.currentState),
        ),
        link(
          FlutterI18n.translate(context, 'trigger doesn\'t meet requirments'),
          alignment: Alignment.centerLeft,
          key: ValueKey('becomeCouncilLink'),
          onTap: () =>
              _showDoesntMeetRequirments(state.scaffoldKey.currentState),
        ),
        SizedBox(height: 20),
        Text(
          FlutterI18n.translate(context, 'council_lists'),
          style: kPrimaryBigFontOfBlack,
        ),
        SizedBox(height: 20),
        for (var i = 0; i < 10; i++) ...[
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(10)),
                      color: Color(0xFF4665EA),
                    ),
                    child: Center(
                      child: FaIcon(
                        FontAwesomeIcons.landmark,
                        color: Colors.white,
                      ),
                    ),
                    width: 56,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1724***.com',
                          style: kBigFontOfBlue,
                        ),
                        Text(
                          'MatchX (Germany)',
                          style: kMiddleFontOfBlack,
                        ),
                        Text(
                          'Latest mPower : 5000000',
                          style: kMiddleFontOfBlack,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
        ],
        submitButton(
          FlutterI18n.translate(context, 'confirm'),
          top: 5,
          onPressed: () => dispatch(JoinCouncilActionCreator.onConfirm()),
          key: ValueKey('submitButton'),
        )
      ],
    ),
  );
}

_showNoCouncils(ScaffoldState scaffoldState) {
  showCupertinoModalPopup(
    context: scaffoldState.context,
    builder: (ctx) => CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(ctx, 'sorry'),
            style: kMiddleFontOfBlue,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'no_councils_description'),
            style: kSmallFontOfGrey,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_list'),
            style: kMiddleFontOfBlack,
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'got_it'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ),
  );
}

_showDoesntMeetRequirments(ScaffoldState scaffoldState) {
  showCupertinoModalPopup(
    context: scaffoldState.context,
    builder: (ctx) => CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(ctx, 'sorry'),
            style: kMiddleFontOfBlue,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_not_meet_1'),
            style: kSmallFontOfGrey,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_list'),
            style: kSmallFontOfBlack,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_not_meet_2'),
            style: kSmallFontOfGrey,
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'OK'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ),
  );
}

_showBecomeCouncilChair(ScaffoldState scaffoldState) {
  showCupertinoModalPopup(
    context: scaffoldState.context,
    builder: (ctx) => CupertinoActionSheet(
      message: Column(
        children: [
          Text(
            FlutterI18n.translate(ctx, 'congratulations'),
            style: kMiddleFontOfBlue,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_1'),
            style: kSmallFontOfGrey,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_list'),
            style: kSmallFontOfBlack,
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_2'),
            style: kSmallFontOfGrey,
          ),
        ],
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text(FlutterI18n.translate(ctx, 'become_council_chair')),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'cancel_normalized'),
          style: kBigFontOfGrey,
        ),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ),
  );
}
