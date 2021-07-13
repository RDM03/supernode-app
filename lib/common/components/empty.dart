import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class Empty extends StatefulWidget {
  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('noData'),
      alignment: Alignment.center,
      height: 50,
      child: Text(
        FlutterI18n.translate(context, 'no_data'),
        style: FontTheme.of(context).middle.secondary(),
      ),
    );
  }
}
