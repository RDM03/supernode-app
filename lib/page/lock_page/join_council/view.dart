import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    JoinCouncilState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('joinCouncilView'),
    onTap: () =>
        FocusScope.of(viewService.context).requestFocus(new FocusNode()),
    child: pageFrame(
      context: viewService.context,
      scaffoldKey: state.scaffoldKey,
      children: [
        pageNavBar(
          FlutterI18n.translate(context, 'dhx_mining'),
          onTap: () => Navigator.of(context).pop(),
        ),
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
          onTap: () => dispatch(JoinCouncilActionCreator.becomeCouncilChair()),
        ),
        SizedBox(height: 20),
        if (state.councils?.isNotEmpty ?? true) ...[
          Text(
            FlutterI18n.translate(context, 'council_lists'),
            style: kPrimaryBigFontOfBlack,
          ),
          SizedBox(height: 20),
        ],
        if (state.councils == null)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(
                key: ValueKey('circularProgressIndicator'),
                valueColor: AlwaysStoppedAnimation(Color(0xFF4665EA)),
              ),
            ),
          )
        else
          for (var i = 0; i < state.councils.length; i++) ...[
            Container(
              height: 80,
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
              child: InkWell(
                onTap: () => dispatch(
                    JoinCouncilActionCreator.onConfirm(state.councils[i])),
                key: ValueKey('councilItem#$i'),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(10)),
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
                              state.councils[i].name,
                              style: kBigFontOfBlue,
                            ),
                            Text(
                              '${FlutterI18n.translate(context, 'latest_mpower')} : ${FlutterI18n.translate(context, 'coming')}',
                              style: kMiddleFontOfBlack,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
      ],
    ),
  );
}

showNoCouncilsDialog(ScaffoldState scaffoldState) {
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

showDoesntMeetRequirmentsDialog(ScaffoldState scaffoldState) {
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

Future<bool> showBecomeCouncilChairDialog(ScaffoldState scaffoldState) async {
  final res = await showCupertinoModalPopup(
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
          onPressed: () => Navigator.of(ctx).pop(true),
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
  return res == true;
}
