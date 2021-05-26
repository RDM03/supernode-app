import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/font.dart';

import 'export_mxc_per_year_page.dart';

class ExportMxcPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
        context: context,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          ListTile(
            title: Center(
                child: Text(FlutterI18n.translate(context, 'export_financial_data'),
                    style: kBigBoldFontOfBlack)),
            trailing: GestureDetector(
                child: Icon(Icons.close, color: Colors.black),
                onTap: () => Navigator.of(context).pop()),
          ),
          listItem(FlutterI18n.translate(context, 'select_year_to_export'),
              trailing: SizedBox(),
              onTap: () => ''),
          Divider(),
          listItem('2021',
              key: Key('year_2021'),
              onTap: () => Navigator.pushReplacement(context, route((_) => ExportMxcPreYearPage(2021)))),
          Divider(),
          listItem('2020',
              key: Key('year_2020'),
              onTap: () => Navigator.pushReplacement(context, route((_) => ExportMxcPreYearPage(2020)))),
          Divider(),
        ]);
  }
}