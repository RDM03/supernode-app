import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/app_cubit.dart';
import 'package:supernodeapp/app_state.dart';
import 'package:supernodeapp/common/components/app_bars/home_bar.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/common/utils/utils.dart';
import 'package:supernodeapp/page/home_page/device/list_item/list_item.dart';

class DeviceTab extends StatefulWidget {
  @override
  _DeviceTabState createState() => _DeviceTabState();
}

class _DeviceTabState extends State<DeviceTab> {
  Future<void> onQrScan() async {
    String qrResult = await Tools.scanQr(context);
    Navigator.pushNamed(context, 'choose_application_page');
  }

  void showFilterDialog(BuildContext context) {
    final buttonsList = [
      IosButtonStyle(title: FlutterI18n.translate(context, 'sort_by')),
      IosButtonStyle(title: FlutterI18n.translate(context, 'name')),
      IosButtonStyle(title: FlutterI18n.translate(context, 'type_of_device')),
      IosButtonStyle(
          title: FlutterI18n.translate(context, 'online_offline_status')),
      IosButtonStyle(title: FlutterI18n.translate(context, 'last_seen')),
      IosButtonStyle(title: FlutterI18n.translate(context, 'downlink_fee')),
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) => FullScreenDialog(
        child: IosStyleBottomDialog(
          blueActionIndex: 0,
          list: buttonsList,
          onItemClickListener: (index) {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeBar(
        FlutterI18n.translate(context, 'device'),
        action: IconButton(
          icon: Icon(
            Icons.filter_list,
            color: Colors.black,
          ),
          onPressed: () => showFilterDialog(context),
        ),
      ),
      body: RefreshIndicator(
        displacement: 10,
        onRefresh: () async {},
        child: PageBody(
          children: [
            BlocBuilder<SupernodeCubit, SupernodeState>(
              buildWhen: (a, b) => a.session.isDemo != b.session.isDemo,
              builder: (context, state) => PanelFrame(
                child: PanelBody(
                  loading: false,
                  icon: Icons.add_circle,
                  onPressed: state.session.isDemo ? () => onQrScan() : null,
                  titleText: FlutterI18n.translate(context, 'total_device'),
                  subtitleText: '0',
                  trailTitle: FlutterI18n.translate(context, 'downlink_fee'),
                  trailSubtitle: '88 MXC (8.8 USD)',
                ),
              ),
            ),
            BlocBuilder<SupernodeCubit, SupernodeState>(
              buildWhen: (a, b) => a.session.isDemo != b.session.isDemo,
              builder: (context, state) => PanelFrame(
                child: state.session.isDemo
                    ? ListView.builder(
                        itemBuilder: (ctx, i) => DeviceListItem(),
                        itemCount: 3,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                      )
                    : Empty(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
