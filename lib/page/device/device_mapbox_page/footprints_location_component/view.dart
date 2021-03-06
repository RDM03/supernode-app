import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    FootPrintsLocationState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  var list = List<IosButtonStyle>();
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'more')));
  list.add(
      IosButtonStyle(title: FlutterI18n.translate(_ctx, 'reset_to_default')));
  list.add(IosButtonStyle(
    title: FlutterI18n.translate(_ctx, 'delete_this_footprint'),
    style: FontTheme.of(_ctx).middle.alert(),
  ));

  return MediaQuery.removePadding(
    removeTop: true,
    context: viewService.context,
    child: Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            ListTile(
              leading: Text(
                FlutterI18n.translate(_ctx, 'location'),
                style: FontTheme.of(_ctx).middle(),
              ),
              trailing: InkWell(
                onTap: () {
                  showDialog(
                    context: _ctx,
                    builder: (BuildContext context) {
                      return FullScreenDialog(
                        child: IosStyleBottomDialog(
                          blueActionIndex: 0,
                          list: list,
                          onItemClickListener: (index) {
                            //remove all
                            if (index == list.length - 1) {}
                          },
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.more_horiz,
                  size: 25,
                ),
              ),
            ),
            ListTile(
              leading: Text(
                'Br??ckenstra??e 12 10967 Berlin Germany',
                style: FontTheme.of(_ctx).middle.secondary(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Spreading Factor: SF11 \r\nFrequency:490.1MHz \r\nUplink Power: 14dBm \r\nDownlink Power: 14dBm \r\nSensitivity: -135dBm \r\nSNR: -15 dB \r\nRecevied Gateway: M2****1243,M2****FIOS \r\nDistance:14km \r\nType: Join',
                style: FontTheme.of(_ctx).middle.secondary(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 30),
              child: Row(
                children: <Widget>[
                  Text(
                    'Altitude:',
                    style: FontTheme.of(_ctx).middle.secondary(),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 65,
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'm',
                    style: FontTheme.of(_ctx).middle.secondary(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.only(bottom: 40, left: 16, right: 16),
            color: whiteColor,
            child: PrimaryButton(
              minHeight: 35,
              padding: EdgeInsets.symmetric(vertical: 5),
              buttonTitle: FlutterI18n.translate(_ctx, 'confirm_location'),
              bgColor: Color.fromRGBO(28, 20, 120, 1),
              onTap: () {},
            ),
          ),
        )
      ],
    ),
  );
}
