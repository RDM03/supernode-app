import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/utils/network_util.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class _ConnectivityLostPageView extends StatelessWidget {
  void _refresh(BuildContext context) async {
    await NetworkUtil.instance.refresh();
    if (NetworkUtil.instance.hasNet) {
      Navigator.of(context)
          .popUntil((route) => route.settings.name != 'connectivity_lost_page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    'assets/images/connectivity/connectivity.png',
                    color: ColorsTheme.of(context).textSecondary,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Image.asset(
                    'assets/images/connectivity/robot.png',
                  ),
                ),
                Spacer(),
                Text(
                  FlutterI18n.translate(context, 'connectivity_lost'),
                  style: FontTheme.of(context).big(),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                PrimaryButton(
                  key: ValueKey('refreshButton'),
                  onTap: () {
                    _refresh(context);
                  },
                  buttonTitle: FlutterI18n.translate(context, 'refresh'),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildView(bool state, Dispatch dispatch, ViewService viewService) {
  return _ConnectivityLostPageView();
}
