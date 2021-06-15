import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class FormatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
        context: context,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          ListTile(
            title: Center(
                child: Text(FlutterI18n.translate(context, 'select_format'),
                    style: kBigBoldFontOfBlack)),
            trailing: GestureDetector(
                child: Icon(Icons.close, color: Colors.black),
                onTap: () => Navigator.of(context).pop()),
          ),
          Divider(height: 1),
          BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (a, b) => a.format != b.format,
              builder: (context, state) =>
                  Container(
                    color: (state.format == 'pdf') ? dartBlueColor.withOpacity(0.1) : transparentWhite,
                    child: listItem('PDF',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onTap: () { context.read<SettingsCubit>().setFormat('pdf');
                        Navigator.of(context).pop();},
                        trailing: Icon(Icons.check, color: (state.format == 'pdf') ? Colors.black : Colors.grey)),
                  )),
          Divider(height: 1),
          BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (a, b) => a.format != b.format,
              builder: (context, state) =>
                  Container(
                    color: (state.format == 'csv') ? dartBlueColor.withOpacity(0.1) : transparentWhite,
                    child: listItem('CSV',
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onTap: () { context.read<SettingsCubit>().setFormat('csv');
                        Navigator.of(context).pop();},
                        trailing: Icon(Icons.check, color: (state.format == 'csv') ? Colors.black : Colors.grey)),
                  )),
          Divider(height: 1),
        ]);
  }
}