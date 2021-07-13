import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class FormatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(context: context, padding: EdgeInsets.all(0.0), children: <
        Widget>[
      ListTile(
        title: Center(
          child: Text(
            FlutterI18n.translate(context, 'select_format'),
            style: FontTheme.of(context).big.primary.bold(),
          ),
        ),
        trailing: GestureDetector(
            child: Icon(Icons.close, color: blackColor),
            onTap: () => Navigator.of(context).pop()),
      ),
      Divider(height: 1),
      BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.format != b.format,
          builder: (context, state) => Container(
                color: (state.format == 'pdf') ? colorMxc10 : transparentWhite,
                child: listItem('PDF',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: () {
                  context.read<SettingsCubit>().setFormat('pdf');
                  Navigator.of(context).pop();
                },
                    trailing: Icon(Icons.check,
                        color:
                            (state.format == 'pdf') ? blackColor : greyColor)),
              )),
      Divider(height: 1),
      BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (a, b) => a.format != b.format,
          builder: (context, state) => Container(
                color: (state.format == 'csv') ? colorMxc10 : transparentWhite,
                child: listItem('CSV',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    onTap: () {
                  context.read<SettingsCubit>().setFormat('csv');
                  Navigator.of(context).pop();
                },
                    trailing: Icon(Icons.check,
                        color:
                            (state.format == 'csv') ? blackColor : greyColor)),
              )),
      Divider(height: 1),
    ]);
  }
}
