import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDNav extends StatelessWidget {
  final String title;
  final bool hasBack;
  final bool hasClose;

  const DDNav({
    Key key,
    @required this.title,
    this.hasBack = false,
    this.hasClose = false
  }): super(key: key);

  @override
  Widget build(Object context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Visibility(
        visible: hasBack,
        child: GestureDetector(
          child: Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          onTap: () => Navigator.of(context).pop()
        )
      ),
      title: Center(
        child: Text(
          FlutterI18n.translate(context, title),
          style: kBigBoldFontOfBlack
        )
      ),
      actions: <Widget>[
        Visibility(
          visible: hasClose,
          child: GestureDetector(
            child: Padding(
              padding: kInnerRowRight20,
              child: Icon(Icons.close, color: Colors.black)
            ),
            onTap: () => Navigator.of(context).pop()
          ),
        )
      ],
    );
  }

}