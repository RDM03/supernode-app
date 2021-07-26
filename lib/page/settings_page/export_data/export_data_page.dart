import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

import 'export_mxc_page.dart';

class ExportDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        PageNavBar.settings(
          text: FlutterI18n.translate(context, 'export_financial_data'),
        ),
        listItem(Token.mxc.ui(context).name,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            key: Key('export_mxc'),
            onTap: () => Navigator.pushReplacement(
                context, routeWidget(ExportMxcPage())),
            leading: Image(image: Token.mxc.ui(context).image, height: s(50))),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (a, b) => a.displayTokens != b.displayTokens,
          builder: (ctx, state) => (state.displayTokens
                  .contains(Token.supernodeDhx))
              ? Column(
                  children: [
                    Container(
                      color: ColorsTheme.of(context).primaryBackground,
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        title: Text(Token.supernodeDhx.ui(context).name,
                            style: FontTheme.of(context).big.secondary()),
                        onTap: () => 'TODO',
                        leading: Image(
                            image: Token.supernodeDhx.ui(context).image,
                            height: s(50)),
                        trailing: Icon(Icons.chevron_right,
                            color: ColorsTheme.of(context).textLabel),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (a, b) => a.displayTokens != b.displayTokens,
          builder: (ctx, state) => (state.displayTokens.contains(Token.btc))
              ? Container(
                  color: ColorsTheme.of(context).primaryBackground,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    title: Text(Token.btc.ui(context).name,
                        style: FontTheme.of(context).big.secondary()),
                    onTap: () => 'TODO',
                    leading: Image(
                        image: Token.btc.ui(context).image, height: s(50)),
                    trailing: Icon(Icons.chevron_right,
                        color: ColorsTheme.of(context).textLabel),
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }
}
