import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/council_card.dart';
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
            CouncilCard(
              key: ValueKey('councilItem#$i'),
              onTap: () => dispatch(
                  JoinCouncilActionCreator.onConfirm(state.councils[i])),
              council: state.councils[i],
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
