import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/dialog/full_screen_dialog.dart';
import 'package:supernodeapp/common/components/page/page_body.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';
import 'package:supernodeapp/common/components/picker/ios_style_bottom_dailog.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'action.dart';
import 'state.dart';

const dartBlue = Color.fromRGBO(28, 20, 120, 1);

Widget buildView(
    ChooseApplicationState state, Dispatch dispatch, ViewService viewService) {
  var _ctx = viewService.context;
  var list = List<IosButtonStyle>();
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'ai_camera')));
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'fire_detect')));
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'waste_detect')));
  list.add(IosButtonStyle(title: FlutterI18n.translate(_ctx, 'human_detect')));

  return Builder(
    builder: (context) {
      return Scaffold(
        body: pageBody(children: [
          Container(
            padding: EdgeInsets.only(top: kToolbarHeight, bottom: 10, left: 10),
            child: Text(
              FlutterI18n.translate(_ctx, 'device_choose'),
              style: kBigFontOfBlack,
            ),
          ),
          panelFrame(
            child: _buildPanelItem(
              icon: Icons.camera_enhance,
              title: list[state.selectCameraIndex].title,
              trailing: Icon(
                Icons.keyboard_arrow_down,
                size: 30,
                color: Colors.black,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext _) {
                    return FullScreenDialog(
                      child: IosStyleBottomDialog(
                        context: context,
                        blueActionIndex: state.selectCameraIndex,
                        list: list,
                        onItemClickListener: (index) {
                          dispatch(
                              ChooseApplicationActionCreator.onChangeCamera(
                                  index));
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          panelFrame(
            customPanelColor: (state.smartWatchName?.isEmpty ?? true)
                ? null
                : Color.fromRGBO(77, 137, 229, 0.2),
            child: _buildPanelItem(
              icon: Icons.watch,
              title: (state.smartWatchName?.isEmpty ?? true)
                  ? FlutterI18n.translate(_ctx, 'smart_watch')
                  : state.smartWatchName,
              onTap: () {
                showDialog(
                  context: _ctx,
                  builder: (context) {
                    return _buildSmartDialog(_ctx, dispatch);
                  },
                );
              },
            ),
          ),
          panelFrame(
            child: _buildImagePanelItem(
              leading: ImageIcon(
                AssetImage('assets/images/device/solid-camera.png'),
                color: Colors.white,
              ),
              title: FlutterI18n.translate(_ctx, 'smart_door_lock'),
            ),
          ),
          panelFrame(
            child: _buildPanelItem(
              icon: Icons.directions_car,
              title: FlutterI18n.translate(_ctx, 'smart_parking'),
            ),
          ),
          SizedBox(height: 30),
          _buildButton(
            onPressed: () {
              Navigator.pop(_ctx);
            },
            title: FlutterI18n.translate(_ctx, "update"),
          ),
          SizedBox(height: 20),
          _buildButton(
            onPressed: () {
              Navigator.pop(_ctx);
            },
            title: FlutterI18n.translate(_ctx, "device_cancel"),
          ),
        ]),
      );
    },
  );
}

Widget _buildButton({VoidCallback onPressed, String title}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: shodowColor,
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: Text(
        title ?? "",
        style: kBigFontOfDarkBlue,
      ),
    ),
  );
}

Widget _buildSmartDialog(BuildContext ctx, Dispatch dispatch) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Container(
      margin: EdgeInsets.only(top: 10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: dartBlue,
              shape: BoxShape.circle,
            ),
            width: 44,
            height: 44,
          ),
          Positioned(
            child: Icon(
              Icons.bluetooth,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    content: Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text.rich(
            TextSpan(
              style: kMiddleFontOfGrey,
              children: [
                TextSpan(
                  text: FlutterI18n.translate(ctx, 'device_bluetooth_prompt') +
                      " ",
                ),
                TextSpan(
                    text: FlutterI18n.translate(ctx, 'bluetooth'),
                    style: kMiddleFontOfBlueLink),
                TextSpan(
                  text: " " + FlutterI18n.translate(ctx, 'is_turned_on'),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildSmartCard(
                  onTap: () {
                    Navigator.pop(ctx);
                    dispatch(
                      ChooseApplicationActionCreator.setSmartWatch(
                          'ORACLEID_1234567'),
                    );
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildSmartCard(
                  onTap: () {
                    Navigator.pop(ctx);
                    dispatch(
                      ChooseApplicationActionCreator.setSmartWatch(
                          'ORACLEID_1234567'),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildSmartCard(
                  onTap: () {
                    Navigator.pop(ctx);
                    dispatch(
                      ChooseApplicationActionCreator.setSmartWatch(
                          'ORACLEID_1234567'),
                    );
                  },
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: _buildSmartCard(
                  onTap: () {
                    Navigator.pop(ctx);
                    dispatch(
                      ChooseApplicationActionCreator.setSmartWatch(
                          'ORACLEID_1234567'),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildSmartCard({VoidCallback onTap}) {
  return InkWell(
    onTap: () {
      onTap?.call();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              offset: Offset(0, 2),
              blurRadius: 7.0)
        ],
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 5),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.watch,
            size: 24,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'ORACLEID_1234567',
              textAlign: TextAlign.center,
              style: kSmallFontOfGrey,
            ),
          ),
          Text(
            'LoRa Watch',
            style: kSmallFontOfGrey,
          ),
        ],
      ),
    ),
  );
}

Widget _buildPanelItem(
    {IconData icon, String title, Widget trailing, VoidCallback onTap}) {
  return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      leading: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: dartBlue,
              shape: BoxShape.circle,
            ),
            width: 44,
            height: 44,
          ),
          Positioned(
            child: Icon(
              icon ?? Icons.not_interested,
              size: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
      title: Text(
        title ?? "",
        style: kBigFontOfBlack,
      ),
      trailing: trailing);
}

Widget _buildImagePanelItem(
    {Widget leading, String title, Widget trailing, VoidCallback onTap}) {
  return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      leading: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: dartBlue,
              shape: BoxShape.circle,
            ),
            width: 44,
            height: 44,
          ),
          Positioned(
            child: leading,
          ),
        ],
      ),
      title: Text(
        title ?? "",
        style: kBigFontOfBlack,
      ),
      trailing: trailing);
}
