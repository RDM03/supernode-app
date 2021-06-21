import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:oktoast/oktoast.dart';
import 'package:share/share.dart';
import 'package:supernodeapp/common/components/app_bars/sign_up_appbar.dart';
import 'package:supernodeapp/page/settings_page/bloc/settings/cubit.dart';

class PDFViewerPage extends StatefulWidget {
  final String filePath;

  const PDFViewerPage({
    Key key,
    @required this.filePath,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  Future<PDFDocument> future;

  @override
  void initState() {
    future = PDFDocument.fromFile(File(widget.filePath));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.backArrowAndActionAppBar(
        title: FlutterI18n.translate(context, 'export_financial_data'),
        onPress: () => Navigator.of(context).pop(),
        action: IconButton(
          icon: Icon(Icons.save_alt),
          color: Colors.black,
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          FutureBuilder<PDFDocument>(
            future: future,
            builder: (ctx, snap) => snap.hasData
                ? PDFViewer(
                    document: snap.data,
                    showPicker: false,
                  )
                : Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            bottom: 3 + MediaQuery.of(context).viewPadding.bottom,
            child: FloatingActionButton(
              child: Icon(Icons.ios_share),
              onPressed: () {
                Share.shareFiles([widget.filePath]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
