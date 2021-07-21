import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/page/page_nav_bar.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/theme.dart';

class FiatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
        context: context,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          PageNavBar.settings(
            text: FlutterI18n.translate(context, 'select_currency'),
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.listFiat != b.listFiat,
            builder: (context, state) {
              return Column(
                children: [
                  for (final fiat in state.listFiat)
                    Container(
                      child: listItem(
                        '${fiat.id.toUpperCase()} - ${fiat.description}',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onTap: () {
                          context.read<SettingsCubit>().setFiatCurrency(fiat);
                          Navigator.of(context).pop();
                        },
                        trailing: Icon(Icons.check,
                            color: (fiat.id == state.selectedFiat.id)
                                ? ColorsTheme.of(context).mxcBlue
                                : ColorsTheme.of(context).boxComponents),
                      ),
                    ),
                ],
              );
            },
          ),
        ]);
  }
}
