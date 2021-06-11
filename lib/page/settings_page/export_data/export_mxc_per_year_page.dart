import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supernodeapp/common/components/buttons/primary_button.dart';
import 'package:supernodeapp/common/components/loading.dart';
import 'package:supernodeapp/common/components/page/page_frame.dart';
import 'package:supernodeapp/common/components/settings/list_item.dart';
import 'package:supernodeapp/common/repositories/storage_repository.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/user.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/state.dart';
import 'package:supernodeapp/page/settings_page/export_data/csv_viewer_page.dart';
import 'package:supernodeapp/page/settings_page/export_data/pdf_viewer_page.dart';
import 'package:supernodeapp/route.dart';
import 'package:supernodeapp/theme/font.dart';

import 'fiat_list_page.dart';
import 'format_list_page.dart';

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
    context.read<SettingsCubit>().initExportMxcPreYearPage(widget.year, fiatPreviousSession);
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
            listItem(FlutterI18n.translate(context, 'format'),
                key: Key('format'),
                onTap: () => Navigator.push(context, route((_) => FormatListPage())),
                trailing: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (a, b) => a.format != b.format,
                  builder: (context, state) => Text(state.format.toUpperCase(), style: kBigFontOfDarkBlue),
                )),
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
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  GestureDetector(
                      child: Icon(Icons.remove_circle_outline),
                      onTap: () => context.read<SettingsCubit>().changeDataExportDecimals(-1)),
                  SizedBox(width: 20),
                  BlocBuilder<SettingsCubit, SettingsState>(
                    buildWhen: (a, b) => a.decimals != b.decimals,
                    builder: (context, state) {
                      return Text('${state.decimals < 10 ? '0' : ''}${state.decimals}', style: kBigFontOfDarkBlue);
                    },
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                      child: Icon(Icons.add_circle_outline),
                      onTap: () => context.read<SettingsCubit>().changeDataExportDecimals(1)),
                ])),
            Divider(),
            SizedBox(height: 125),
            PrimaryButton(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              minWidth: double.infinity,
              onTap: () async {
                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                  status = await Permission.storage.status;
                }
                if (status.isGranted) {
                  final String filePath = await context.read<SettingsCubit>().getDataExport();
                  if (filePath.isNotEmpty) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>
                        (filePath.isNotEmpty && context.read<SettingsCubit>().state.format == "pdf")
                            ? PDFViewerPage(filePath: filePath)
                            : CsvViewerPage(csvPath: filePath)
                        )
                    );
                  }
                }
              },
              buttonTitle: FlutterI18n.translate(context, 'export')),
          ]),
    );
  }
}