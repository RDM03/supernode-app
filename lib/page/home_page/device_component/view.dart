import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/loading_list.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/page/home_page/device_component/action.dart';

import '../action.dart';
import 'state.dart';

Widget buildView(
    DeviceState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  final ListAdapter adapter = viewService.buildAdapter();
  var list = List<IosButtonStyle>();
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'sort_by')));
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'name')));
  list.add(
      IosButtonStyle(title: FlutterI18n.translate(_ctx, 'type_of_device')));
  list.add(IosButtonStyle(
      title: FlutterI18n.translate(_ctx, 'online_offline_status')));
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'last_seen')));
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'downlink_fee')));

  return Scaffold(
    appBar: homeBar(
      FlutterI18n.translate(_ctx, 'device'),
      action: IconButton(
        icon: Icon(
          Icons.filter_list,
          color: Colors.black,
        ),
        onPressed: () {
          showDialog(
            context: _ctx,
            builder: (BuildContext context) {
              return FullScreenDialog(
                child: IosStyleBottomDialog(
                  context: _ctx,
                  blueActionIndex: 0,
                  list: list,
                  onItemClickListener: (index) {
                    dispatch(DeviceActionCreator.changeDeviceSortType(index));
                  },
                ),
              );
            },
          );
        },
      ),
    ),
    body: RefreshIndicator(
      displacement: 10,
      onRefresh: () async {},
      child: pageBody(
        children: [
          panelFrame(
            child: panelBody(
                loading: false,
                icon: Icons.add_circle,
                onPressed: () {
                  if (state.isDemo) dispatch(DeviceActionCreator.onQrScan());
                },
                titleText: FlutterI18n.translate(_ctx, 'total_device'),
                subtitleText: '${adapter.itemCount}',
                trailTitle: FlutterI18n.translate(_ctx, 'downlink_fee'),
                trailSubtitle: '88 MXC (8.8 USD)'),
          ),
          panelFrame(
            child: adapter.itemCount != 0
                ? ListView.builder(
                    itemBuilder: adapter.itemBuilder,
                    itemCount: adapter.itemCount,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  )
                : empty(_ctx),
          ),
//          panelFrame(
//            child: empty(_ctx),
//          ),
//          panelFrame(
//            child: LoadingList(),
//          ),
        ],
      ),
    ),
  );
}
