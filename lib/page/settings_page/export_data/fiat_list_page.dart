import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class FiatListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return pageFrame(
        context: context,
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          ListTile(
            title: Center(
                child: Text(FlutterI18n.translate(context, 'select_currency'),
                    style: kBigBoldFontOfBlack)),
            trailing: GestureDetector(
                child: Icon(Icons.close, color: blackColor),
                onTap: () => Navigator.of(context).pop()),
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            buildWhen: (a, b) => a.listFiat != b.listFiat,
            builder: (context, state) {
              List<Widget> listFiatWidgets = [];
              state.listFiat?.forEach((e) => {
                    listFiatWidgets.add(Container(
                      color: (e.id == state.selectedFiat.id)
                          ? colorMxc10
                          : transparentWhite,
                      child: listItem(
                        '${e.id.toUpperCase()} - ${e.description}',
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        onTap: () {
                          context.read<SettingsCubit>().setFiatCurrency(e);
                          Navigator.of(context).pop();
                        },
                        trailing: Icon(Icons.check,
                            color: (e.id == state.selectedFiat.id)
                                ? blackColor
                                : greyColor),
                      ),
                    )),
                    listFiatWidgets.add(Divider(height: 1))
                  });
              return Column(
                children: listFiatWidgets,
              );
            },
          ),
        ]);
  }
}
