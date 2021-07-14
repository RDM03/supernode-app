import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/council_card.dart';
import 'package:supernodeapp/common/components/page/link.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    JoinCouncilState state, Dispatch dispatch, ViewService viewService) {
  final context = viewService.context;

  return GestureDetector(
    key: Key('joinCouncilView'),
    onTap: () =>
        FocusScope.of(viewService.context).unfocus(),
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
          style: FontTheme.of(context).big(),
        ),
        SizedBox(height: 4),
        Text(
          FlutterI18n.translate(context, 'join_council_tip_1'),
          style: FontTheme.of(context).middle.secondary(),
        ),
        SizedBox(height: 4),
        Text(
          FlutterI18n.translate(context, 'join_council_tip_2'),
          style: FontTheme.of(context).middle.secondary(),
        ),
        Link(
          FlutterI18n.translate(context, 'become_council_chair'),
          alignment: Alignment.centerLeft,
          key: ValueKey('becomeCouncilLink'),
          onTap: () => dispatch(JoinCouncilActionCreator.becomeCouncilChair()),
        ),
        SizedBox(height: 20),
        if (state.councils?.isNotEmpty ?? true) ...[
          Text(
            FlutterI18n.translate(context, 'council_lists'),
            style: FontTheme.of(context).big(),
          ),
          SizedBox(height: 20),
        ],
        if (state.councils == null)
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: CircularProgressIndicator(
                key: ValueKey('circularProgressIndicator'),
                valueColor:
                    AlwaysStoppedAnimation(ColorsTheme.of(context).dhxBlue),
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
            style: FontTheme.of(ctx).middle.dhx(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'no_councils_description'),
            style: FontTheme.of(ctx).small.secondary(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_list'),
            style: FontTheme.of(ctx).middle(),
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'got_it'),
          style: FontTheme.of(ctx).big.secondary(),
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
            style: FontTheme.of(ctx).middle.dhx(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_not_meet_1'),
            style: FontTheme.of(ctx).small.secondary(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_list'),
            style: FontTheme.of(ctx).small(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_not_meet_2'),
            style: FontTheme.of(ctx).small.secondary(),
          ),
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text(
          FlutterI18n.translate(ctx, 'OK'),
          style: FontTheme.of(ctx).big.secondary(),
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
            style: FontTheme.of(ctx).middle.dhx(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_1'),
            style: FontTheme.of(ctx).small.secondary(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_list'),
            style: FontTheme.of(ctx).small(),
          ),
          SizedBox(height: 10),
          Text(
            FlutterI18n.translate(ctx, 'council_requirments_2'),
            style: FontTheme.of(ctx).small.secondary(),
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
          style: FontTheme.of(ctx).big.secondary(),
        ),
        onPressed: () => Navigator.of(ctx).pop(),
      ),
    ),
  );
  return res == true;
}
