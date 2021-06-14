import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

class CsvViewerPage extends StatelessWidget {
  final String csvPath;
  List<List<String>> csvData;
  String disclaimer;

  CsvViewerPage({this.csvPath}) {
    loadCsv(csvPath);
  }

  void loadCsv(String path) {
    List<List<String>> data = [];
    File csvFile = File(path);
    data = csvFile.readAsLinesSync().map((e) => e.split(",")).toList();
    disclaimer = data[data.length - 1][0];
    int longest = data.map((e) => e.length).reduce(max);
    data.map((e) => e.addAll(List.filled(longest - e.length, ''))).cast<List<String>>().toList();
    csvData = data.getRange(0, data.length - 1).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(csvPath, maxLines: 3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Table(
              border: TableBorder.all(width: 1.0),
              children: csvData.map((item) {
                return TableRow(
                    children: item.map((row) => Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            row.toString(),
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                      )
                    ).toList());
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