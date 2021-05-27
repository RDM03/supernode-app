import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/repositories/storage_repository.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/font.dart';

import 'fiat_list_page.dart';

class ExportMxcPreYearPage extends StatefulWidget {
  final int year;
  ExportMxcPreYearPage(this.year);

  @override
  _ExportMxcPreYearPageState createState() => _ExportMxcPreYearPageState();
}

class _ExportMxcPreYearPageState extends State<ExportMxcPreYearPage> {

  Loading loading;

  @override
  void initState() {
    super.initState();
    final FiatCurrency fiatPreviousSession = context.read<StorageRepository>().selectedFiatForExport();
    context.read<SettingsCubit>().loadFiatCurrencies(fiatPreviousSession);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listenWhen: (a, b) => a.showLoading != b.showLoading,
      listener: (ctx, state) async {
        loading?.hide();
        if (state.showLoading) {
          loading = Loading.show(ctx);
        }
      },
      child: pageFrame(
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
            listItem('${widget.year}',
                trailing: SizedBox()),
            Divider(),
            listItem(FlutterI18n.translate(context, 'time_range'),
                trailing: Text('01.01.${widget.year} - 31.12.${widget.year}', style: kBigFontOfDarkBlue)),
            Divider(),
            listItem(FlutterI18n.translate(context, 'currency'),
                key: Key('currency'),
                onTap: () => Navigator.push(context, route((_) => FiatListPage())),
                trailing: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (a, b) => a.selectedFiat != b.selectedFiat,
                  builder: (context, state) {
                    return Text((state.selectedFiat == null) ? '--' : state.selectedFiat.id.toUpperCase(), style: kBigFontOfDarkBlue);
                  },
                )),
            Divider(),
            listItem(FlutterI18n.translate(context, 'decimals'),
                trailing: SizedBox()),
            Divider(),
            SizedBox(height: 200),
            PrimaryButton(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              minWidth: double.infinity,
              onTap: () => 'TODO',
              buttonTitle: FlutterI18n.translate(context, 'export')),
          ]),
    );
  }
}
