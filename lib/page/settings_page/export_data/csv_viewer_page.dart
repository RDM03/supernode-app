import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:oktoast/oktoast.dart';
import 'package:share/share.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';
import 'package:supernodeapp/theme/colors.dart';

class CsvViewerPage extends StatefulWidget {
  final String filePath;

  CsvViewerPage({this.filePath});

  @override
  _CsvViewerPageState createState() => _CsvViewerPageState();
}

class _CsvViewerPageState extends State<CsvViewerPage> {
  List<List<String>> csvData;
  String disclaimer;

  @override
  void initState() {
    super.initState();
    loadCsv(widget.filePath);
  }

  void loadCsv(String path) async {
    File csvFile = File(path);
    final data = await csvFile
        .readAsLines()
        .then((d) => d.map((e) => e.split(",")).toList());
    disclaimer = data[data.length - 1][0];
    int longest = data.map((e) => e.length).reduce(max);
    data
        .map((e) => e.addAll(List.filled(longest - e.length, '')))
        .cast<List<String>>()
        .toList();
    csvData = data.getRange(0, data.length - 1).toList();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAndActionAppBar(
        title: FlutterI18n.translate(context, 'export_financial_data'),
        onPress: () => Navigator.of(context).pop(),
        action: IconButton(
          icon: Icon(Icons.save_alt),
          color: blackColor,
          onPressed: () async {
            final newPath = await context.read<SettingsCubit>().exportData();
            showToast(
              newPath,
              textStyle: TextStyle(fontSize: 14),
              duration: Duration(seconds: 3),
              position: ToastPosition.bottom,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.share),
        onPressed: () {
          Share.shareFiles([widget.filePath]);
        },
      ),
      body: csvData == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  Table(
                    border: TableBorder.all(width: 1.0),
                    children: csvData.map((item) {
                      return TableRow(
                          children: item
                              .map((row) => Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        row.toString(),
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  ))
                              .toList());
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  Text(disclaimer),
                ],
              ),
            ),
    );
  }
}
