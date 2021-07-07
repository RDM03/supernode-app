import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/utils/currencies.dart';
import 'package:supernodeapp/common/utils/screen_util.dart';
import 'package:supernodeapp/page/home_page/cubit.dart';
import 'package:supernodeapp/page/home_page/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

import 'export_mxc_page.dart';

class ExportDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(context: context, padding: EdgeInsets.all(0.0), children: <
        Widget>[
      ListTile(
          title: Center(
              child: Text(
                  FlutterI18n.translate(context, 'export_financial_data'),
                  style: kBigBoldFontOfBlack)),
          trailing: GestureDetector(
              child: Icon(Icons.close, color: blackColor),
              onTap: () => Navigator.of(context).pop())),
      Divider(height: 1),
      listItem(Token.mxc.name,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          key: Key('export_mxc'),
          onTap: () =>
              Navigator.pushReplacement(context, route((_) => ExportMxcPage())),
          leading: Image.asset(Token.mxc.imagePath, height: s(50))),
      Divider(height: 1),
      BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (a, b) => a.displayTokens != b.displayTokens,
          builder: (ctx, state) => (state.displayTokens
                  .contains(Token.supernodeDhx))
              ? Column(
                  children: [
                    Container(
                        color: backgroundColor,
                        child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            title: Text(Token.supernodeDhx.name,
                                style: kBigFontOfGrey),
                            onTap: () => 'TODO',
                            leading: Image.asset(Token.supernodeDhx.imagePath,
                                height: s(50)),
                            trailing:
                                Icon(Icons.chevron_right, color: greyColor))),
                    Divider(height: 1),
                  ],
                )
              : SizedBox()),
      BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (a, b) => a.displayTokens != b.displayTokens,
          builder: (ctx, state) => (state.displayTokens.contains(Token.btc))
              ? Container(
                  color: backgroundColor,
                  child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      title: Text(Token.btc.name, style: kBigFontOfGrey),
                      onTap: () => 'TODO',
                      leading: Image.asset(Token.btc.imagePath, height: s(50)),
                      trailing: Icon(Icons.chevron_right, color: greyColor)))
              : SizedBox()),
    ]);
  }
}
