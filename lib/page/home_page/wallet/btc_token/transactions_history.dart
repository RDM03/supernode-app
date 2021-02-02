import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/empty.dart';
import 'package:supernodeapp/common/components/panel/panel_frame.dart';

class TransactionsHistoryContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PanelFrame(
      rowTop: EdgeInsets.zero,
      child: Empty(),
    );
  }
}
