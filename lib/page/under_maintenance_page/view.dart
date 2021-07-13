import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/utils/auth.dart';
import 'package:supernodeapp/page/under_maintenance_page/action.dart';
import 'package:supernodeapp/theme/theme.dart';
import 'state.dart';
import 'package:supernodeapp/theme/font.dart';

class _UnderMaintenancePageView extends StatelessWidget {
  final VoidCallback onRefresh;
  final VoidCallback onLogOut;
  final bool loading;
  _UnderMaintenancePageView({this.onRefresh, this.onLogOut, this.loading});

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
                  child: Center(
                    child: Image.asset(
                      'assets/images/splash/logo.png',
                      width: 150,
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Image.asset(
                    'assets/images/maintenance/robot.png',
                  ),
                ),
                Spacer(),
                Text(
                  FlutterI18n.translate(context, 'under_maintenance'),
                  style: kPrimaryBigFontOfBlack,
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                PrimaryButton(
                  key: ValueKey('refreshButton'),
                  onTap: loading ? null : onRefresh,
                  buttonTitle: FlutterI18n.translate(context, 'refresh'),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  key: ValueKey('logOutButton'),
                  onTap: loading ? null : onLogOut,
                  child: Text(
                    FlutterI18n.translate(context, 'logout'),
                    style: FontTheme.of(context).middle.secondary(),
                  ),
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

Widget buildView(
    UnderMaintenanceState state, Dispatch dispatch, ViewService viewService) {
  return _UnderMaintenancePageView(
    onRefresh: () => dispatch(UnderMaintenanceActionCreator.refresh()),
    onLogOut: () => dispatch(UnderMaintenanceActionCreator.logOut()),
    loading: state.loading,
  );
}
