import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class FormatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
      context: context,
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        PageNavBar.settings(
          text: FlutterI18n.translate(context, 'select_format'),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.format != b.format,
          builder: (context, state) => Container(
            child: listItem(
              'PDF',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () {
                context.read<SettingsCubit>().setFormat('pdf');
                Navigator.of(context).pop();
              },
              trailing: Icon(Icons.check,
                  color: (state.format == 'pdf')
                      ? ColorsTheme.of(context).mxcBlue
                      : ColorsTheme.of(context).boxComponents),
            ),
          ),
        ),
        BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.format != b.format,
          builder: (context, state) => Container(
            child: listItem(
              'CSV',
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              onTap: () {
                context.read<SettingsCubit>().setFormat('csv');
                Navigator.of(context).pop();
              },
              trailing: Icon(Icons.check,
                  color: (state.format == 'csv')
                      ? ColorsTheme.of(context).mxcBlue
                      : ColorsTheme.of(context).boxComponents),
            ),
          ),
        ),
      ],
    );
  }
}
